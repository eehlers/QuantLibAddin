
%feature("rp:group", "pricingengines");
%feature("rp:include") %{
#include <ql/pricingengines/vanilla/analyticeuropeanengine.hpp>
%}

namespace QuantLib {
    class AnalyticEuropeanEngine {
      public:
        AnalyticEuropeanEngine(
            const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess>& process);
    };
}

