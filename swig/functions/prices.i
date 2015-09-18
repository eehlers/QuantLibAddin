
%pragma(reposit) group="prices";

%insert(prices_lib_inc) %{
#include <ql/prices.hpp>
%}

namespace QuantLib {

    double midEquivalent(const double bid,
                       const double ask,
                       const double last,
                       const double close);

    double midSafe(const double bid,
                 const double ask);
}

