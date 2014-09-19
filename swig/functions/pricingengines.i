
%feature("rp:group", "pricingengines");
%feature("rp:obj_include") %{
#include <ql/pricingengines/vanilla/analyticeuropeanengine.hpp>
%}
%feature("rp:add_include") "#include \"qlo/obj_processes.hpp\""

namespace QuantLib {
    class AnalyticEuropeanEngine {
      public:
        AnalyticEuropeanEngine(
            const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess>& process);
    };
}

%feature("rp:group", "");

