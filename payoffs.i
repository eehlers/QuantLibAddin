
%feature("rp:group", "payoffs");
%feature("rp:include") %{
#include <ql/instruments/payoffs.hpp>
%}

namespace QuantLib {
    class PlainVanillaPayoff {
      public:
        PlainVanillaPayoff(QuantLib::Option::Type optionType,
                           QuantLib::Real strike);
    };
}

