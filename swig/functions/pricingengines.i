
%pragma(reposit) group="pricingengines";

%pragma(reposit) obj_include=%{
#include <ql/pricingengines/vanilla/analyticeuropeanengine.hpp>
#include <ql/pricingengines/swap/discountingswapengine.hpp>
%}

%pragma(reposit) add_include=%{
#include "qlo/obj_processes.hpp"
%}

%feature("rp:generate_countify") QuantLib::AnalyticEuropeanEngine::AnalyticEuropeanEngine;
%feature("rp:generate_cpp") QuantLib::AnalyticEuropeanEngine::AnalyticEuropeanEngine;

namespace QuantLib {

    class PricingEngine {};
    
    class AnalyticEuropeanEngine : public PricingEngine {
      public:
        AnalyticEuropeanEngine(
            const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess>& process);
    };
    
    class DiscountingSwapEngine : public PricingEngine {
      public:
        DiscountingSwapEngine(
               const QuantLib::Handle<QuantLib::YieldTermStructure>& discountCurve,
               bool includeSettlementDateFlows,
               // FIXME we declare effectiveDate as "const QuantLib::Date&" instead of "QuantLib::Date".
               // This is because the typemaps currently work for "const Date&" as an input value
               // and for "Date" as a return value but not for "Date" as an input value.
               //QuantLib::Date settlementDate,
               //QuantLib::Date npvDate);    
               const QuantLib::Date & settlementDate,
               const QuantLib::Date & npvDate);    
    };
}

