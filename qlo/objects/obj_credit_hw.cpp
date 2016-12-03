
#include <qlo/objects/obj_credit.hpp>

#include <qlo/enumerations/factories/termstructuresfactory.hpp>

#include <ql/instruments/stock.hpp>
#include <ql/quote.hpp>
#include <ql/currencies/europe.hpp>
#include <ql/time/daycounter.hpp>
#include <ql/time/daycounters/actual360.hpp>
#include <ql/termstructures/yield/piecewiseyieldcurve.hpp>
#include <ql/termstructures/credit/interpolatedhazardratecurve.hpp>
#include <ql/termstructures/credit/flathazardrate.hpp>
#include <ql/termstructures/credit/piecewisedefaultcurve.hpp>
#include <ql/math/interpolations/backwardflatinterpolation.hpp>
#include <ql/math/interpolations/loginterpolation.hpp>
#include <ql/math/interpolations/bilinearinterpolation.hpp>
#include <ql/math/interpolations/bicubicsplineinterpolation.hpp>
#include <ql/math/solver1d.hpp>
#include <ql/math/solvers1d/brent.hpp>

#include <ql/pricingengines/credit/midpointcdsengine.hpp>

#include <ql/instruments/creditdefaultswap.hpp>
#include <ql/experimental/credit/riskybond.hpp>
#include <ql/experimental/credit/syntheticcdo.hpp>
#include <ql/experimental/credit/midpointcdoengine.hpp>
#include <ql/experimental/credit/nthtodefault.hpp>
#include <ql/experimental/credit/integralntdengine.hpp>
#include <ql/experimental/credit/basecorrelationstructure.hpp>
#include <ql/experimental/credit/cdsoption.hpp>
#include <ql/experimental/credit/blackcdsoptionengine.hpp>

#include <boost/algorithm/string/case_conv.hpp>
#include <boost/make_shared.hpp>

#include <ql/settings.hpp>

QuantLibAddin::CreditDefaultSwap::CreditDefaultSwap(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Protection::Side BuyerSeller,
            QuantLib::Real Notional,
            QuantLib::Rate Upfront,
            QuantLib::Rate Spread,
            QuantLib::Schedule const &PremiumSchedule,
            QuantLib::BusinessDayConvention PaymentConvention,
            QuantLib::DayCounter const &DayCounter,
            bool SettlesAccrual,
            bool PayAtDefault,
            QuantLib::Date const &ProtectionStart,
            QuantLib::Date const &UpfrontDate,
            // END   typemap rp_tm_default
    bool permanent)
: Instrument(properties, permanent) {
		// dirty way to decide if this is constructed through a run only version
        if(UpfrontDate == QuantLib::Null<QuantLib::Date>() && Upfront == 0.) {
            libraryObject_ = boost::shared_ptr<QuantLib::CreditDefaultSwap>(
                new QuantLib::CreditDefaultSwap(
                    BuyerSeller,
                    Notional,
                    Spread,
                    PremiumSchedule,
                    PaymentConvention,
                    DayCounter,
                    SettlesAccrual,
                    PayAtDefault,
                    ProtectionStart,
                    boost::shared_ptr<QuantLib::Claim>()));
        }else{
                libraryObject_ = boost::shared_ptr<QuantLib::CreditDefaultSwap>(
                    new QuantLib::CreditDefaultSwap(
                        BuyerSeller,
                        Notional,
                        Upfront,
                        Spread,
                        PremiumSchedule,
                        PaymentConvention,
                        DayCounter,
                        SettlesAccrual,
                        PayAtDefault,
                        ProtectionStart,
                        UpfrontDate,
                        boost::shared_ptr<QuantLib::Claim>()));
        }
}

QuantLibAddin::HazardRateCurve::HazardRateCurve(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Date > const &CurveDates,
            std::vector< QuantLib::Rate > const &CurveRates,
            QuantLib::DayCounter const &DayCounter,
            // END   typemap rp_tm_default
    bool permanent)
: DefaultProbabilityTermStructure(properties, permanent) {
        QL_REQUIRE(!CurveDates.empty(), "no input dates given");
        QL_REQUIRE(CurveDates.size() == CurveRates.size(), 
                   "vector sizes differ");
        libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(
        new QuantLib::InterpolatedHazardRateCurve<QuantLib::BackwardFlat>(
 				 CurveDates, CurveRates, DayCounter));
}

QuantLibAddin::PiecewiseHazardRateCurve::PiecewiseHazardRateCurve(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< boost::shared_ptr< QuantLib::DefaultProbabilityHelper > > const &Helpers,
            QuantLib::DayCounter const &DayCounter,
            QuantLib::Calendar const &Calendar,
            std::string const &Interpolation,
            QuantLib::Real Accuracy,
            // END   typemap rp_tm_default
    bool permanent)
: DefaultProbabilityTermStructure(properties, permanent) {
        if(Interpolation == std::string("LINEAR")){
            libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
                   QuantLib::PiecewiseDefaultCurve<QuantLib::HazardRate,
                        QuantLib::Linear>(
                            0, 
                            Calendar,
                            Helpers, 
                            DayCounter));
        }else if(Interpolation == std::string("BACKWARDFLAT")) {
            libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
                   QuantLib::PiecewiseDefaultCurve<QuantLib::HazardRate,
                        QuantLib::BackwardFlat>(
                            0, 
                            Calendar,
                            Helpers, 
                            DayCounter));
        }else{
            QL_FAIL("Unrecognised interpolator");
        }

        libraryObject_->enableExtrapolation();
}

const std::vector<QuantLib::Date>& QuantLibAddin::PiecewiseHazardRateCurve::dates() const {
    typedef QuantLib::PiecewiseDefaultCurve<QuantLib::HazardRate, QuantLib::BackwardFlat> flat_curve;
    typedef QuantLib::PiecewiseDefaultCurve<QuantLib::HazardRate, QuantLib::Linear> lin_curve;
    boost::shared_ptr<flat_curve> ptrBF =
        boost::dynamic_pointer_cast<flat_curve>(libraryObject_);
    if(ptrBF) return ptrBF->dates();
    boost::shared_ptr<lin_curve> ptrLIN =
        boost::dynamic_pointer_cast<lin_curve>(libraryObject_);
    if(ptrLIN) return ptrLIN->dates();
    QL_FAIL("Unable to cast default probability term structure.");
}

const std::vector<QuantLib::Real>& QuantLibAddin::PiecewiseHazardRateCurve::data() const {
    typedef QuantLib::PiecewiseDefaultCurve<QuantLib::HazardRate, QuantLib::BackwardFlat> flat_curve;
    typedef QuantLib::PiecewiseDefaultCurve<QuantLib::HazardRate, QuantLib::Linear> lin_curve;
    boost::shared_ptr<flat_curve> ptrBF =
        boost::dynamic_pointer_cast<flat_curve>(libraryObject_);
    if(ptrBF) return ptrBF->data();
    boost::shared_ptr<lin_curve> ptrLIN =
        boost::dynamic_pointer_cast<lin_curve>(libraryObject_);
    if(ptrLIN) return ptrLIN->data();
    QL_FAIL("Unable to cast default probability term structure.");
}        

QuantLibAddin::PiecewiseFlatForwardCurve::PiecewiseFlatForwardCurve(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Date const &ReferenceDate,
            std::vector< boost::shared_ptr< QuantLib::RateHelper > > const &RateHelpers,
            QuantLib::DayCounter const &DayCounter,
            QuantLib::Real Accuracy,
            // END   typemap rp_tm_default
    bool permanent)
: YieldTermStructure(properties, permanent) {
        libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
               QuantLib::PiecewiseYieldCurve<QuantLib::Discount,QuantLib::LogLinear>(ReferenceDate, RateHelpers, DayCounter));
}

QuantLibAddin::RiskyFixedBond::RiskyFixedBond(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::string Bondname,
            QuantLib::Currency Currency,
            QuantLib::Real Recovery,
            QuantLib::Handle< QuantLib::DefaultProbabilityTermStructure > const &DefaultCurve,
            QuantLib::Schedule const &Schedule,
            QuantLib::Real Rate,
            QuantLib::DayCounter DayCounter,
            QuantLib::BusinessDayConvention PaymentConvention,
            QuantLib::Real Notional,
            QuantLib::Handle< QuantLib::YieldTermStructure > const &DiscountingCurve,
            QuantLib::Date PricingDate,
            // END   typemap rp_tm_default
    bool permanent)
: Instrument(properties, permanent) {
        std::vector<QuantLib::Real> notionals(1,Notional);

        libraryObject_ = boost::shared_ptr<QuantLib::RiskyFixedBond>(
            new QuantLib::RiskyFixedBond(
                    Bondname,Currency,Recovery,DefaultCurve,Schedule,Rate,DayCounter,
                    PaymentConvention,notionals,DiscountingCurve///, PricingDate
                                       ));
}

QuantLibAddin::Issuer::Issuer(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            boost::shared_ptr< QuantLib::DefaultProbabilityTermStructure > const &DefaultCurves,
            boost::shared_ptr< QuantLib::DefaultEventSet > const &DefaultEvents,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::Issuer>(properties, permanent) {
        std::vector<QuantLib::Issuer::key_curve_pair> curves(1, std::make_pair(
            QuantLib::NorthAmericaCorpDefaultKey(QuantLib::EURCurrency(),
                                                     QuantLib::SeniorSec, 
                                                     QuantLib::Period(),
                                                     1. // amount threshold
                                                     ),
            QuantLib::Handle<QuantLib::DefaultProbabilityTermStructure>(DefaultCurves)
        ));
        libraryObject_ = boost::shared_ptr<QuantLib::Issuer>(new QuantLib::Issuer(curves, *DefaultEvents));
}

QuantLibAddin::DefaultEventSet::DefaultEventSet(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::string const &EventType,
            QuantLib::Date const &EventDate,
            QuantLib::Currency const &Currency,
            QuantLib::Seniority Seniority,
            QuantLib::Date const &SettlementDate,
            QuantLib::Real SettledRecovery,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::DefaultEventSet>(properties, permanent) {
        // if no match return empty set
        libraryObject_ = boost::shared_ptr<QuantLib::DefaultEventSet>(new QuantLib::DefaultEventSet());

        // only one recovery parsed by now; bankruptcy events need the whole
        //  set or they fail to construct.
        std::map<QuantLib::Seniority, QuantLib::Real> rrs;
        rrs.insert(std::pair<QuantLib::Seniority, QuantLib::Real>(Seniority, SettledRecovery));
        if(EventType==std::string("FailureToPayEvent")) {
            libraryObject_->insert(boost::shared_ptr<QuantLib::FailureToPayEvent> (
                new QuantLib::FailureToPayEvent(EventDate, Currency, Seniority, 1.e7, 
                //implSettlemt, 
                SettlementDate,
                rrs)));
        }else if(EventType==std::string("BankruptcyEvent")){
            libraryObject_->insert(boost::shared_ptr<QuantLib::BankruptcyEvent> (
                new QuantLib::BankruptcyEvent(EventDate, Currency, Seniority, 
                SettlementDate,
                rrs)));
        }
}

QuantLibAddin::BaseCorrelationTermStructure::BaseCorrelationTermStructure(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::string const &InterpolatorType,
            QuantLib::Natural SettlementDays,
            QuantLib::Calendar const &Calendar,
            QuantLib::BusinessDayConvention Convention,
            std::vector< QuantLib::Period > const &Tenors,
            std::vector< QuantLib::Real > const &LossLevel,
            std::vector< std::vector< QuantLib::Handle< QuantLib::Quote > > > const &Correlations,
            QuantLib::DayCounter const &DayCounter,
            // END   typemap rp_tm_default
    bool permanent)
: CorrelationTermStructure(properties, permanent) {
        // select 2D interpolator:
        //  Another option is to write one class per interpolator.
        if(InterpolatorType == std::string("BILIN")) {
            libraryObject_ = boost::shared_ptr<QuantLib::BaseCorrelationTermStructure<QuantLib::BilinearInterpolation> >(new
                QuantLib::BaseCorrelationTermStructure<QuantLib::BilinearInterpolation>(SettlementDays, Calendar, Convention, Tenors, LossLevel, Correlations, DayCounter));
        //}else if(InterpolatorType == std::string("")) {
        }else if(InterpolatorType == std::string("BICUBIC")) {
            libraryObject_ = boost::shared_ptr<QuantLib::BaseCorrelationTermStructure<QuantLib::BicubicSpline> >(new
                QuantLib::BaseCorrelationTermStructure<QuantLib::BicubicSpline>(SettlementDays, Calendar, Convention, Tenors, LossLevel, Correlations, DayCounter));
        }else{
            QL_FAIL("Can't determine base correlation surface interpolator.");
        }
}

QuantLib::Real QuantLibAddin::BaseCorrelationTermStructure::correlation(const QuantLib::Date& d, QuantLib::Real lossLevel) {
    if(interpolType_ == std::string("BILIN")) {
        return boost::dynamic_pointer_cast<QuantLib::BaseCorrelationTermStructure<QuantLib::BilinearInterpolation> >
            (libraryObject_)->correlation(d, lossLevel);
    }else if(interpolType_ == std::string("BICUBIC")) {
        return boost::dynamic_pointer_cast<QuantLib::BaseCorrelationTermStructure<QuantLib::BicubicSpline> >
            (libraryObject_)->correlation(d, lossLevel);
    }else{
        QL_FAIL("unknown 2D interpolator");
    }
}
