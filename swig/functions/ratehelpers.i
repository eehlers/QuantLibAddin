
%feature("rp:group", "ratehelpers");

%feature("rp:override_obj");

namespace QuantLib {

    class RateHelper {
      public:
        QuantLib::Date earliestDate();
        QuantLib::Date latestDate();
    };
}

namespace QuantLibAddin {

    class RateHelper {};
    
    class FuturesRateHelper : public RateHelper {
      public:
        FuturesRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& price,
            QuantLib::Futures::Type type,
            const QuantLib::Date& immDate,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
            const QuantLib::Handle<QuantLib::Quote>& convAdj);
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
}

%feature("rp:override_obj", "");
%feature("rp:group", "");
