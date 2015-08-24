
%feature("rp:group", "ratehelpers");

%feature("rp:override_obj");

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
}

%feature("rp:override_obj", "");
%feature("rp:group", "");
