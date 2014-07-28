
%feature("rp:group", "processes");
%feature("rp:include") %{
#include <ql/processes/blackscholesprocess.hpp>
%}

namespace QuantLib {
    class BlackScholesMertonProcess {
      public:
        BlackScholesMertonProcess(
            const QuantLib::Handle<QuantLib::Quote>& x0,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& dividendTS,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& riskFreeTS,
            const QuantLib::Handle<QuantLib::BlackVolTermStructure>& blackVolTS);
    };
}

