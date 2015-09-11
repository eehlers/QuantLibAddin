
// For most of the QuantLib index classes, we have handwritten code in
// the QuantLibAddin layer to provide custom behavior.  This file defines
// all of the constructors and memberfunctions of the QuantLibAddin
// wrapper classes.  See also indexes2.i.

%pragma(reposit) group="indexes";
%pragma(reposit) override_obj="true";

namespace QuantLibAddin {

    class Index {
        public:
            void addFixings(const std::vector<QuantLib::Date>& dates,
                            const std::vector<QuantLib::Real>& values,
                            bool forceOverwrite);
            double fixing(const QuantLib::Date& fixingDate,
                                bool forecastTodaysFixing);
            //QuantLib::Calendar fixingCalendar();
            std::string fixingCalendar();
    };

    class InterestRateIndex : public Index {};
    
    class IborIndex : public InterestRateIndex {};
    
    class SwapIndex : public InterestRateIndex {
        public:
            SwapIndex(const std::string& familyName,
                      const QuantLib::Period& p,
                      QuantLib::Natural fixingDays,
                      QuantLib::Currency& crr,
                      const QuantLib::Calendar& calendar,
                      const QuantLib::Period& fixedLegTenor,
                      QuantLib::BusinessDayConvention fixedLegBDC,
                      const QuantLib::DayCounter& fixedLegDayCounter,
                      const boost::shared_ptr<QuantLib::IborIndex>& index,
                      const QuantLib::Handle<QuantLib::YieldTermStructure>& disc);
    };

    class LiborSwap : public SwapIndex {
        public:
            LiborSwap(
                const QuantLib::Currency& currency,
                SwapIndex::FixingType fixingType,
                const QuantLib::Period& p,
                const QuantLib::Handle<QuantLib::YieldTermStructure>& f,
                const QuantLib::Handle<QuantLib::YieldTermStructure>& d);
    };
        
    class OvernightIndex : public IborIndex {};
    
    class Euribor : public IborIndex {
        public:
            Euribor(const QuantLib::Period& tenor,
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve);
    };

    class Eonia : public OvernightIndex {
        public:
            Eonia(const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve);
    };
    
    class EuriborSwapIsdaFixA : public SwapIndex {
      public:
            EuriborSwapIsdaFixA(const QuantLib::Period& tenor,
                                const QuantLib::Handle<QuantLib::YieldTermStructure>& forwarding,
                                const QuantLib::Handle<QuantLib::YieldTermStructure>& discounting);
    };
}
