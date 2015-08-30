
%feature("rp:group", "indexes");

%feature("rp:obj_include") %{
#include <ql/indexes/ibor/euribor.hpp>
#include <ql/indexes/ibor/eonia.hpp>
#include <ql/indexes/swapindex.hpp>
#include <ql/indexes/swap/euriborswap.hpp>
#include <qlo/objmanual_indexes2.hpp>
%}

namespace QuantLib {
   
    class InterestRateIndex : public Index {
        public:
        QuantLib::Natural fixingDays();
        const QuantLib::DayCounter& dayCounter();
    };
    
    class IborIndex : public InterestRateIndex {};
    class SwapIndex : public InterestRateIndex {};
    
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

%feature("rp:obj_include", "");
%feature("rp:group", "");

