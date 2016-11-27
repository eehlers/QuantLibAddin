
#include <qlo/objects/obj_vanillaswap.hpp>

#include <ql/instruments/makevanillaswap.hpp>
#include <ql/indexes/swapindex.hpp>
#include <ql/termstructures/yield/ratehelpers.hpp>
#include <ql/time/imm.hpp>

QuantLibAddin::VanillaSwap::VanillaSwap(
    const boost::shared_ptr<reposit::ValueObject>& properties,
    QuantLib::VanillaSwap::Type PayerReceiver,
    QuantLib::Real Nominal,
    QuantLib::Schedule const &FixSchedule,
    QuantLib::Rate FixedRate,
    QuantLib::DayCounter const &FixDayCounter,
    QuantLib::Schedule const &FloatingLegSchedule,
    boost::shared_ptr< QuantLib::IborIndex > const &IborIndex,
    QuantLib::Spread Spread,
    QuantLib::DayCounter const &FloatingLegDayCounter,
    QuantLib::BusinessDayConvention PaymentConvention,
    bool permanent) : Swap(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::Instrument>(new QuantLib::VanillaSwap(
                PayerReceiver,
                Nominal,
                FixSchedule,
                FixedRate,
                FixDayCounter,
                FloatingLegSchedule,
                IborIndex,
                Spread,
                FloatingLegDayCounter,
                PaymentConvention
    ));
}

// MakeVanillaSwap
QuantLibAddin::VanillaSwap::VanillaSwap(
    const boost::shared_ptr<reposit::ValueObject>& properties,
    QuantLib::Natural SettlDays,
    QuantLib::Period const &SwapTenor,
    boost::shared_ptr< QuantLib::IborIndex > const &IborIndex,
    QuantLib::Rate FixedRate,
    QuantLib::Period const &ForwardStart,
    QuantLib::DayCounter const &FixDayCounter,
    QuantLib::Spread Spread,
    boost::shared_ptr< QuantLib::PricingEngine > const &PricingEngineID,
    bool permanent) : Swap(properties, permanent) {
        libraryObject_ = QuantLib::MakeVanillaSwap(SwapTenor, IborIndex, FixedRate, ForwardStart)
                                .withSettlementDays(SettlDays)
                                .withFixedLegDayCount(FixDayCounter)
                                .withFloatingLegSpread(Spread)
                                .withPricingEngine(PricingEngineID)
                                .operator boost::shared_ptr<QuantLib::VanillaSwap>();
}

// MakeIMMSwap
QuantLibAddin::VanillaSwap::VanillaSwap(
    const boost::shared_ptr<reposit::ValueObject>& properties,
    QuantLib::Period const &SwapTenor,
    boost::shared_ptr< QuantLib::IborIndex > const &IborIndex,
    QuantLib::Rate FixedRate,
    QuantLib::Date const &FirstImmDate,
    QuantLib::DayCounter const &FixDayCounter,
    QuantLib::Spread Spread,
    boost::shared_ptr< QuantLib::PricingEngine > const &PricingEngineID,
    bool permanent) : Swap(properties, permanent) {
        QuantLib::Date effectiveDate = FirstImmDate;
        if (effectiveDate==QuantLib::Date())
            effectiveDate = QuantLib::IMM::nextDate();

        QuantLib::Date terminationDate = effectiveDate+SwapTenor;
        terminationDate = QuantLib::Date::nthWeekday(3,
                                                     QuantLib::Wednesday,
                                                     terminationDate.month(),
                                                     terminationDate.year());

        libraryObject_ = QuantLib::MakeVanillaSwap(SwapTenor, IborIndex, FixedRate)
                            .withEffectiveDate(effectiveDate)
                            .withTerminationDate(terminationDate)
                            .withRule(QuantLib::DateGeneration::ThirdWednesday)
                            .withFixedLegDayCount(FixDayCounter)
                            .withFloatingLegSpread(Spread)
                            .withPricingEngine(PricingEngineID)
                            .operator boost::shared_ptr<QuantLib::VanillaSwap>();
}

// VanillaSwapFromSwapIndex
QuantLibAddin::VanillaSwap::VanillaSwap(
    const boost::shared_ptr<reposit::ValueObject>& properties,
    boost::shared_ptr< QuantLib::SwapIndex > const &SwapIndex,
    QuantLib::Date const &FixingDate,
    bool permanent) : Swap(properties, permanent) {
        libraryObject_ = SwapIndex->underlyingSwap(FixingDate);
}

// VanillaSwapFromSwapRateHelper
QuantLibAddin::VanillaSwap::VanillaSwap(
    const boost::shared_ptr<reposit::ValueObject>& properties,
    boost::shared_ptr< QuantLib::SwapRateHelper > const &SwapRateHelper,
    bool permanent) : Swap(properties, permanent) {
        libraryObject_ = SwapRateHelper->swap();
}

std::vector<std::vector<reposit::property_t> > QuantLibAddin::VanillaSwap::fixedLegAnalysis(
        const QuantLib::Date& d) {
    return Swap::legAnalysis(0, d);
}

std::vector<std::vector<reposit::property_t> > QuantLibAddin::VanillaSwap::floatingLegAnalysis(
        const QuantLib::Date& d) {
    return Swap::legAnalysis(1, d);
}
