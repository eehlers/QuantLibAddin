
%group(Credit);

%insert(obj_hpp) %{
#include <qlo/objects/obj_instruments.hpp>
#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/obj_piecewiseyieldcurve.hpp>
#include <qlo/objects/obj_defaulttermstructures.hpp>
#include <qlo/objects/obj_schedule.hpp>
#include <qlo/objects/obj_pricingengines.hpp>
#include <qlo/objects/obj_quotes.hpp>

#include <ql/handle.hpp>
#include <ql/time/daycounter.hpp>
#include <ql/time/schedule.hpp>
#include <ql/time/businessdayconvention.hpp>
#include <ql/types.hpp>
#include <ql/instruments/creditdefaultswap.hpp>
#include <ql/termstructures/credit/defaultprobabilityhelpers.hpp>
#include <ql/currency.hpp>
#include <ql/experimental/credit/issuer.hpp>
#include <ql/experimental/credit/recoveryratequote.hpp>
#include <ql/experimental/credit/cdsoption.hpp>
#include <ql/experimental/credit/blackcdsoptionengine.hpp>

namespace QuantLib {
    class Quote;
    class Date;
    class Basket;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_defaultbasket.hpp>
#include <qlo/objects/obj_exercise.hpp>
#include <qlo/enumerations/factories/termstructuresfactory.hpp>

#include <ql/instruments/stock.hpp>
#include <ql/quote.hpp>
#include <ql/currencies/europe.hpp>
#include <ql/time/daycounter.hpp>
#include <ql/time/daycounters/actual360.hpp>
#include <ql/termstructures/credit/interpolatedhazardratecurve.hpp>
#include <ql/termstructures/yield/piecewiseyieldcurve.hpp>
#include <ql/termstructures/credit/piecewisedefaultcurve.hpp>
#include <ql/math/interpolations/backwardflatinterpolation.hpp>
#include <ql/math/interpolations/loginterpolation.hpp>
#include <ql/pricingengines/credit/midpointcdsengine.hpp>

#include <ql/experimental/credit/riskybond.hpp>
#include <ql/experimental/credit/syntheticcdo.hpp>
#include <ql/experimental/credit/midpointcdoengine.hpp>
#include <ql/experimental/credit/nthtodefault.hpp>
#include <ql/experimental/credit/integralntdengine.hpp>

#include <boost/algorithm/string/case_conv.hpp>
#include <boost/make_shared.hpp>

#include <ql/settings.hpp>
%}

//%insert(credit_addin_cpp) %{
//#include <qlo/objects/credit/credit.hpp>
//#include <qlo/objects/instruments/creditdefaultswap.hpp>
//#include <qlo/objects/instruments/cdsoption.hpp>
//#include <qlo/objects/obj_pricingengines.hpp>
//#include <qlo/objects/obj_schedule.hpp>
//#include <qlo/objects/objmanual_termstructures.hpp>
//#include <qlo/conversions/coercetermstructure.hpp>
//#include <qlo/objects/objmanual_ratehelpers.hpp>
//#include <qlo/objects/credit/defaultbasket.hpp>
//#include <qlo/objects/credit/credit.hpp>
//#include <qlo/objects/obj_exercise.hpp>
//
//#include <ql/termstructures/yieldtermstructure.hpp>
//#include <ql/termstructures/defaulttermstructure.hpp>
//#include <ql/time/daycounter.hpp>
//#include <ql/experimental/credit/basket.hpp>
//#include <ql/experimental/credit/cdsoption.hpp>
//%}

namespace QuantLib {

    class CreditDefaultSwap : public Instrument {
    public:

        %noimpl(CreditDefaultSwap);
        CreditDefaultSwap(
            Protection::Side BuyerSeller/*=Buyer*/,                                     //!< BUYER for bought, SELLER for sold protection.
            Real Notional,                                                              //!< Nominal amount
            Rate Upfront,                                                               //!< Upfront in fractional units
            Rate Spread,                                                                //!< Running spread in fractional units
            const Schedule& PremiumSchedule,                                            //!< Premium leg Schedule object ID.
            BusinessDayConvention PaymentConvention/*=Following*/,                      //!< Payment dates' business day convention.
            const DayCounter& DayCounter/*=Actual/360*/,                                //!< Premium leg day counter (e.g. Actual/360).
            bool SettlesAccrual=true,                                                   //!< TRUE ensures settlement of accural.
            bool PayAtDefault=true,                                                     //!< TRUE ensures payment at default time
            const Date& ProtectionStart=Date(),                                         //!< Protection start date.
            const Date& UpfrontDate=Date()                                              //!< Upfront date.
        );

        //! Returns the CL NPV.
        %rename2(couponLegNPV, CdsCouponLegNPV);       
        Real couponLegNPV() const;

        //! Returns the DL NPV.
        %rename2(defaultLegNPV, CdsDefaultLegNPV);       
        Real defaultLegNPV() const;

        //! Returns the running spread that, given the quoted recovery rate, will make the running-only CDS have an NPV of 0.
        %rename2(fairSpread, CdsFairSpread);       
        Rate fairSpread() const;

        //! Returns the upfront spread that, given the running spread and the quoted recovery rate, will make the instrument have an NPV of 0.
        %rename2(fairUpfront, CdsFairUpfront);       
        Rate fairUpfront() const;
    };

    class MidPointCdsEngine : public PricingEngine {
      public:

        MidPointCdsEngine(
            const Handle<DefaultProbabilityTermStructure>& DefaultCurve,                //!< Default term structure object ID.
            Real RecoveryRate,                                                          //!< Constant recovery rate
            const Handle<YieldTermStructure>& YieldCurve                                //!< Discounting yield term structure object ID.
        );
    };

    class HazardRateCurve : public DefaultProbabilityTermStructure {
      public:

        %noimpl(HazardRateCurve);
        HazardRateCurve(
            const std::vector<Date>& CurveDates,                                        //!< Dates of the curve. First date corresponds to a survival probability of one.
            const std::vector<Rate>& CurveRates,                                        //!< Hazard rates for the above dates.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed()                     //!< DayCounter ID.
        );
    };

    class PiecewiseHazardRateCurve : public DefaultProbabilityTermStructure {
      public:

        %noimpl(PiecewiseHazardRateCurve);
        PiecewiseHazardRateCurve(
            const std::vector<boost::shared_ptr<DefaultProbabilityHelper> >& Helpers,   //!< Vector of default probability helpers.
            const DayCounter& DayCounter/*=QuantLib::Actual365Fixed()*/,                //!< DayCounter ID.
            const Calendar& Calendar,                                                   //!< Holiday calendar (e.g. TARGET).
            const std::string& Interpolation,                                           //!< The interpolator for hazard rates.
            Real Accuracy=1.0e-12                                                       //!< Bootstrapping accuracy.
        );

        //! Dates on which the hazard rate interpolation is performed.
        %wrap(dates);
        %rename2(dates, HRDates);
        const std::vector<Date>& dates() const;

        //! Dates on which the hazard rate interpolation is performed.
        %wrap(data);
        %rename2(data, HRates);       
        const std::vector<Real>& data() const;
    };

    class DefaultProbabilityHelper {};

    class SpreadCdsHelper : public DefaultProbabilityHelper {
      public:

        SpreadCdsHelper(
            const Handle<Quote>& RunningSpread,                                         //!< Quote.
            const Period& Tenor,                                                        //!< CDS length (e.g. 5Y for five years).
            Natural SettlementDays/*=0*/,                                               //!< Settlement days
            const Calendar& Calendar,                                                   //!< Holiday calendar (e.g. TARGET).
            Frequency Frequency,                                                        //!< Payment frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            BusinessDayConvention PaymentConvention,                                    //!< Payment leg convention (e.g. Unadjusted).
            DateGeneration::Rule GenRule,                                               //!< Date generation rule (Backward, Forward, ThirdWednesday, Twentieth, TwentiethIMM, Zero).
            const DayCounter& DayCounter,                                               //!< Day counter (e.g. Actual/360).
            Real RecoveryRate,                                                          //!< Recovery rate
            const Handle<YieldTermStructure>& DiscountingCurve,                         //!< Discounting YieldTermStructure object ID.
            bool SettleAccrual=true,                                                    //!< TRUE ensures settlement of accural.
            bool PayAtDefault=true                                                      //!< TRUE ensures payment at default time
         );
    };

    class UpfrontCdsHelper : public DefaultProbabilityHelper {
      public:

        UpfrontCdsHelper(
            const Handle<Quote>& UpfrontSpread,                                         //!< Upfront spread quote.
            Rate RunningSpread,                                                         //!< Running spread.
            const Period& Tenor,                                                        //!< CDS length (e.g. 5Y for five years).
            Natural SettlementDays,                                                     //!< Settlement days
            const Calendar& Calendar,                                                   //!< Holiday calendar (e.g. TARGET).
            Frequency Frequency,                                                        //!< Payment frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            BusinessDayConvention PaymentConvention,                                    //!< Payment leg convention (e.g. Unadjusted).
            DateGeneration::Rule GenRule,                                               //!< Date generation rule (Backward, Forward, ThirdWednesday, Twentieth, TwentiethIMM, Zero).
            const DayCounter& DayCounter,                                               //!< Day counter (e.g. Actual/360).
            Real RecRate,                                                               //!< Recovery rate
            const Handle<YieldTermStructure>& DiscCurve,                                //!< Discounting YieldTermStructure object ID.
            Natural UpfSettlDays,                                                       //!< Upfront settlement days
            bool SettlAccr=true,                                                        //!< TRUE ensures settlement of accural.
            bool PayAtDefault=true                                                      //!< TRUE ensures payment at default time
        );
    };

    class PiecewiseFlatForwardCurve : public YieldTermStructure {
      public:

        %noimpl(PiecewiseFlatForwardCurve);
        PiecewiseFlatForwardCurve(
            const Date& ReferenceDate/*=Date()*/,                                       //!< Term structure reference date.
            const std::vector<boost::shared_ptr<RateHelper> >& RateHelpers,             //!< Vector of rate-helpers.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),                    //!< DayCounter ID.
            Real Accuracy=1.0e-12                                                       //!< Bootstrapping accuracy.
        );
    };

    class RiskyFixedBond : public Instrument {
    public:

        %noimpl(RiskyFixedBond);
        RiskyFixedBond(
            std::string Bondname,                                                       //!< Bonds id.
            Currency Currency,                                                          //!< Curency of the reference bond affected.
            Real Recovery,                                                              //!< Recovery Rate.
            const Handle<DefaultProbabilityTermStructure>& DefaultCurve,                //!< Default term structure object ID.
            const Schedule&  Schedule,                                                  //!< Schedule.
            Real Rate,                                                                  //!< Rate.
            DayCounter DayCounter,                                                      //!< Premium leg day counter (e.g. Actual/360).
            BusinessDayConvention PaymentConvention/*=Following*/,                      //!< Payment dates' business day convention.
            Real Notional,                                                              //!< Notional.
            const Handle<YieldTermStructure>& DiscountingCurve,                         //!< Discounting YieldTermStructure object ID.
            Date PricingDate                                                            //!< Desired npv date.
        );
    };

    class Issuer {
    public:

        %noimpl(Issuer);
        Issuer(
            const boost::shared_ptr<DefaultProbabilityTermStructure>& DefaultCurves,    //!< Default probability curve. By now it is associated to SeniorSec, EUR and NorthAmericaCorpDefaultKey
            const boost::shared_ptr<DefaultEventSet>& DefaultEvents                     //!< Credit events affecting this issuer.
        );
    };

    class DefaultEventSet {
    public:

        %noimpl(DefaultEventSet);
        %rename(DefaultEvent) DefaultEventSet;
        DefaultEventSet(
            const std::string& EventType/*=NONE*/,                                      //!< The type of default event.
            const Date& EventDate=Date(),                                               //!< Event date.
            const Currency& Currency=Currency,                                          //!< Curency of the reference bond affected.
            Seniority Seniority=NoSeniority,                                            //!< Seniority of the bond affected.
            const Date& SettlementDate=Date(),                                          //!< Event settlement date.
            Real SettledRecovery=0.0                                                    //!< Event settlement recovery rate.
        );
    };

    class SyntheticCDO : public Instrument {
    public:

        SyntheticCDO(
              const boost::shared_ptr<Basket>& Basket,                                  //!< Underlying tranched portfolio.
              Protection::Side BuyerSeller/*=Buyer*/,                                   //!< BUYER for bought, SELLER for sold protection.
              //const boost::shared_ptr<Schedule>& PremiumSchedule,                       //!< Premium leg Schedule object ID.
              const Schedule& PremiumSchedule,                                          //!< Premium leg Schedule object ID.
              Rate Upfront,                                                             //!< Upfront in fractional units
              Rate Spread,                                                              //!< Running spread in fractional units
              const DayCounter& DayCounter,                                             //!< Premium leg day counter (e.g. Actual/360).
              BusinessDayConvention PaymentConvention=Following                         //!< Payment dates' business day convention.
        );
    };

    class MidPointCDOEngine : public PricingEngine {
      public:

        MidPointCDOEngine(
            const Handle<YieldTermStructure>& YieldCurve                                //!< Discounting yield term structure object ID.
        );
    };

    class NthToDefault : public Instrument {
    public:

        NthToDefault(
              const boost::shared_ptr<Basket>& Basket,                                  //!< Underlying tranched portfolio.
              Size Order,                                                               //!< Contract default order.
              Protection::Side BuyerSeller/*=Buyer*/,                                   //!< BUYER for bought, SELLER for sold protection.
              //const boost::shared_ptr<Schedule>& PremiumSchedule,                       //!< Premium leg Schedule object ID.
              const Schedule& PremiumSchedule,                                          //!< Premium leg Schedule object ID.
              Rate Upfront,                                                             //!< Upfront in fractional units
              Rate Spread,                                                              //!< Running spread in fractional units
              const DayCounter& DayCounter/*=Actual/360*/,                              //!< Premium leg day counter (e.g. Actual/360).
              Real Notional,                                                            //!< Nominal amount
              bool SettlesAccrual                                                       //!< Accrual settled at default.
        );
    };

    class IntegralNtdEngine : public PricingEngine {
      public:

        IntegralNtdEngine(
            const Period& IntegrationStep,                                              //!< Integration step period.
            const Handle<YieldTermStructure>& YieldCurve                                //!< Discounting yield term structure object ID.
        );
    };

    class BlackCdsOptionEngine : public PricingEngine {
    public:

        BlackCdsOptionEngine(
            const Handle<DefaultProbabilityTermStructure>& DefaultCurve,                //!< Default term structure object ID.
            Real RecoveryRate,                                                          //!< Constant recovery rate
            const Handle<YieldTermStructure>& YieldCurve,                               //!< Discounting yield term structure object ID.
            const Handle<Quote>& BlackVol                                               //!< Black Volatility.
        );
    };

    class CdsOption : public Instrument {
    public:

        CdsOption(
            const boost::shared_ptr<CreditDefaultSwap>& UnderlyingCDS,                  //!< The CDS underlying the option.
            const boost::shared_ptr<Exercise>& Exercise                                 //!< Exercise object ID.
        );

        //! Implied black CDS option volatility.
        %rename2(impliedVolatility, CdsOptionImpliedVol);       
        Volatility impliedVolatility(
            Real Price,                                                                 //!< Market price.
            const Handle<YieldTermStructure>& YieldCurve,                               //!< Discounting yield term structure object ID.
            const Handle<DefaultProbabilityTermStructure>& DefaultCurve,                //!< Default term structure object ID.
            Real RecoveryRate                                                           //!< Constant recovery rate
        );
    };

    class CorrelationTermStructure : public TermStructure {};

    class BaseCorrelationTermStructure : public CorrelationTermStructure {
      public:

        %noimpl(BaseCorrelationTermStructure);
        BaseCorrelationTermStructure(
            const std::string& InterpolatorType,                                        //!< The bidimensional interpolation policy over the correlation surface.
            Natural SettlementDays,                                                     //!< Number of settlement days.
            const Calendar& Calendar,                                                   //!< Calendar.
            BusinessDayConvention Convention,                                           //!< Time convention.
            const std::vector<Period>& Tenors,                                          //!< Surface tenors
            const std::vector<Real>& LossLevel,                                         //!< Surface loss levels as a fraction of the underlying portfolio.
            const std::vector<std::vector<Handle<Quote> > >& Correlations,              //!< Correlation quotes.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed()                     //!< DayCounter ID.
        );

        //! Returns the interpolated base correlation value.
        %wrap(correlation);
        %rename2(correlation, BaseCorrelationValue);       
        Real correlation(
            const Date& Date,                                                           //!< Interpolation date.
            Real LossLevel                                                              //!< Interpolation loss level.
        );
%insert(rp_class) %{
      private:
        const std::string interpolType_; // or a local enumerator
%}
    };
}
