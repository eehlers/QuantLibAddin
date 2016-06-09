
%group(prices);

%insert(prices_library_hpp) %{
#include <ql/prices.hpp>
%}

%insert(prices_addin_cpp) %{
#include <ql/prices.hpp>
%}

namespace QuantLib {

    %generate(countify, midEquivalent);
    double midEquivalent(const double bid,
                       const double ask,
                       const double last,
                       const double close);

    %generate(countify, midSafe);
    double midSafe(const double bid,
                 const double ask);
}

