
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
    
    class JamshidianSwaptionEngine : public PricingEngine {
      public:
        JamshidianSwaptionEngine(
                         const boost::shared_ptr<QuantLib::OneFactorAffineModel>& model/*,
                         const QuantLib::Handle<QuantLib::YieldTermStructure>& termStructure =
                                                 QuantLib::Handle<QuantLib::YieldTermStructure>()*/);
    };
    
    class TreeSwaptionEngine : public PricingEngine {
      public:
        TreeSwaptionEngine(const boost::shared_ptr<QuantLib::ShortRateModel>& x,
                           QuantLib::Size timeSteps/*,
                           const Handle<YieldTermStructure>& termStructure =
                                                 Handle<YieldTermStructure>()*/);    
    };
}

