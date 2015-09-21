
%group(payoffs);

%insert(payoffs_library_hpp) %{
#include <ql/instruments/payoffs.hpp>
%}

namespace QuantLib {

    class StrikedTypePayoff {};

    class PlainVanillaPayoff : public StrikedTypePayoff {
      public:
        %generate(cpp, PlainVanillaPayoff);
        %generate(countify, PlainVanillaPayoff);
        PlainVanillaPayoff(Option::Type optionType,
                           Real strike);
    };
}

