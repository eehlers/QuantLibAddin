
%group(prices);

%insert(prices_library_hpp) %{
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

