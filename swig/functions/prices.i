
%group(Prices);

%insert(obj_cpp) %{
#include <ql/prices.hpp>
%}

namespace QuantLib {

    //! Returns the mid price if available, or a suitable substitute otherwise.
    double midEquivalent(
        const double Bid=0.0,       //!< Bid price.
        const double Ask=0.0,       //!< Ask price.
        const double Last=0.0,      //!< Last price.
        const double Close=0.0      //!< Close price.
    );

    //! Returns the mid price only if both bid and ask are available.
    double midSafe(
        const double Bid=0.0,       //!< Bid price.
        const double Ask=0.0        //!< Ask price.
    );
}

