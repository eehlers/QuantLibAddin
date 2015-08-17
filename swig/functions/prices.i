
%feature("rp:group", "prices");
%feature("rp:obj_include") %{
#include <ql/prices.hpp>
%}

namespace QuantLib {

    double midEquivalent(const double bid,
                       const double ask,
                       const double last,
                       const double close);
}

%feature("rp:group", "");

