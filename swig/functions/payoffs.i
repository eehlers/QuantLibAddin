
%group(payoffs);
%groupCaption(Payoffs);

%insert(payoffs_library_hpp) %{
#include <ql/instruments/payoffs.hpp>
%}

namespace QuantLib {

    class StrikedTypePayoff {};

    class PlainVanillaPayoff : public StrikedTypePayoff {
      public:
        %generate(c++, PlainVanillaPayoff);
        %generate(c#, PlainVanillaPayoff);
        %generate(countify, PlainVanillaPayoff);
        PlainVanillaPayoff(
            Option::Type optionType,    //!< option type.
            Real strike                 //!< strike.
        );
    };
}

