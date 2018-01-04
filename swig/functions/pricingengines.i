
%group(Pricing Engines);

%insert(obj_hpp) %{
#include <ql/option.hpp>

namespace QuantLib {
    class Date;
    class SimpleQuote;
    class AffineModel;
    class MarketModelFactory;
    class SwaptionVolatilityStructure;
    class OptionletVolatilityStructure;
    class BlackCapFloorEngine;
    class BachelierCapFloorEngine;
    class AnalyticCapFloorEngine;
    class MarketModelCapFloorEngine;
    class BlackCalculator;
    class StrikedTypePayoff;
    class PricingEngine;
    class Quote;
    class YieldTermStructure;
    class DayCounter;
    class DiscountingBondEngine;
    class DiscountingSwapEngine;
    class GeneralizedBlackScholesProcess;
    class OneFactorAffineModel;
    class G2;

    template <class T>
    class Handle;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/obj_shortratemodels.hpp>
#include <qlo/objects/obj_payoffs.hpp>
//#include <qlo/marketmodels.hpp>
#include <qlo/objects/obj_processes.hpp>
#include <qlo/objects/obj_swaptionvolstructure.hpp>
#include <qlo/objects/obj_capletvolstructure.hpp>
#include <qlo/objects/obj_payoffs.hpp>
#include <qlo/objects/obj_shortratemodels.hpp>

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
%}

namespace QuantLib {

    //! Black 1976 formula for option pricing, using displacement.
    Real blackFormula(
        Option::Type OptionType,        //!< Option type (i.e. Call or Put).
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real StdDev,                    //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
        Real Deflator = 1.0,            //!< Deflator (usually the discount factor, or the annuity, etc.).
        Real Displacement = 0.0         //!< Displacement in a displaced diffusion model.
    );

    //! Black 1976 probability of being in the money (in the bond martingale measure), i.e. N(d2). It is a risk-neutral probability, not the real world one.
    Real blackFormulaCashItmProbability(
        Option::Type OptionType,        //!< Option type (i.e. Call or Put).
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real StdDev,                    //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
        Real Displacement = 0.0         //!< Displacement in a displaced diffusion model.
    );

    //! Approximation for the standard deviation (annualized percentage volatility times the square root of time to option expiry) implied by the Black 1976 formula.
    Real blackFormulaImpliedStdDevApproximation(
        Option::Type OptionType,        //!< Option type (i.e. Call or Put).
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real OptionPrice,               //!< Option price.
        Real Deflator = 1.0,            //!< Deflator (usually the discount factor, or the annuity, etc.).
        Real Displacement = 0.0         //!< Displacement in a displaced diffusion model.
    );

    //! Approximation for the standard deviation (annualized percentage volatility times the square root of time to option expiry) implied by the Black 1976 formula.
    Real blackFormulaImpliedStdDev(
        Option::Type OptionType,        //!< Option type (i.e. Call or Put).
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real OptionPrice,               //!< Option price.
        Real Deflator = 1.0,            //!< Deflator (usually the discount factor, or the annuity, etc.).
        Real Displacement = 0.0,        //!< Displacement in a displaced diffusion model.
        Real Guess = Null<Real>(),      //!< Standard deviation guess.
        Real Accuracy = 1.0e-6,         //!< Solver accuracy.
        Natural MaxIter = 100           //!< Solver max iterations.
    );

    //! Black 1976 formula for the derivative with respect to the standard deviation (annualized percentage volatility times the square root of time to option expiry), with displacement.
    Real blackFormulaStdDevDerivative(
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real StdDev,                    //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
        Real Deflator = 1.0,            //!< Deflator (usually the discount factor, or the annuity, etc.).
        Real Displacement = 0.0         //!< Displacement in a displaced diffusion model.
    );

    //! Black style formula when forward is normal rather than log-normal, i.e. essentially the model of Bachelier.
    Real bachelierBlackFormula(
        Option::Type OptionType,        //!< Option type (i.e. Call or Put).
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real StdDev,                    //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
        Real Deflator = 1.0             //!< Deflator (usually the discount factor, or the annuity, etc.).
    );

    //! Black style formula when forward is normal rather than log-normal, i.e. essentially the model of Bachelier.
    Real bachelierBlackFormulaImpliedVol(
        Option::Type OptionType,        //!< Option type (i.e. Call or Put).
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real TimeToExpiry,              //!< Time to expiry as year fraction.
        Real OptionPrice,               //!< Option price.
        Real Deflator = 1.0             //!< Deflator (usually the discount factor, or the annuity, etc.).
    );

    //! Black 1976 formula for option pricing with displacement. It uses a PlainVanillaPayoff object as input.
    Real blackFormula(
        Option::Type OptionType,        //!< Option type (i.e. Call or Put).
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real StdDev,                    //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
        Real Deflator = 1.0,            //!< Deflator (usually the discount factor, or the annuity, etc.).
        Real Displacement = 0.0         //!< Displacement in a displaced diffusion model.
    );

    //! Black 1976 probability of being in the money (in the bond martingale measure), i.e. N(d2). It is a risk-neutral probability, not the real world one. It uses a PlainVanillaPayoff object as input.
    Real blackFormulaCashItmProbability(
        Option::Type OptionType,        //!< Option type (i.e. Call or Put).
        Real Strike,                    //!< Option strike.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real StdDev,                    //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
        Real Displacement = 0.0         //!< Displacement in a displaced diffusion model.
    );

    //! Approximation for the standard deviation (annualized percentage volatility times the square root of time to option expiry) implied by the Black 1976 formula. It uses a PlainVanillaPayoff object as input.
    %rename(blackFormulaImpliedStdDevApproximation2) blackFormulaImpliedStdDevApproximation;
    Real blackFormulaImpliedStdDevApproximation(
        const boost::shared_ptr<PlainVanillaPayoff>& payoff,//!< PlainVanillaPayoff object ID.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real OptionPrice,               //!< Option price.
        Real Deflator = 1.0,            //!< Deflator (usually the discount factor, or the annuity, etc.).
        Real Displacement = 0.0         //!< Displacement in a displaced diffusion model.
    );

    //! Standard deviation (annualized percentage volatility times the square root of time to option expiry) implied by the Black 1976 formula. It uses a PlainVanillaPayoff object as input.
    %rename(blackFormulaImpliedStdDev2) blackFormulaImpliedStdDev;
    Real blackFormulaImpliedStdDev(
        const boost::shared_ptr<PlainVanillaPayoff>& payoff,//!< PlainVanillaPayoff object ID.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real OptionPrice,               //!< Option price.
        Real Deflator = 1.0,            //!< Deflator (usually the discount factor, or the annuity, etc.).
        Real Displacement = 0.0,        //!< Displacement in a displaced diffusion model.
        Real Guess = Null<Real>(),      //!< Standard deviation guess.
        Real Accuracy = 1.0e-6,         //!< Solver accuracy.
        Natural MaxIter = 100           //!< Solver max iterations.
    );

    //! Standard deviation (annualized percentage volatility times the square root of time to option expiry) implied by the Black 1976 formula. It uses a PlainVanillaPayoff object as input.
    %rename(blackFormulaStdDevDerivative2) blackFormulaStdDevDerivative;
    Real blackFormulaStdDevDerivative(
        const boost::shared_ptr<PlainVanillaPayoff>& payoff,//!< PlainVanillaPayoff object ID.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real StdDev,                    //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
        Real Deflator = 1.0,            //!< Deflator (usually the discount factor, or the annuity, etc.).
        Real Displacement = 0.0         //!< Displacement in a displaced diffusion model.
    );

    //! Black style formula when forward is normal rather than log-normal, i.e. essentially the model of Bachelier. It uses a PlainVanillaPayoff object as input.
    %rename(bachelierBlackFormula2) bachelierBlackFormula;
    Real bachelierBlackFormula(
        const boost::shared_ptr<PlainVanillaPayoff>& payoff,//!< PlainVanillaPayoff object ID.
        Real AtmForwardValue,           //!< Underlying asset at-the-money forward value.
        Real StdDev,                    //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
        Real Deflator = 1.0             //!< Deflator (usually the discount factor, or the annuity, etc.).
    );

    class BlackCalculator {
      public:

        BlackCalculator(
            QuantLib::Option::Type OptionType,                                      //!< Option type (i.e. Call or Put).
            Real Strike,                                                            //!< Option strike.
            Real AtmForwardValue,                                                   //!< Underlying asset at-the-money forward value.
            Real StdDev,                                                            //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
            Real Deflator = 1.0                                                     //!< Deflator (usually the discount factor, or the annuity, etc.).
        );

        %rename(BlackCalculator2) BlackCalculator;
        BlackCalculator(
            const boost::shared_ptr<QuantLib::StrikedTypePayoff>& PayoffID,         //!< StrikedTypePayoff ID.
            Real AtmForwardValue,                                                   //!< Underlying asset at-the-money forward value.
            Real StdDev,                                                            //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
            Real Deflator = 1.0                                                     //!< Deflator (usually the discount factor, or the annuity, etc.).
        );

        //! Returns the option value for the given BlackCalculator object.
        Real value() const;

        //! Returns the sensitivity to change in the underlying forward price for the given BlackCalculator object.
        Real deltaForward() const;

        //! Returns the sensitivity to change in the underlying spot price for the given BlackCalculator object.
        virtual Real delta(
            Real Spot                   //!< Spot value.
        ) const;

        //! Returns the sensitivity in percent to a percent change in the underlying forward price for the given BlackCalculator object.
        Real elasticityForward() const;

        //! Returns the sensitivity in percent to a percent change in the underlying spot price for the given BlackCalculator object.
        virtual Real elasticity(
            Real Spot                   //!< Spot value.
        ) const;

        //! Returns the second order derivative with respect to change in the underlying forward price for the given BlackCalculator object.
        Real gammaForward() const;

        //! Returns the second order derivative with respect to change in the underlying spot price for the given BlackCalculator object.
        virtual Real gamma(
            Real Spot                   //!< Spot value.
        ) const;

        //! Returns the sensitivity to time to maturity for the given BlackCalculator object.
        virtual Real theta(
            Real Spot,                  //!< Spot value.
            Time Maturity               //!< Time to maturity in years.
        ) const;

        //! Returns the sensitivity to time to maturity per day, assuming 365 days per year, for the given BlackCalculator object.
        virtual Real thetaPerDay(
            Real Spot,                  //!< Spot value.
            Time Maturity               //!< Time to maturity in years.
        ) const;

        //! Returns the sensitivity to volatility for the given BlackCalculator object.
        Real vega(
            Time Maturity               //!< Time to maturity in years.
        ) const;

        //! Returns the sensitivity to discounting rate for the given BlackCalculator object.
        Real rho(
            Time Maturity               //!< Time to maturity in years.
        ) const;

        //! Returns the sensitivity to dividend/growth rate for the given BlackCalculator object.
        Real dividendRho(
            Time Maturity               //!< Time to maturity in years.
        ) const;

        //! Returns the probability of being in the money in the bond martingale measure for the given BlackCalculator object. It is a risk-neutral probability, not the real world probability.
        Real itmCashProbability() const;

        //! Returns the probability of being in the money in the asset martingale measure for the given BlackCalculator object. It is a risk-neutral probability, not the real world probability.
        Real itmAssetProbability() const;

        //! Returns the sensitivity to strike for the given BlackCalculator object.
        Real strikeSensitivity() const;

        //! Returns the alpha of the internal formulation of the given BlackCalculator object.
        Real alpha() const;

        //! Returns the beta of the internal formulation of the given BlackCalculator object.
        Real beta() const;
%insert(rp_class) %{
      protected:
        RP_LIB_CTOR(BlackCalculator, QuantLib::BlackCalculator);
%}
    };

    class BlackScholesCalculator : public BlackCalculator {
      public:

        BlackScholesCalculator(
            QuantLib::Option::Type OptionType,                                      //!< Option type (i.e. Call or Put).
            Real Strike,                                                            //!< Option strike.
            Real Spot,                                                              //!< Spot value.
            Real Growth,                                                            //!< Growth discount factor.
            Real StdDev,                                                            //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
            Real Deflator = 1.0                                                     //!< Deflator (usually the discount factor, or the annuity, etc.).
        );

        %rename(BlackScholesCalculator2) BlackScholesCalculator;
        BlackScholesCalculator(
            const boost::shared_ptr<QuantLib::StrikedTypePayoff>& PayoffID,         //!< StrikedTypePayoff ID.
            Real Spot,                                                              //!< Spot value.
            Real Growth,                                                            //!< Growth discount factor.
            Real StdDev,                                                            //!< Standard deviation, i.e. annualized percentage volatility times the square root of time to option expiry.
            Real Deflator = 1.0                                                     //!< Deflator (usually the discount factor, or the annuity, etc.).
        );

        //! Returns the sensitivity to change in the underlying spot price for the given BlackScholesCalculator object.
        Real delta() const;

        //! Returns the sensitivity in percent to a percent change in the underlying spot price for the given BlackScholesCalculator object.
        Real elasticity() const;

        //! Returns the second order derivative with respect to change in the underlying spot price for the given BlackScholesCalculator object.
        Real gamma() const;

        //! Returns the sensitivity to time to maturity for the given BlackScholesCalculator object.
        Real theta(
            Time Maturity               //!< Time to maturity in years.
        ) const;

        //! Returns the sensitivity to time to maturity per day, assuming 365 days per year, for the given BlackScholesCalculator object.
        Real thetaPerDay(
            Time Maturity               //!< Time to maturity in years.
        ) const;
    };

    class PricingEngine {
      public:

        %noimpl(PricingEngine);
        PricingEngine(
            const std::string& EngineID,                                                    //!< Engine type.
            const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess>& ProcessID    //!< GeneralizedBlackScholesProcess object ID.
        );

        %rename(BinomialPricingEngine) PricingEngine;
        %noimpl(PricingEngine);
        PricingEngine(
            const std::string& EngineID,                                                    //!< Engine type.
            const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess>& ProcessID,   //!< GeneralizedBlackScholesProcess object ID.
            const long& TimeSteps                                                           //!< #/time steps.
        );
%insert(rp_class) %{
      protected:
        RP_LIB_CTOR(PricingEngine, QuantLib::PricingEngine);
%}
    };

    class DiscountingSwapEngine : public PricingEngine {
      public:

        DiscountingSwapEngine(
            const Handle<YieldTermStructure>& YieldCurve/* = Handle<YieldTermStructure>()*/,//!< Discounting yield term structure object ID.
            bool IncludeSettlDate = true,                                                   //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate = Date(),                                                   //!< Cashflows before this date are not taken into account. If missing it is assumed equal to the discounting yield term structure's reference date.
            Date NpvDate = Date()                                                           //!< All cashflows are discounted to this date. If missing it is assumed equal to the discounting yield term structure's reference date.
        );
    };

    class BlackSwaptionEngine : public PricingEngine {
      public:

        BlackSwaptionEngine(
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve,       //!< Discounting yield term structure object ID.
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure> &VolTS    //!< SwaptionVolatilityStructure object ID.
        );

        %rename(BlackSwaptionEngine2) BlackSwaptionEngine;
        %noimpl(BlackSwaptionEngine);
        BlackSwaptionEngine(
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve,       //!< Discounting yield term structure object ID.
            const QuantLib::Handle<QuantLib::Quote>& Vol,                           //!< Swaption Black volatility.
            const QuantLib::Real Displacement,                                      //!< Displacement in a displaced diffusion model.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed()                 //!< DayCounter ID.
        );
    };

    class BlackCapFloorEngine : public PricingEngine {
      public:

        BlackCapFloorEngine(
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve,       //!< Discounting yield term structure object ID.
            const QuantLib::Handle<QuantLib::OptionletVolatilityStructure> &VolTS,  //!< OptionletVolatilityStructure object ID.
            const QuantLib::Real Displacement                                       //!< Displacement in a displaced diffusion model.
        );

        %rename(BlackCapFloorEngine2) BlackCapFloorEngine;
        %noimpl(BlackCapFloorEngine);
        BlackCapFloorEngine(
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve,       //!< Discounting yield term structure object ID.
            const QuantLib::Handle<QuantLib::Quote>& Vol,                           //!< Swaption Black volatility.
            const QuantLib::Real Displacement,                                      //!< Displacement in a displaced diffusion model.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed()                 //!< DayCounter ID.
        );
    };

    class BachelierCapFloorEngine : public PricingEngine {
      public:

        BachelierCapFloorEngine(
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve,       //!< Discounting yield term structure object ID.
            const QuantLib::Handle<QuantLib::OptionletVolatilityStructure> &VolTS   //!< OptionletVolatilityStructure object ID.
        );

        %rename(BachelierCapFloorEngine2) BachelierCapFloorEngine;
        BachelierCapFloorEngine(
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve,       //!< Discounting yield term structure object ID.
            const QuantLib::Handle<QuantLib::Quote>& Vol,                           //!< Swaption Black volatility.
            const QuantLib::DayCounter& dayCounter 
        );
    };

    class AnalyticCapFloorEngine : public PricingEngine {
      public:

        AnalyticCapFloorEngine(
            const boost::shared_ptr<QuantLib::AffineModel>& HandleModel             //!< Affine model (providing a discount bond option pricing formula) object ID.
        );
    };

    class BondEngine : public PricingEngine {
      public:

        %noimpl(BondEngine);
        BondEngine(
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve        //!< Discounting yield term structure object ID.
        );
    };

    class JamshidianSwaptionEngine : public PricingEngine {
    public:

        JamshidianSwaptionEngine(
            const boost::shared_ptr<QuantLib::OneFactorAffineModel>& Model,         //!< Model object ID.
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve        //!< Discounting yield term structure object ID.
        );
    };

    class TreeSwaptionEngine : public PricingEngine {
    public:

        TreeSwaptionEngine(
            const boost::shared_ptr<QuantLib::OneFactorAffineModel>& Model,         //!< Model object ID.
            QuantLib::Size Nsteps,                                                  //!< Number of time steps.
            const QuantLib::Handle<QuantLib::YieldTermStructure> &YieldCurve        //!< Discounting yield term structure object ID.
        );
    };

    class G2SwaptionEngine : public PricingEngine {
    public:

        %rename(ModelG2SwaptionEngine) G2SwaptionEngine;
        G2SwaptionEngine(
               const boost::shared_ptr<QuantLib::G2>& Model,                        //!< G2 Model object ID.
               QuantLib::Real Range,                                                //!< Range.
               QuantLib::Size Intervals                                             //!< Intervals.
        );
    };
}

