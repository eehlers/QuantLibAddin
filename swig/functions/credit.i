
%group(credit);
%groupCaption(Credit);

%override;

%insert(credit_addin_cpp) %{
#include <qlo/objects/credit/credit.hpp>
#include <qlo/objects/instruments/creditdefaultswap.hpp>
#include <qlo/objects/instruments/cdsoption.hpp>
#include <qlo/objects/obj_pricingengines.hpp>
#include <qlo/objects/obj_schedule.hpp>
#include <qlo/objects/objmanual_termstructures.hpp>
#include <qlo/conversions/coercetermstructure.hpp>
#include <qlo/objects/objmanual_ratehelpers.hpp>
#include <qlo/objects/credit/defaultbasket.hpp>
#include <qlo/objects/credit/credit.hpp>
#include <qlo/objects/obj_exercise.hpp>

#include <ql/termstructures/yieldtermstructure.hpp>
#include <ql/termstructures/defaulttermstructure.hpp>
#include <ql/time/daycounter.hpp>
#include <ql/experimental/credit/basket.hpp>
#include <ql/experimental/credit/cdsoption.hpp>
%}

namespace QuantLibAddin {

    class PiecewiseHazardRateCurve : public DefaultProbabilityTermStructure {
      public:
        PiecewiseHazardRateCurve(
            const std::vector<boost::shared_ptr<QuantLib::DefaultProbabilityHelper> >& Helpers, //!< vector of default probability helpers.
            const QuantLib::DayCounter& DayCounter/*=Actual365Fixed*/,                          //!< DayCounter ID.
            const QuantLib::Calendar& Calendar,                                                 //!< holiday calendar (e.g. TARGET).
            const std::string& Interpolation,                                                   //!< The interpolator for hazard rates.
            QuantLib::Real Accuracy=1.0e-12                                                     //!< Bootstrapping accuracy.
        );
        %rename2(dates, HRDates);       
        //! Dates on which the hazard rate interpolation is performed.
        const std::vector<QuantLib::Date>& dates() const;
        %rename2(data, HRates);       
        //! Dates on which the hazard rate interpolation is performed.
        const std::vector<QuantLib::Real>& data() const;
    };

    class BaseCorrelationTermStructure : public CorrelationTermStructure {
      public:
        BaseCorrelationTermStructure(
            const std::string& InterpolatorType,                                                //!< The bidimensional interpolation policy over the correlation surface.
            QuantLib::Natural SettlementDays,                                                   //!< Number of settlement days.
            const QuantLib::Calendar& Calendar,                                                 //!< Calendar.
            QuantLib::BusinessDayConvention Convention,                                         //!< Time convention.
            const std::vector<QuantLib::Period>& Tenors,                                        //!< Surface tenors
            const std::vector<QuantLib::Real>& LossLevel,                                       //!< Surface loss levels as a fraction of the underlying portfolio.
            const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& Correlations,  //!< Correlation quotes.
            const QuantLib::DayCounter& DayCounter=Actual365Fixed                               //!< DayCounter ID.
        );
        %rename2(correlation, BaseCorrelationValue);       
        //! Returns the interpolated base correlation value.
        QuantLib::Real correlation(
            const QuantLib::Date& Date,                                                         //!< Interpolation date.
            QuantLib::Real LossLevel                                                            //!< Interpolation loss level.
        );
    };
}

namespace QuantLib {

    class CreditDefaultSwap : public Instrument {
    public:
        CreditDefaultSwap(
            QuantLib::Protection::Side BuyerSeller/*=Buyer*/,                                             //!< BUYER for bought, SELLER for sold protection.
            QuantLib::Real Notional,                                                            //!< Nominal amount
            QuantLib::Rate Upfront,                                                             //!< upfront in fractional units
            QuantLib::Rate Spread,                                                              //!< running spread in fractional units
            const boost::shared_ptr<QuantLib::Schedule>& PremiumSchedule,                       //!< premium leg Schedule object ID.
            QuantLib::BusinessDayConvention PaymentConvention/*=Following*/,                    //!< Payment dates' business day convention.
            const QuantLib::DayCounter& DayCounter/*=Actual/360*/,                              //!< premium leg day counter (e.g. Actual/360).
            bool SettlesAccrual=true,                                                           //!< TRUE ensures settlement of accural.
            bool PayAtDefault=true,                                                             //!< TRUE ensures payment at default time
            const QuantLib::Date& ProtectionStart=QuantLib::Date(),                             //!< protection start date.
            const QuantLib::Date& UpfrontDate=QuantLib::Date()                                  //!< upfront date.
        );

        %rename2(couponLegNPV, CdsCouponLegNPV);       
        //! Returns the CL NPV.
        QuantLib::Real couponLegNPV() const;
        %rename2(defaultLegNPV, CdsDefaultLegNPV);       
        //! Returns the DL NPV.
        QuantLib::Real defaultLegNPV() const;
        %rename2(fairSpread, CdsFairSpread);       
        //! Returns the running spread that, given the quoted recovery rate, will make the running-only CDS have an NPV of 0.
        QuantLib::Rate fairSpread() const;
        %rename2(fairUpfront, CdsFairUpfront);       
        //! Returns the upfront spread that, given the running spread and the quoted recovery rate, will make the instrument have an NPV of 0.
        QuantLib::Rate fairUpfront() const;
    };

    class MidPointCdsEngine : public PricingEngine {
      public:
        MidPointCdsEngine(
            const QuantLib::Handle<QuantLib::DefaultProbabilityTermStructure>& DefaultCurve,    //!< default term structure object ID.
            QuantLib::Real RecoveryRate,                                                        //!< constant recovery rate
            const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve                    //!< discounting yield term structure object ID.
        );
    };

    class HazardRateCurve : public DefaultProbabilityTermStructure {
      public:
        HazardRateCurve(
            const std::vector<QuantLib::Date>& CurveDates,                                      //!< dates of the curve. First date corresponds to a survival probability of one.
            const std::vector<QuantLib::Rate>& CurveRates,                                      //!< hazard rates for the above dates.
            const QuantLib::DayCounter& DayCounter=Actual365Fixed                               //!< DayCounter ID.
        );
    };

    class SpreadCdsHelper : public DefaultProbabilityHelper {
      public:
        SpreadCdsHelper(
            const QuantLib::Handle<QuantLib::Quote>& RunningSpread,                             //!< quote.
            const QuantLib::Period& Tenor,                                                      //!< CDS length (e.g. 5Y for five years).
            QuantLib::Natural SettlementDays/*=0*/,                                             //!< settlement days
            const QuantLib::Calendar& Calendar,                                                 //!< holiday calendar (e.g. TARGET).
            QuantLib::Frequency Frequency,                                                      //!< payment frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            QuantLib::BusinessDayConvention PaymentConvention,                                  //!< payment leg convention (e.g. Unadjusted).
            QuantLib::DateGeneration::Rule GenRule,                                             //!< Date generation rule (Backward, Forward, ThirdWednesday, Twentieth, TwentiethIMM, Zero).
            const QuantLib::DayCounter& DayCounter,                                             //!< day counter (e.g. Actual/360).
            QuantLib::Real RecoveryRate,                                                        //!< recovery rate
            const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscountingCurve,             //!< discounting YieldTermStructure object ID.
            bool SettleAccrual=true,                                                            //!< TRUE ensures settlement of accural.
            bool PayAtDefault=true                                                              //!< TRUE ensures payment at default time
         );
    };

    class UpfrontCdsHelper : public DefaultProbabilityHelper {
      public:
        UpfrontCdsHelper(
            const QuantLib::Handle<QuantLib::Quote>& UpfrontSpread,                             //!< upfront spread quote.
            QuantLib::Rate RunningSpread,                                                       //!< running spread.
            const QuantLib::Period& Tenor,                                                      //!< CDS length (e.g. 5Y for five years).
            QuantLib::Natural SettlementDays,                                                   //!< settlement days
            const QuantLib::Calendar& Calendar,                                                 //!< holiday calendar (e.g. TARGET).
            QuantLib::Frequency Frequency,                                                      //!< payment frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            QuantLib::BusinessDayConvention PaymentConvention,                                  //!< payment leg convention (e.g. Unadjusted).
            QuantLib::DateGeneration::Rule GenRule,                                             //!< Date generation rule (Backward, Forward, ThirdWednesday, Twentieth, TwentiethIMM, Zero).
            const QuantLib::DayCounter& DayCounter,                                             //!< day counter (e.g. Actual/360).
            QuantLib::Real RecRate,                                                             //!< recovery rate
            const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscCurve,                    //!< discounting YieldTermStructure object ID.
            QuantLib::Natural UpfSettlDays,                                                     //!< upfront settlement days
            bool SettlAccr=true,                                                                //!< TRUE ensures settlement of accural.
            bool PayAtDefault=true                                                              //!< TRUE ensures payment at default time
        );
    };

    class PiecewiseFlatForwardCurve : public YieldTermStructure {
      public:
        PiecewiseFlatForwardCurve(
            const QuantLib::Date& ReferenceDate/*=QuantLib::Date()*/,                           //!< term structure reference date.
            const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& RateHelpers,           //!< vector of rate-helpers.
            const QuantLib::DayCounter& DayCounter/*=Actual365Fixed*/,                          //!< DayCounter ID.
            QuantLib::Real Accuracy=1.0e-12                                                     //!< Bootstrapping accuracy.
        );
    };

    class RiskyFixedBond : public Instrument {
    public:
        RiskyFixedBond(
            std::string Bondname,                                                               //!< Bonds id.
            QuantLib::Currency Currency,                                                        //!< Curency of the reference bond affected.
            QuantLib::Real Recovery,                                                            //!< Recovery Rate.
            const QuantLib::Handle<QuantLib::DefaultProbabilityTermStructure>& DefaultCurve,    //!< default term structure object ID.
            const boost::shared_ptr<QuantLib::Schedule>&  Schedule,                             //!< Schedule.
            QuantLib::Real Rate,                                                                //!< Rate.
            QuantLib::DayCounter DayCounter,                                                    //!< premium leg day counter (e.g. Actual/360).
            QuantLib::BusinessDayConvention PaymentConvention/*=Following*/,                    //!< Payment dates' business day convention.
            QuantLib::Real Notional,                                                            //!< Notional.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscountingCurve,             //!< discounting YieldTermStructure object ID.
            QuantLib::Date PricingDate                                                          //!< desired npv date.
        );
    };

    class Issuer {
    public:
        Issuer(
            const boost::shared_ptr<QuantLib::DefaultProbabilityTermStructure>& DefaultCurves/*=""*/, //!< Default probability curve. By now it is associated to SeniorSec, EUR and NorthAmericaCorpDefaultKey
            const boost::shared_ptr<QuantLib::DefaultEventSet>& DefaultEvents                   //!< Credit events affecting this issuer.
        );
    };

    class DefaultEventSet {
    public:
        DefaultEventSet(
            const std::string& EventType/*=NONE*/,                                              //!< The type of default event.
            const QuantLib::Date& EventDate=QuantLib::Date(),                                   //!< Event date.
            const QuantLib::Currency& Currency=Currency,                                        //!< Curency of the reference bond affected.
            QuantLib::Seniority Seniority=NoSeniority,                                          //!< Seniority of the bond affected.
            const QuantLib::Date& SettlementDate=QuantLib::Date(),                              //!< Event settlement date.
            QuantLib::Real SettledRecovery=0.0                                                  //!< Event settlement recovery rate.
        );
    };

    class SyntheticCDO : public Instrument {
    public:
        SyntheticCDO(
              const boost::shared_ptr<QuantLib::Basket>& Basket,                                //!< Underlying tranched portfolio.
              QuantLib::Protection::Side BuyerSeller/*=Buyer*/,                                 //!< BUYER for bought, SELLER for sold protection.
              const boost::shared_ptr<QuantLib::Schedule>& PremiumSchedule,                     //!< premium leg Schedule object ID.
              QuantLib::Rate Upfront,                                                           //!< upfront in fractional units
              QuantLib::Rate Spread,                                                            //!< running spread in fractional units
              const QuantLib::DayCounter& DayCounter,                                           //!< premium leg day counter (e.g. Actual/360).
              QuantLib::BusinessDayConvention PaymentConvention=Following                       //!< Payment dates' business day convention.
        );
    };

    class MidPointCDOEngine : public PricingEngine {
      public:
        MidPointCDOEngine(
            const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve                    //!< discounting yield term structure object ID.
        );
    };

    class NthToDefault : public Instrument {
    public:
        NthToDefault(
              const boost::shared_ptr<QuantLib::Basket>& Basket,                                //!< Underlying tranched portfolio.
              QuantLib::Size Order,                                                             //!< Contract default order.
              QuantLib::Protection::Side BuyerSeller/*=Buyer*/,                                 //!< BUYER for bought, SELLER for sold protection.
              const boost::shared_ptr<QuantLib::Schedule>& PremiumSchedule,                     //!< premium leg Schedule object ID.
              QuantLib::Rate Upfront,                                                           //!< upfront in fractional units
              QuantLib::Rate Spread,                                                            //!< running spread in fractional units
              const QuantLib::DayCounter& DayCounter/*=Actual/360*/,                            //!< premium leg day counter (e.g. Actual/360).
              QuantLib::Real Notional,                                                          //!< Nominal amount
              bool SettlesAccrual                                                               //!< Accrual settled at default.
        );
    };

    class IntegralNtdEngine : public PricingEngine {
      public:
        IntegralNtdEngine(
            const QuantLib::Period& IntegrationStep,                                            //!< Integration step period.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve                    //!< discounting yield term structure object ID.
        );
    };

    class BlackCdsOptionEngine : public PricingEngine {
    public:
        BlackCdsOptionEngine(
            const QuantLib::Handle<QuantLib::DefaultProbabilityTermStructure>& DefaultCurve,    //!< default term structure object ID.
            QuantLib::Real RecoveryRate,                                                        //!< constant recovery rate
            const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve,                   //!< discounting yield term structure object ID.
            const QuantLib::Handle<QuantLib::Quote>& BlackVol                                   //!< Black Volatility.
        );
    };

    class CdsOption : public Instrument {
    public:
        CdsOption(
            const boost::shared_ptr<QuantLib::CreditDefaultSwap>& UnderlyingCDS,                //!< The CDS underlying the option.
            const boost::shared_ptr<QuantLib::Exercise>& Exercise                               //!< Exercise object ID.
        );
        %rename2(impliedVolatility, CdsOptionImpliedVol);       
        Volatility impliedVolatility(
            QuantLib::Real Price,                                                                         //!< Market price.
            const Handle<YieldTermStructure>& YieldCurve,                                       //!< discounting yield term structure object ID.
            const Handle<DefaultProbabilityTermStructure>& DefaultCurve,                        //!< default term structure object ID.
            QuantLib::Real RecoveryRate                                                                   //!< constant recovery rate
        );
    };
}
