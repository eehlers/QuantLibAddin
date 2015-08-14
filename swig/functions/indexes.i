
%feature("rp:group", "indexes");

%feature("rp:obj_include") %{
#include <ql/indexes/ibor/eonia.hpp>
%}

namespace QuantLib {

    class Index {
      public:
        bool allowsNativeFixings();
//        void addFixings(/*const std::vector<QuantLib::Date>& dates,
//                        const std::vector<QuantLib::Real>& values,
//                        bool forceOverwrite, bool updateValuObject = true*/);
    };
    
    class InterestRateIndex : public Index {};
    
    class IborIndex : public InterestRateIndex {};
    
    class OvernightIndex : public IborIndex {};

    class Eonia : public OvernightIndex {
        public:
            Eonia(const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve =
                QuantLib::Handle<YieldTermStructure>());
    };    
}

%feature("rp:group", "");
