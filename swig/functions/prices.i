
%group(prices);
%groupCaption(Prices);

%insert(prices_library_hpp) %{
#include <ql/prices.hpp>
%}

%insert(prices_addin_cpp) %{
#include <ql/prices.hpp>
%}

namespace QuantLib {

    //! returns the mid price if available, or a suitable substitute otherwise.
    double midEquivalent(
        const double bid,   //!< bid price.
        const double ask,   //!< ask price.
        const double last,  //!< last price.
        const double close  //!< close price.
    );

    //! returns the mid price only if both bid and ask are available.
    double midSafe(
        const double bid,   //!< bid price.
        const double ask    //!< ask price.
    );
}

