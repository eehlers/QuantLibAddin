
%group(ratehelpers);
%override

%insert(ratehelpers_serialization_cpp) %{
#include <qlo/objmanual_indexes.hpp>
#include <qlo/obj_termstructures.hpp>
%}

namespace QuantLib {

    class RateHelper {
      public:
        Date earliestDate();
        Date latestDate();
    };
}

namespace QuantLibAddin {

    class RateHelper {
      public:
        std::string quoteName();
        QuantLib::Real quoteValue();
    };

    class FuturesRateHelper : public RateHelper {
      public:
        FuturesRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& price,
            QuantLib::Futures::Type type,
            const QuantLib::Date& immDate,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
            const QuantLib::Handle<QuantLib::Quote>& convAdj);
    };

    class DepositRateHelper : public RateHelper {
        %rename(DepositRateHelper2)
        DepositRateHelper(const QuantLib::Handle<QuantLib::Quote>&,
                          const QuantLib::Period&,
                          QuantLib::Natural,
                          const QuantLib::Calendar&,
                          QuantLib::BusinessDayConvention,
                          bool,
                          const QuantLib::DayCounter&);
      public:
        DepositRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& rate,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex);
        DepositRateHelper(const QuantLib::Handle<QuantLib::Quote>& rate,
                          const QuantLib::Period& tenor,
                          QuantLib::Natural fixingDays,
                          const QuantLib::Calendar& calendar,
                          QuantLib::BusinessDayConvention convention,
                          bool endOfMonth,
                          const QuantLib::DayCounter& dayCounter);
    };

    class SwapRateHelper : public RateHelper {
      public:
        SwapRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& rate,
            QuantLib::Natural settlementDays,
            const QuantLib::Period& tenor,
            const QuantLib::Calendar& calendar,
            const QuantLib::Frequency& fixedFrequency,
            QuantLib::BusinessDayConvention fixedConvention,
            const QuantLib::DayCounter& fixedDayCounter,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
            const QuantLib::Handle<QuantLib::Quote>& spread,
            const QuantLib::Period& forwardStart,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount);
     };

    class FraRateHelper : public RateHelper {
      public:
        FraRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& rate,
            QuantLib::Period periodToStart,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex);
    };

    class OISRateHelper : public RateHelper {
      public:
        OISRateHelper(
            QuantLib::Natural settlementDays,
            const QuantLib::Period& tenor,
            const QuantLib::Handle<QuantLib::Quote>& fixedRate,
            const boost::shared_ptr<QuantLib::OvernightIndex>& overnightIndex,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount);
    };

    class DatedOISRateHelper : public RateHelper {
      public:
        DatedOISRateHelper(
            const QuantLib::Date& startDate,
            const QuantLib::Date& endDate,
            const QuantLib::Handle<QuantLib::Quote>& fixedRate,
            const boost::shared_ptr<QuantLib::OvernightIndex>& overnightIndex,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount);
    };

    std::vector<std::string> rateHelperSelection(
        const std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> >& qlarhs,
        const std::vector<QuantLib::Natural>& priority,
        QuantLib::Natural nImmFutures,
        QuantLib::Natural nSerialFutures,
        QuantLib::Natural frontFuturesRollingDays,
        RateHelper::DepoInclusionCriteria depoInclusionCriteria,
        const std::vector<QuantLib::Natural>& minDistance);

    QuantLib::Real rateHelperRate(
        const boost::shared_ptr<QuantLibAddin::RateHelper>& qlarh);
}

