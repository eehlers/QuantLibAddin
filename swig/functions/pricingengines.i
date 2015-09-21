
%group(pricingengines);

%insert(pricingengines_library_hpp) %{
#include <ql/pricingengines/vanilla/analyticeuropeanengine.hpp>
#include <ql/pricingengines/swap/discountingswapengine.hpp>
#include <ql/pricingengines/swaption/jamshidianswaptionengine.hpp>
#include <ql/pricingengines/swaption/treeswaptionengine.hpp>
%}

%insert(pricingengines_cppaddin_cpp) %{
#include "qlo/obj_processes.hpp"
%}

%insert(pricingengines_serialization_cpp) %{
#include <qlo/obj_processes.hpp>
#include <qlo/obj_termstructures.hpp>
#include <qlo/obj_models.hpp>
%}

namespace QuantLib {

    class PricingEngine {};

    class AnalyticEuropeanEngine : public PricingEngine {
      public:
        %generate(cpp, AnalyticEuropeanEngine);
        %generate(countify, AnalyticEuropeanEngine);
        AnalyticEuropeanEngine(
            const boost::shared_ptr<GeneralizedBlackScholesProcess>& process);
    };

    class DiscountingSwapEngine : public PricingEngine {
      public:
        DiscountingSwapEngine(
               const Handle<YieldTermStructure>& discountCurve,
               bool includeSettlementDateFlows,
               Date settlementDate,
               Date npvDate);
    };
    
    class JamshidianSwaptionEngine : public PricingEngine {
      public:
        JamshidianSwaptionEngine(
                         const boost::shared_ptr<OneFactorAffineModel>& model/*,
                         const Handle<YieldTermStructure>& termStructure =
                                                 Handle<YieldTermStructure>()*/);
    };
    
    class TreeSwaptionEngine : public PricingEngine {
      public:
        TreeSwaptionEngine(const boost::shared_ptr<ShortRateModel>& x,
                           Size timeSteps/*,
                           const Handle<YieldTermStructure>& termStructure =
                                                 Handle<YieldTermStructure>()*/);    
    };
}

