
#include <qlo/objects/obj_couponvectors.hpp>
#include <qlo/enumerations/factories/iborcouponpricersfactory.hpp>
#include <qlo/enumerations/factories/conundrumpricerfactory.hpp>

#include <ql/cashflows/digitalcmscoupon.hpp>
#include <ql/cashflows/digitaliborcoupon.hpp>
#include <ql/cashflows/simplecashflow.hpp>
#include <ql/cashflows/fixedratecoupon.hpp>
#include <ql/cashflows/iborcoupon.hpp>
#include <ql/cashflows/cmscoupon.hpp>
#include <ql/cashflows/rangeaccrual.hpp>
#include <ql/cashflows/cashflows.hpp>

QuantLibAddin::DigitalReplication::DigitalReplication(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Replication::Type Replication,
            QuantLib::Real Gap,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::DigitalReplication>(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::DigitalReplication>(new QuantLib::DigitalReplication(
                // BEGIN typemap rp_tm_default
                Replication,
                Gap
                // END   typemap rp_tm_default
    ));
}

QuantLibAddin::FixedRateLeg::FixedRateLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::BusinessDayConvention PaymentBDC,
            std::vector< QuantLib::Real > const &Nominals,
            boost::shared_ptr< QuantLib::Schedule > const &ScheduleID,
            std::vector< QuantLib::Rate > const &Coupons,
            QuantLib::DayCounter const &DayCounter,
            // END   typemap rp_tm_default
    bool permanent)
: Leg(properties, permanent) {
        libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new
            QuantLib::Leg(QuantLib::FixedRateLeg(*ScheduleID)
                            .withNotionals(Nominals)
                            .withCouponRates(Coupons, DayCounter)
                            .withPaymentAdjustment(PaymentBDC)));
}

QuantLibAddin::FixedRateLeg::FixedRateLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::BusinessDayConvention PaymentBDC,
            std::vector< QuantLib::Real > const &Nominals,
            boost::shared_ptr< QuantLib::Schedule > const &ScheduleID,
            std::vector< boost::shared_ptr< QuantLib::InterestRate > > const &Coupons,
            // END   typemap rp_tm_default
    bool permanent)
: Leg(properties, permanent) {
		std::vector<QuantLib::InterestRate> coupons(Coupons.size());

        for (QuantLib::Size i=0; i<Coupons.size(); ++i)
			coupons[i] = *Coupons[i];

        libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new
    		QuantLib::Leg(QuantLib::FixedRateLeg(*ScheduleID)
                                    .withNotionals(Nominals)
                                    .withCouponRates(coupons)
                                    .withPaymentAdjustment(PaymentBDC)));
}

QuantLibAddin::IborLeg::IborLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::BusinessDayConvention PaymentBDC,
            std::vector< QuantLib::Real > const &Nominals,
            boost::shared_ptr< QuantLib::Schedule > const &ScheduleID,
            std::vector< QuantLib::Natural > const &FixingDays,
            bool isInArrears,
            QuantLib::DayCounter const &DayCounter,
            std::vector< QuantLib::Rate > const &Floors,
            std::vector< QuantLib::Real > const &Gearings,
            boost::shared_ptr< QuantLib::IborIndex > const &IborIndex,
            std::vector< QuantLib::Spread > const &Spreads,
            std::vector< QuantLib::Rate > const &Caps,
            // END   typemap rp_tm_default
    bool permanent)
: Leg(properties, permanent) {
        libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new
            QuantLib::Leg(QuantLib::IborLeg(*ScheduleID, IborIndex)
                .withNotionals(Nominals)
                .withPaymentDayCounter(DayCounter)
                .withPaymentAdjustment(PaymentBDC)
                .withFixingDays(FixingDays)
                .withGearings(Gearings)
                .withSpreads(Spreads)
                .withCaps(Caps)
                .withFloors(Floors)
                .inArrears(isInArrears)));
}

QuantLibAddin::DigitalIborLeg::DigitalIborLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::BusinessDayConvention PaymentBDC,
            std::vector< QuantLib::Real > const &Nominals,
            boost::shared_ptr< QuantLib::Schedule > const &ScheduleID,
            std::vector< QuantLib::Natural > const &FixingDays,
            bool isInArrears,
            QuantLib::DayCounter const &DayCounter,
            std::vector< QuantLib::Real > const &Gearings,
            boost::shared_ptr< QuantLib::IborIndex > const &IborIndex,
            std::vector< QuantLib::Spread > const &Spreads,
            std::vector< QuantLib::Rate > const &CallStrikes,
            std::string CallSpecs,
            std::vector< QuantLib::Rate > const &CallPayoff,
            std::vector< QuantLib::Rate > const &PutStrikes,
            std::string PutSpecs,
            std::vector< QuantLib::Rate > const &PutPayoff,
            boost::shared_ptr< QuantLib::DigitalReplication > const &Replication,
            // END   typemap rp_tm_default
    bool permanent)
: Leg(properties, permanent) {

        QuantLib::Position::Type callPosition;
        QuantLib::Position::Type putPosition;
        bool isCallATMIncluded;
        bool isPutATMIncluded;

        std::string legalLabels[] = { "Short - ATM included",
                                      "Short - ATM excluded",
                                      "Long - ATM included",
                                      "Long - ATM excluded" };

        int foundLabel = -1;
        int counter = 0;
        while (foundLabel==-1 && counter<4) {
            if (CallSpecs == legalLabels[counter])
                foundLabel = counter;
            counter++;
        }
        switch(foundLabel) {
            case 0:
                callPosition = QuantLib::Position::Short;
                isCallATMIncluded = true;
                break;
            case 1:
                callPosition = QuantLib::Position::Short;
                isCallATMIncluded = false;
                break;
            case 2:
                callPosition = QuantLib::Position::Long;
                isCallATMIncluded = true;
                break;
            case 3:
                callPosition = QuantLib::Position::Long;
                isCallATMIncluded = false;
                break;
            default:
                RP_FAIL("DigitalIborLeg::DigitalIborLeg: invalid string for call option: "
                        << CallSpecs);
                break;
        }
        foundLabel = -1;
        counter = 0;
        while (foundLabel==-1 && counter<4) {
            if (PutSpecs == legalLabels[counter])
                foundLabel = counter;
            counter++;
        }
        switch(foundLabel) {
            case 0:
                putPosition = QuantLib::Position::Short;
                isPutATMIncluded = true;
                break;
            case 1:
                putPosition = QuantLib::Position::Short;
                isPutATMIncluded = false;
                break;
            case 2:
                putPosition = QuantLib::Position::Long;
                isPutATMIncluded = true;
                break;
            case 3:
                putPosition = QuantLib::Position::Long;
                isPutATMIncluded = false;
                break;
            default:
                RP_FAIL("DigitalIborLeg::DigitalIborLeg: invalid string for put option: "
                        << CallSpecs);
                break;
        }

        libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new
            QuantLib::Leg(QuantLib::DigitalIborLeg(*ScheduleID, IborIndex)
                .withNotionals(Nominals)
                .withPaymentDayCounter(DayCounter)
                .withPaymentAdjustment(PaymentBDC)
                .withFixingDays(FixingDays)
                .withGearings(Gearings)
                .withSpreads(Spreads)
                .inArrears(isInArrears)
                .withCallStrikes(CallStrikes)
                .withLongCallOption(callPosition)
                .withCallATM(isCallATMIncluded)
                .withCallPayoffs(CallPayoff)
                .withPutStrikes(PutStrikes)
                .withLongPutOption(putPosition)
                .withPutATM(isPutATMIncluded)
                .withPutPayoffs(PutPayoff)
                .withReplication(Replication)));
}


QuantLibAddin::CmsLeg::CmsLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::BusinessDayConvention PaymentBDC,
            std::vector< QuantLib::Real > const &Nominals,
            boost::shared_ptr< QuantLib::Schedule > const &ScheduleID,
            std::vector< QuantLib::Natural > const &FixingDays,
            bool isInArrears,
            QuantLib::DayCounter const &DayCounter,
            std::vector< QuantLib::Rate > const &Floors,
            std::vector< QuantLib::Real > const &Gearings,
            boost::shared_ptr< QuantLib::SwapIndex > const &SwapIndex,
            std::vector< QuantLib::Spread > const &Spreads,
            std::vector< QuantLib::Rate > const &Caps,
            // END   typemap rp_tm_default
    bool permanent)
: Leg(properties, permanent) {
        libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new
            QuantLib::Leg(QuantLib::CmsLeg(*ScheduleID, SwapIndex)
                .withNotionals(Nominals)
                .withPaymentDayCounter(DayCounter)
                .withPaymentAdjustment(PaymentBDC)
                .withFixingDays(FixingDays)
                .withGearings(Gearings)
                .withSpreads(Spreads)
                .withCaps(Caps)
                .withFloors(Floors)
                .inArrears(isInArrears)));
}


QuantLibAddin::DigitalCmsLeg::DigitalCmsLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::BusinessDayConvention PaymentBDC,
            std::vector< QuantLib::Real > const &Nominals,
            boost::shared_ptr< QuantLib::Schedule > const &ScheduleID,
            std::vector< QuantLib::Natural > const &FixingDays,
            bool isInArrears,
            QuantLib::DayCounter const &DayCounter,
            std::vector< QuantLib::Real > const &Gearings,
            boost::shared_ptr< QuantLib::SwapIndex > const &SwapIndex,
            std::vector< QuantLib::Spread > const &Spreads,
            std::vector< QuantLib::Rate > const &CallStrikes,
            std::string CallSpecs,
            std::vector< QuantLib::Rate > const &CallPayoff,
            std::vector< QuantLib::Rate > const &PutStrikes,
            std::string PutSpecs,
            std::vector< QuantLib::Rate > const &PutPayoff,
            boost::shared_ptr< QuantLib::DigitalReplication > const &Replication,
            // END   typemap rp_tm_default
    bool permanent) : Leg(properties, permanent) {

        QuantLib::Position::Type callPosition;
        QuantLib::Position::Type putPosition;
        bool isCallATMIncluded;
        bool isPutATMIncluded;

        std::string legalLabels[] = { "Short - ATM included",
                                      "Short - ATM excluded",
                                      "Long - ATM included",
                                      "Long - ATM excluded" };

        int foundLabel = -1;
        int counter = 0;
        while (foundLabel==-1) {
            if (CallSpecs == legalLabels[counter])
                foundLabel = counter;
            counter++;
        }
        switch(foundLabel) {
            case 0:
                callPosition = QuantLib::Position::Short;
                isCallATMIncluded = true;
                break;
            case 1:
                callPosition = QuantLib::Position::Short;
                isCallATMIncluded = false;
                break;
            case 2:
                callPosition = QuantLib::Position::Long;
                isCallATMIncluded = true;
                break;
            case 3:
                callPosition = QuantLib::Position::Long;
                isCallATMIncluded = false;
                break;
            default:
                RP_FAIL("DigitalIborLeg::DigitalIborLeg: invalid string for call option: "
                        << CallSpecs);
                break;
        }
        foundLabel = -1;
        counter = 0;
        while (foundLabel==-1) {
            if (PutSpecs == legalLabels[counter])
                foundLabel = counter;
            counter++;
        }
        switch(foundLabel) {
            case 0:
                putPosition = QuantLib::Position::Short;
                isPutATMIncluded = true;
                break;
            case 1:
                putPosition = QuantLib::Position::Short;
                isPutATMIncluded = false;
                break;
            case 2:
                putPosition = QuantLib::Position::Long;
                isPutATMIncluded = true;
                break;
            case 3:
                putPosition = QuantLib::Position::Long;
                isPutATMIncluded = false;
                break;
            default:
                RP_FAIL("DigitalIborLeg::DigitalIborLeg: invalid string for put option: "
                        << PutSpecs);
                break;
        }

        libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new
            QuantLib::Leg(QuantLib::DigitalCmsLeg(*ScheduleID, SwapIndex)
            .withNotionals(Nominals)
            .withPaymentDayCounter(DayCounter)
            .withPaymentAdjustment(PaymentBDC)
            .withFixingDays(FixingDays)
            .withGearings(Gearings)
            .withSpreads(Spreads)
            .inArrears(isInArrears)
            .withCallStrikes(CallStrikes)
            .withLongCallOption(callPosition)
            .withCallATM(isCallATMIncluded)
            .withCallPayoffs(CallPayoff)
            .withPutStrikes(PutStrikes)
            .withLongPutOption(putPosition)
            .withPutATM(isPutATMIncluded)
            .withPutPayoffs(PutPayoff)
            .withReplication(Replication)));
}

QuantLibAddin::RangeAccrualLeg::RangeAccrualLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::BusinessDayConvention PaymentBDC,
            std::vector< QuantLib::Real > const &Nominals,
            boost::shared_ptr< QuantLib::Schedule > const &ScheduleID,
            std::vector< QuantLib::Natural > const &FixingDays,
            QuantLib::DayCounter const &DayCounter,
            std::vector< QuantLib::Rate > const &LowerStrikes,
            std::vector< QuantLib::Real > const &Gearings,
            boost::shared_ptr< QuantLib::IborIndex > const &IborIndex,
            std::vector< QuantLib::Spread > const &Spreads,
            std::vector< QuantLib::Rate > const &UpperStrikes,
            QuantLib::Period const &ObservationsTenor,
            QuantLib::BusinessDayConvention ObservationsBDC,
            // END   typemap rp_tm_default
    bool permanent) : Leg(properties, permanent) {
        libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new
            QuantLib::Leg(QuantLib::RangeAccrualLeg(*ScheduleID, IborIndex)
                .withNotionals(Nominals)
                .withPaymentDayCounter(DayCounter)
                .withPaymentAdjustment(PaymentBDC)
                .withFixingDays(FixingDays)
                .withGearings(Gearings)
                .withSpreads(Spreads)
                .withLowerTriggers(LowerStrikes)
                .withUpperTriggers(UpperStrikes)
                .withObservationTenor(ObservationsTenor)
                .withObservationConvention(ObservationsBDC)));
}

QuantLibAddin::CmsZeroLeg::CmsZeroLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::BusinessDayConvention PaymentBDC,
            std::vector< QuantLib::Real > const &Nominals,
            boost::shared_ptr< QuantLib::Schedule > const &ScheduleID,
            std::vector< QuantLib::Natural > const &FixingDays,
            bool isInArrears,
            QuantLib::DayCounter const &DayCounter,
            std::vector< QuantLib::Rate > const &Floors,
            std::vector< QuantLib::Real > const &Gearings,
            boost::shared_ptr< QuantLib::SwapIndex > const &SwapIndex,
            std::vector< QuantLib::Spread > const &Spreads,
            std::vector< QuantLib::Rate > const &Caps,
            // END   typemap rp_tm_default
    bool permanent)
: Leg(properties, permanent) {
        libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new
            QuantLib::Leg(QuantLib::CmsLeg(*ScheduleID, SwapIndex)
                .withNotionals(Nominals)
                .withPaymentDayCounter(DayCounter)
                .withPaymentAdjustment(PaymentBDC)
                .withFixingDays(FixingDays)
                .withGearings(Gearings)
                .withSpreads(Spreads)
                .withCaps(Caps)
                .withFloors(Floors)
                .withZeroPayments()));
}


QuantLibAddin::IborCouponPricer::IborCouponPricer(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::OptionletVolatilityStructure > const &Volatility,
            std::string const &IborCouponPricerType,
            // END   typemap rp_tm_default
    bool permanent)
: FloatingRateCouponPricer(properties, permanent) {
        libraryObject_= reposit::Create<boost::shared_ptr<QuantLib::IborCouponPricer> >()(IborCouponPricerType, Volatility);
}


QuantLibAddin::CmsCouponPricer::CmsCouponPricer(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::SwaptionVolatilityStructure > const &Volatility,
            std::string const &CmsCouponPricerType,
            QuantLib::GFunctionFactory::YieldCurveModel YieldCurveModel,
            QuantLib::Handle< QuantLib::Quote > const &MeanReversion,
            // END   typemap rp_tm_default
    bool permanent)
: FloatingRateCouponPricer(properties, permanent) {
        libraryObject_ =
            reposit::Create<boost::shared_ptr<QuantLib::CmsCouponPricer> >()(CmsCouponPricerType,
                                                             Volatility,
                                                             YieldCurveModel,
                                                             MeanReversion);
}


QuantLibAddin::NumericHaganPricer::NumericHaganPricer(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::SwaptionVolatilityStructure > const &SwaptionVol,
            QuantLib::GFunctionFactory::YieldCurveModel YieldCurveModel,
            QuantLib::Handle< QuantLib::Quote > const &MeanReversion,
            QuantLib::Rate LowerLimit,
            QuantLib::Rate UpperLimit,
            QuantLib::Real Precision,
            // END   typemap rp_tm_default
    bool permanent) : CmsCouponPricer(properties, permanent) {
        libraryObject_ = 
            boost::shared_ptr<QuantLib::NumericHaganPricer>(new
                QuantLib::NumericHaganPricer(SwaptionVol,
                                             YieldCurveModel,
                                             MeanReversion,
                                             LowerLimit,
                                             UpperLimit,
                                             Precision));
}

