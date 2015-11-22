
#ifndef obj_ratehelpers_hpp
#define obj_ratehelpers_hpp

#include <string>
#include <rp/libraryobject.hpp>
#include <rp/valueobject.hpp>
//#include <boost/shared_ptr.hpp>
//#include <ql/quotes/simplequote.hpp>
//#include <ql/quotes/lastfixingquote.hpp>
//#include <ql/quotes/futuresconvadjustmentquote.hpp>
//#include <ql/math/comparison.hpp>
#include <ql/termstructures/yield/oisratehelper.hpp>

namespace QuantLibAddin {

    class RateHelper : public reposit::LibraryObject<QuantLib::RateHelper> {
      public:
        enum DepoInclusionCriteria {AllDepos,
                                    DeposBeforeFirstFuturesStartDate,
                                    DeposBeforeFirstFuturesStartDatePlusOne,
                                    DeposBeforeFirstFuturesExpiryDate
        };
        std::string quoteName() { return quoteName_; }
        QuantLib::Real quoteValue();
        QuantLib::Date earliestDate();
        QuantLib::Date latestDate();
      protected:
        RP_LIB_CTOR(RateHelper, QuantLib::RateHelper);
        std::string quoteName_;
    };

    class DepositRateHelper : public RateHelper {
      public:
        DepositRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::Quote>& rate,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
            bool permanent);
        DepositRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::Quote>& quote,
            const QuantLib::Period& p,
            QuantLib::Natural settlementDays,
            const QuantLib::Calendar& calendar,
            QuantLib::BusinessDayConvention convention,
            bool endOfMonth,
            const QuantLib::DayCounter& dayCounter,
            bool permanent);
    };

    class FuturesRateHelper : 
        public RateHelper {
    public:
        FuturesRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::Quote > const &price,
            QuantLib::Futures::Type type,
            QuantLib::Date const &immDate,
            boost::shared_ptr< QuantLib::IborIndex > const &iborIndex,
            QuantLib::Handle< QuantLib::Quote > const &convAdj,
            // END   typemap rp_tm_default
            bool permanent);
    };

    class SwapRateHelper : public RateHelper {
      public:
        SwapRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::Quote>& quote,
            const boost::shared_ptr<QuantLib::SwapIndex>& swapIndex,
            const QuantLib::Handle<QuantLib::Quote>& spread,
            const QuantLib::Period& forwardStart,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,
            QuantLib::Pillar::Choice pillarChoice,
            QuantLib::Date customPillar,
            bool permanent);
        SwapRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::Quote>& quote,
            QuantLib::Natural settlementDays,
            const QuantLib::Period& p,
            const QuantLib::Calendar& calendar,
            const QuantLib::Frequency& fixedFrequency,
            QuantLib::BusinessDayConvention fixedConvention,
            const QuantLib::DayCounter& fixedDayCounter,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
            const QuantLib::Handle<QuantLib::Quote>& spread,
            const QuantLib::Period& forwardStart,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,
            QuantLib::Pillar::Choice pillarChoice,
            QuantLib::Date customPillar,
            bool permanent);
     };

    class FraRateHelper : 
        public RateHelper {
    public:
        FraRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            QuantLib::Handle< QuantLib::Quote > const &rate,
            QuantLib::Period periodToStart,
            boost::shared_ptr< QuantLib::IborIndex > const &iborIndex,
            QuantLib::Pillar::Choice pillarChoice,
            QuantLib::Date customPillar,
            bool permanent);
        FraRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::Quote>& rate,
            QuantLib::Period periodToStart,
            QuantLib::Natural lengthInMonths,
            QuantLib::Natural fixingDays,
            const QuantLib::Calendar& calendar,
            QuantLib::BusinessDayConvention convention,
            bool endOfMonth,
            const QuantLib::DayCounter& dayCounter,
            QuantLib::Pillar::Choice pillarChoice,
            QuantLib::Date customPillar,
            bool permanent);
    };

    class OISRateHelper : 
        public RateHelper {
    public:
        OISRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Natural settlementDays,
            QuantLib::Period const &tenor,
            QuantLib::Handle< QuantLib::Quote > const &fixedRate,
            boost::shared_ptr< QuantLib::OvernightIndex > const &overnightIndex,
            QuantLib::Handle< QuantLib::YieldTermStructure > const &discount,
            // END   typemap rp_tm_default
            bool permanent);
    };

    class DatedOISRateHelper : 
        public RateHelper {
    public:
        DatedOISRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Date const &startDate,
            QuantLib::Date const &endDate,
            QuantLib::Handle< QuantLib::Quote > const &fixedRate,
            boost::shared_ptr< QuantLib::OvernightIndex > const &overnightIndex,
            QuantLib::Handle< QuantLib::YieldTermStructure > const &discount,
            // END   typemap rp_tm_default
            bool permanent);
    };


    // Processes the set of curve bootstrapping instruments
    // and selects a subset according to the given rules and parameters
    std::vector<std::string> rateHelperSelection(
        const std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> >& qlarhs,
        const std::vector<QuantLib::Natural>& priority,
        QuantLib::Natural nImmFutures,
        QuantLib::Natural nSerialFutures,
        QuantLib::Natural frontFuturesRollingDays,
        RateHelper::DepoInclusionCriteria depoInclusionCriteria,
        const std::vector<QuantLib::Natural>& minDistance);

    // Returns the rate, if any, associated to the given rate helper
    // FIXME I think this could be implemented as a member function of QuantLibAddin::RateHelper
    QuantLib::Real rateHelperRate(
        const boost::shared_ptr<QuantLibAddin::RateHelper>& qlarh);

} // namespace QuantLibAddin

#endif

