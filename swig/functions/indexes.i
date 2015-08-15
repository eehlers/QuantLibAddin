
%feature("rp:group", "indexes");

%feature("rp:obj_include") %{
#include <ql/indexes/ibor/euribor.hpp>
#include <ql/indexes/ibor/eonia.hpp>
#include <qlo/objmanual_indexes2.hpp>
%}

namespace QuantLib {

//    class Index {
//      public:
//        bool allowsNativeFixings();
//        void addFixings(/*const std::vector<QuantLib::Date>& dates,
//                        const std::vector<QuantLib::Real>& values,
//                        bool forceOverwrite, bool updateValuObject = true*/);
//    };
   
    class InterestRateIndex : public Index {};
    
    class IborIndex : public InterestRateIndex {};
    
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
}

%feature("rp:group", "");
