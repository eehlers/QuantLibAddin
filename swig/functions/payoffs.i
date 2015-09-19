
%group(payoffs);

%insert(payoffs_library_hpp) %{
#include <ql/instruments/payoffs.hpp>
%}

namespace QuantLib {

    class StrikedTypePayoff {};

    class PlainVanillaPayoff : public StrikedTypePayoff {
      public:
        %feature("rp:generate:countify") PlainVanillaPayoff;
        %feature("rp:generate:cpp") PlainVanillaPayoff;
        PlainVanillaPayoff(QuantLib::Option::Type optionType,
                           QuantLib::Real strike);
    };
}

