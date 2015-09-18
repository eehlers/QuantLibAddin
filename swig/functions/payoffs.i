
%pragma(reposit) group="payoffs";

%insert(payoffs_lib_inc) %{
#include <ql/instruments/payoffs.hpp>
%}

%feature("rp:generate_countify") QuantLib::PlainVanillaPayoff::PlainVanillaPayoff;
%feature("rp:generate_cpp") QuantLib::PlainVanillaPayoff::PlainVanillaPayoff;

namespace QuantLib {

    class StrikedTypePayoff {};

    class PlainVanillaPayoff : public StrikedTypePayoff {
      public:
        PlainVanillaPayoff(QuantLib::Option::Type optionType,
                           QuantLib::Real strike);
    };
}

