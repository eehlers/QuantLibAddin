
%group(Smile Section Structures);

%insert(obj_hpp) %{
#include <ql/types.hpp>
#include <ql/termstructures/volatility/volatilitytype.hpp>

namespace QuantLib {
    class Date;
    class SmileSection;
    class DayCounter;
    class EndCriteria;
    class Quote;
    class OptimizationMethod;
    class SabrVolSurface;

    template <class T>
    class Handle;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_optimization.hpp>
#include <qlo/objects/obj_volatilities.hpp>

#include <ql/termstructures/volatility/interpolatedsmilesection.hpp>
#include <ql/termstructures/volatility/sabrinterpolatedsmilesection.hpp>
#include <ql/experimental/volatility/sabrvolsurface.hpp>
#include <ql/math/interpolations/sabrinterpolation.hpp>
#include <ql/termstructures/volatility/flatsmilesection.hpp>
#include <ql/quotes/simplequote.hpp>
%}

namespace QuantLib {

    class SmileSection /*: public virtual Observable, public virtual Observer*/ {
      public:

        //! Returns the volatility at a given strike from the SmileSection object.
        Volatility volatility(
            Rate Strike=QuantLib::Null<QuantLib::Real>()            //!< Strike.
        ) const;

        //! Returns the variance at a given strike from the SmileSection object.
        Real variance(
            Rate Strike=QuantLib::Null<QuantLib::Real>()            //!< Strike.
        ) const;

        //! Returns the current value of the SmileSection underlying.
        virtual Real atmLevel() const;

        //! Returns the exercise date of the SmileSection object.
        virtual const Date& exerciseDate() const;

        //! Returns the DayCounter of the SmileSection object.
        virtual const DayCounter& dayCounter() const;
    };

    class FlatSmileSection : public SmileSection {
      public:
        FlatSmileSection(
            const Date& OptionDate,                                                                 //!< Smile's expiry as date.
            Volatility Volatility,                                                                  //!< Volatilities.
            const DayCounter& DayCounter/*Actual/365 (Fixed)*/,                                     //!< DayCounter ID.
            const Date& RefDate/* = Date()*/,                                                       //!< Reference date.
            Real AtmValue/* = Null<Rate>()*/,                                                       //!< Current value of the underlying.
            VolatilityType VolatilityType = QuantLib::VolatilityType(QuantLib::ShiftedLognormal),   //!< Volatility type: Normal or ShiftedLognormal.
            Real Displacement = 0.0                                                                 //!< Shift for the lognormal model.
        );
    };

    class SabrInterpolatedSmileSection : public SmileSection/*, public LazyObject*/ {
      public:

        SabrInterpolatedSmileSection(
            const Date& OptionDate,                                 //!< Smile's expiry as Date.
            const Rate& ForwardRate,                                //!< ATM forward rate.
            const std::vector<Rate>& Strike,                        //!< Strikes.
            bool FloatingStrike,                                    //!< Strikes are floating or fixed.
            const Volatility& AtmVolatility,                        //!< ATM volatility.
            const std::vector<Volatility>& VolatilitySpreads,       //!< Volatilities spread at option expiries.
            Real Alpha=QuantLib::Null<QuantLib::Real>(),            //!< Alpha (fixed value or guess).
            Real Beta=QuantLib::Null<QuantLib::Real>(),             //!< Beta (fixed value or guess).
            Real Nu=QuantLib::Null<QuantLib::Real>(),               //!< Nu (fixed value or guess).
            Real Rho=QuantLib::Null<QuantLib::Real>(),              //!< Rho (fixed value or guess).
            bool AlphaIsFixed = false,                              //!< TRUE if the alpha value provided is to be kept fixed, FALSE if it is just a guess.
            bool BetaIsFixed = false,                               //!< TRUE if the beta value provided is to be kept fixed, FALSE if it is just a guess.
            bool NuIsFixed = false,                                 //!< TRUE if the nu value provided is to be kept fixed, FALSE if it is just a guess.
            bool RhoIsFixed = false,                                //!< TRUE if the rho value provided is to be kept fixed, FALSE if it is just a guess.
            bool VegaWeighted = false,                              //!< TRUE if the interpolation is weighted using options Vega.
            const boost::shared_ptr<EndCriteria>& EndCriteria = boost::shared_ptr<EndCriteria>(),//!< EndCriteria object ID.
            const boost::shared_ptr<OptimizationMethod>& Method = boost::shared_ptr<OptimizationMethod>(),//!< OptimizationMethod object ID.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed() //!< DayCounter ID.
        );

        %rename(SabrInterpolatedSmileSection1) SabrInterpolatedSmileSection;
        %noimpl(SabrInterpolatedSmileSection);
        SabrInterpolatedSmileSection(
            const QuantLib::Date& OptionDate,                       //!< Smile's expiry as Date.
            const QuantLib::Handle<QuantLib::Quote>& ForwardRate,   //!< ATM forward rate quote.
            const std::vector<QuantLib::Rate>& Strike,              //!< Strikes.
            bool FloatingStrike,                                    //!< Strikes are floating or fixed.
            const QuantLib::Handle<QuantLib::Quote>& AtmVolatility, //!< ATM volatility quote.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& VolatilitySpreads,//!< Volatilities spread quotes at option expiries.
            Real Alpha=QuantLib::Null<QuantLib::Real>(),            //!< Alpha (fixed value or guess).
            Real Beta=QuantLib::Null<QuantLib::Real>(),             //!< Beta (fixed value or guess).
            Real Nu=QuantLib::Null<QuantLib::Real>(),               //!< Nu (fixed value or guess).
            Real Rho=QuantLib::Null<QuantLib::Real>(),              //!< Rho (fixed value or guess).
            bool AlphaIsFixed = false,                              //!< TRUE if the alpha value provided is to be kept fixed, FALSE if it is just a guess.
            bool BetaIsFixed = false,                               //!< TRUE if the beta value provided is to be kept fixed, FALSE if it is just a guess.
            bool NuIsFixed = false,                                 //!< TRUE if the nu value provided is to be kept fixed, FALSE if it is just a guess.
            bool RhoIsFixed = false,                                //!< TRUE if the rho value provided is to be kept fixed, FALSE if it is just a guess.
            bool VegaWeighted = false,                              //!< TRUE if the interpolation is weighted using options Vega.
            const boost::shared_ptr<EndCriteria>& EndCriteria = boost::shared_ptr<EndCriteria>(),//!< EndCriteria object ID.
            const boost::shared_ptr<OptimizationMethod>& Method = boost::shared_ptr<OptimizationMethod>(),//!< OptimizationMethod object ID.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed() //!< DayCounter ID.
        );

        //! Returns the alpha of the SABR fit for the given SabrInterpolatedSmileSection object.
        Real alpha() const;

        //! Returns the beta of the SABR fit.
        Real beta() const;

        //! Returns the nu of the SABR fit for the given SabrInterpolatedSmileSection object.
        Real nu() const;

        //! Returns the rho of the SABR fit for the given SabrInterpolatedSmileSection object.
        Real rho() const;

        //! Returns the error of the SABR fit for the given SabrInterpolatedSmileSection object.
        %rename(error) rmsError;
        Real rmsError() const;

        //! Returns the max error of the SABR fit for the given SabrInterpolatedSmileSection object.
        Real maxError() const;

        //! Returns the optimization end criteria of the SABR fit for the given SabrInterpolatedSmileSection object.
        EndCriteria::Type endCriteria() const;
    };

    class SabrSmileSection : public SmileSection {
      public:

        %noimpl(SabrSmileSection);
        SabrSmileSection(
            const QuantLib::Time OptionTime,                                //!< Smile's expiry as time.
            const std::vector<QuantLib::Rate>& Strikes,                     //!< Strikes.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& StdDevs, //!< Standard deviations (i.e. volatilities times square root of time to option expiry).
            const QuantLib::Handle<QuantLib::Quote>& Forward,               //!< ATM rate.
            Real Alpha=QuantLib::Null<QuantLib::Real>(),                    //!< Alpha (fixed value or guess).
            Real Beta=QuantLib::Null<QuantLib::Real>(),                     //!< Beta (fixed value or guess).
            Real Nu=QuantLib::Null<QuantLib::Real>(),                       //!< Nu (fixed value or guess).
            Real Rho=QuantLib::Null<QuantLib::Real>(),                      //!< Rho (fixed value or guess).
            bool AlphaIsFixed = false,                                      //!< TRUE if the alpha value provided is to be kept fixed, FALSE if it is just a guess.
            bool BetaIsFixed = false,                                       //!< TRUE if the beta value provided is to be kept fixed, FALSE if it is just a guess.
            bool NuIsFixed = false,                                         //!< TRUE if the nu value provided is to be kept fixed, FALSE if it is just a guess.
            bool RhoIsFixed = false,                                        //!< TRUE if the rho value provided is to be kept fixed, FALSE if it is just a guess.
            bool VegaWeighted = false,                                      //!< TRUE if the interpolation is weighted using options Vega.
            const boost::shared_ptr<EndCriteria>& EndCriteria = boost::shared_ptr<EndCriteria>(),           //!< EndCriteria object ID.
            const boost::shared_ptr<OptimizationMethod>& Method = boost::shared_ptr<OptimizationMethod>()   //!< OptimizationMethod object ID.
        );
    };

    class InterpolatedSmileSection : public SmileSection {
      public:

        %noimpl(InterpolatedSmileSection);
        InterpolatedSmileSection(
            const QuantLib::Date& OptionDate,                               //!< Smile's expiry as date.
            const std::vector<QuantLib::Rate>& Strikes,                     //!< Strikes.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& StdDevs, //!< Standard deviations (i.e. volatilities times square root of time to option expiry).
            const QuantLib::Handle<QuantLib::Quote>& AtmLevel,              //!< Current value of the underlying.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),        //!< DayCounter ID.
            VolatilityType VolatilityType = QuantLib::VolatilityType(QuantLib::ShiftedLognormal),   //!< Volatility type: Normal or ShiftedLognormal.
            Real Displacement = 0.0                                         //!< Shift for the lognormal model.
        );
    };
    
    class SmileSectionFromSabrVolSurface : public SmileSection {
    public:
        %noimpl(SmileSectionFromSabrVolSurface);
        SmileSectionFromSabrVolSurface(
            const QuantLib::Handle<QuantLib::SabrVolSurface>& SabrVolSurface,   //!< SabrVolSurface object ID.
            const QuantLib::Time& OptionTime                                    //!< Smile's expiry as date.
        );
    };
}

