
%group(pricingengines);
%groupCaption(Pricing Engines);

%insert(pricingengines_library_hpp) %{
#include <ql/pricingengines/vanilla/analyticeuropeanengine.hpp>
#include <ql/pricingengines/swap/discountingswapengine.hpp>
#include <ql/pricingengines/swaption/jamshidianswaptionengine.hpp>
#include <ql/pricingengines/swaption/treeswaptionengine.hpp>
#include <ql/pricingengines/swaption/g2swaptionengine.hpp>
%}

%insert(pricingengines_addin_cpp) %{
#include <qlo/obj_processes.hpp>
#include <qlo/objmanual_termstructures.hpp>
#include <qlo/obj_models.hpp>
%}

namespace QuantLib {

    class PricingEngine {};

    class AnalyticEuropeanEngine : public PricingEngine {
      public:
        %generate(c++, AnalyticEuropeanEngine);
        %generate(c#, AnalyticEuropeanEngine);
        %generate(countify, AnalyticEuropeanEngine);
        AnalyticEuropeanEngine(
            const boost::shared_ptr<GeneralizedBlackScholesProcess>& process    //!< process ID
        );
    };

    class DiscountingSwapEngine : public PricingEngine {
      public:
        %generate(c#, DiscountingSwapEngine);
        %generate(countify, DiscountingSwapEngine);
        DiscountingSwapEngine(
            const Handle<YieldTermStructure>& discountCurve,    //!< discounting yield term structure object ID.
            bool includeSettlementDateFlows,                    //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date settlementDate,                                //!< cashflows before this date are not taken into account. If missing it is assumed equal to the discounting yield term structure's reference date.
            Date npvDate                                        //!< all cashflows are discounted to this date. If missing it is assumed equal to the discounting yield term structure's reference date.
        );
    };
    
    class JamshidianSwaptionEngine : public PricingEngine {
      public:
        %generate(c#, JamshidianSwaptionEngine);
        JamshidianSwaptionEngine(
            const boost::shared_ptr<OneFactorAffineModel>& model    //!< Model object ID.
            /*,const Handle<YieldTermStructure>& termStructure =
                Handle<YieldTermStructure>()*/
        );
    };
    
    class TreeSwaptionEngine : public PricingEngine {
      public:
        %generate(c#, TreeSwaptionEngine);
        TreeSwaptionEngine(
            const boost::shared_ptr<ShortRateModel>& x,             //!< Model object ID.
            Size timeSteps                                          //!< Number of time steps.
            /*,const Handle<YieldTermStructure>& termStructure =
                Handle<YieldTermStructure>()*/);    
    };
    
    class G2SwaptionEngine : public PricingEngine {
      public:
        %generate(c#, G2SwaptionEngine);
        G2SwaptionEngine(
            const boost::shared_ptr<G2>& model,                     //!< G2 Model object ID.
            Real range,                                             //!< Range.
            Size intervals                                          //!< Intervals.
        );
    };
    
}

