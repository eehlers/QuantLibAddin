
%feature("rp:group", "payoffs");
%feature("rp:obj_include") %{
#include <ql/instruments/payoffs.hpp>
%}
%feature("rp:generate_countify") QuantLib::PlainVanillaPayoff::PlainVanillaPayoff;

namespace QuantLib {

    class StrikedTypePayoff {};
    
    class PlainVanillaPayoff : public StrikedTypePayoff {
      public:
        PlainVanillaPayoff(QuantLib::Option::Type optionType,
                           QuantLib::Real strike);
    };
}

%feature("rp:obj_include", "");
%feature("rp:group", "");

