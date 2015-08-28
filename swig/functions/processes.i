
%feature("rp:group", "processes");
%feature("rp:obj_include") %{
#include <ql/processes/blackscholesprocess.hpp>
%}
%feature("rp:add_include") "#include \"qlo/obj_quote.hpp\"
#include \"qlo/obj_volatilities.hpp\""

%feature("rp:generate_countify") QuantLib::BlackScholesMertonProcess::BlackScholesMertonProcess;

namespace QuantLib {

    class GeneralizedBlackScholesProcess {};
    
    class BlackScholesMertonProcess : public GeneralizedBlackScholesProcess {
      public:
        BlackScholesMertonProcess(
            const QuantLib::Handle< QuantLib::Quote >& x0,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& dividendTS,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& riskFreeTS,
            const QuantLib::Handle<QuantLib::BlackVolTermStructure>& blackVolTS);
    };
}

%feature("rp:obj_include", "");
%feature("rp:add_include", "");
%feature("rp:group", "");

