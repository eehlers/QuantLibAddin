
%pragma(reposit) group="processes";

%pragma(reposit) obj_include=%{
#include <ql/processes/blackscholesprocess.hpp>
%}

%pragma(reposit) add_include=%{
#include "qlo/objmanual_quote.hpp"
#include "qlo/obj_volatilities.hpp"
%}

%feature("rp:generate_countify") QuantLib::BlackScholesMertonProcess::BlackScholesMertonProcess;
%feature("rp:generate_cpp") QuantLib::BlackScholesMertonProcess::BlackScholesMertonProcess;

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

