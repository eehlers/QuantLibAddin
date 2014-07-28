
%feature("rp:group", "volatilities");
%feature("rp:include") %{
#include <ql/processes/blackscholesprocess.hpp>
%}

namespace QuantLib {
    class BlackScholesMertonProcess {
      public:
        BlackScholesMertonProcess(
            const Handle<Quote>& x0,
            const Handle<YieldTermStructure>& dividendTS,
            const Handle<YieldTermStructure>& riskFreeTS,
            const Handle<BlackVolTermStructure>& blackVolTS);
    };
}

