
#include <qlo/objects/obj_pricingengines.hpp>

#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/obj_shortratemodels.hpp>
#include <qlo/objects/obj_payoffs.hpp>
//#include <qlo/marketmodels.hpp>
#include <qlo/objects/obj_processes.hpp>
#include <qlo/enumerations/factories/pricingenginesfactory.hpp>

#include <ql/pricingengines/blackformula.hpp>
#include <ql/pricingengines/blackscholescalculator.hpp>
#include <ql/pricingengines/bond/discountingbondengine.hpp>
#include <ql/pricingengines/capfloor/analyticcapfloorengine.hpp>
#include <ql/pricingengines/capfloor/bacheliercapfloorengine.hpp>
#include <ql/pricingengines/capfloor/blackcapfloorengine.hpp>
#include <ql/pricingengines/swap/discountingswapengine.hpp>
#include <ql/pricingengines/swaption/blackswaptionengine.hpp>
#include <ql/pricingengines/swaption/g2swaptionengine.hpp>
#include <ql/pricingengines/swaption/jamshidianswaptionengine.hpp>
#include <ql/pricingengines/swaption/treeswaptionengine.hpp>
#include <ql/processes/blackscholesprocess.hpp>
#include <ql/termstructures/volatility/optionlet/optionletvolatilitystructure.hpp>
#include <ql/termstructures/volatility/swaption/swaptionvolstructure.hpp>


QuantLibAddin::PricingEngine::PricingEngine(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::string const &EngineID,
            boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const &ProcessID,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::PricingEngine>(properties, permanent) {
        libraryObject_ = reposit::createPricingEngine(EngineID, ProcessID);
}

QuantLibAddin::PricingEngine::PricingEngine(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::string const &EngineID,
            boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const &ProcessID,
            long const &TimeSteps,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::PricingEngine>(properties, permanent) {
        libraryObject_ = reposit::createPricingEngine(EngineID, ProcessID, TimeSteps);
}

QuantLibAddin::BlackSwaptionEngine::BlackSwaptionEngine(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::YieldTermStructure > const &YieldCurve,
            QuantLib::Handle< QuantLib::Quote > const &Vol,
            QuantLib::Real const Displacement,
            QuantLib::DayCounter const &DayCounter,
            // END   typemap rp_tm_default
    bool permanent)
: PricingEngine(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::PricingEngine>(new QuantLib::BlackSwaptionEngine(
                // BEGIN typemap rp_tm_default
                YieldCurve,
                Vol,
                DayCounter,
                Displacement
                // END   typemap rp_tm_default
    ));
}

QuantLibAddin::BlackCapFloorEngine::BlackCapFloorEngine(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::YieldTermStructure > const &YieldCurve,
            QuantLib::Handle< QuantLib::Quote > const &Vol,
            QuantLib::Real const Displacement,
            QuantLib::DayCounter const &DayCounter,
            // END   typemap rp_tm_default
    bool permanent)
: PricingEngine(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::PricingEngine>(new QuantLib::BlackCapFloorEngine(
                // BEGIN typemap rp_tm_default
                YieldCurve,
                Vol,
                DayCounter,
                Displacement
                // END   typemap rp_tm_default
    ));
}

QuantLibAddin::BondEngine::BondEngine(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::YieldTermStructure > const &YieldCurve,
            // END   typemap rp_tm_default
    bool permanent)
: PricingEngine(properties, permanent) {
        libraryObject_ = boost::shared_ptr<QuantLib::PricingEngine>(new
            QuantLib::DiscountingBondEngine(YieldCurve));
}
