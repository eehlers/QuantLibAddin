
%group(volatilities);
%groupCaption(Volatilities);

%insert(volatilities_library_hpp) %{
#include <qlo/objects/obj_termstructures.hpp>
#include <ql/time/businessdayconvention.hpp>
#include <ql/types.hpp>

namespace QuantLib {
    class BlackAtmVolCurve;
    class BlackVolTermStructure;
    class Calendar;
    class Date;
    class DayCounter;
    class InterestRateIndex;
    class Matrix;
    class Period;
    class SabrVolSurface;
}
%}

%insert(volatilities_addin_cpp) %{
#include <qlo/objects/obj_indexes.hpp>
#include <ql/experimental/volatility/blackatmvolcurve.hpp>
#include <ql/experimental/volatility/abcdatmvolcurve.hpp>
#include <ql/experimental/volatility/sabrvolsurface.hpp>
#include <ql/termstructures/volatility/equityfx/blackvoltermstructure.hpp>
#include <ql/termstructures/volatility/equityfx/blackconstantvol.hpp>
#include <ql/termstructures/volatility/equityfx/blackvariancesurface.hpp>
%}

namespace QuantLib {

    %noctor(BlackVolTermStructure);
    class BlackVolTermStructure : public VolatilityTermStructure {
      public:

        //! Returns the black spot volatility at a given option date and strike.
        Volatility blackVol(
            const Date& OptionDate,             //!< The date at which the volatility is evaluated.
            Real Strike,                        //!< The strike at which the volatility is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the black spot variance at a given option date and strike.
        Real blackVariance(
            const Date& OptionDate,             //!< The date at which the variance is evaluated.
            Real Strike,                        //!< The strike at which the variance is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the black forward (at-the-money) volatility at a given option date and strike.
        Volatility blackForwardVol(
            const Date& ForwardDate,            //!< The forward date at which the volatility is evaluated.
            const Date& OptionDate,             //!< The option date at which the volatility is evaluated.
            Real Strike,                        //!< The strike at which the volatility is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the black forward (at-the-money) variance at a given option date and strike.
        Real blackForwardVariance(
            const Date& ForwardDate,            //!< The forward date at which the volatility is evaluated.
            const Date& OptionDate,             //!< The date at which the variance is evaluated.
            Real Strike,                        //!< The strike at which the variance is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;
    };

    class BlackConstantVol : public BlackVolTermStructure {
      public:

        BlackConstantVol(
            const QuantLib::Date& SettlementDate,                                     //!< Settlement date.
            const QuantLib::Calendar& Calendar,                                       //!< Holiday calendar (e.g. TARGET).
            QuantLib::Volatility Volatility,                                          //!< Volatility.
            const QuantLib::DayCounter& DayCounter=QuantLib::Actual365Fixed()         //!< DayCounter ID.
        );
    };

    class BlackVarianceSurface : public BlackVolTermStructure {
      public:

        BlackVarianceSurface(
            const QuantLib::Date& SettlementDate,                                     //!< Settlement date.
            const QuantLib::Calendar& Calendar,                                       //!< Holiday calendar (e.g. TARGET).
            const std::vector<QuantLib::Date>& Dates,                                 //!< Dates.
            const std::vector<QuantLib::Rate>& Strikes,                               //!< Strikes.
            const QuantLib::Matrix& Volatilities,                                     //!< Volatilities.
            const QuantLib::DayCounter& DayCounter=QuantLib::Actual365Fixed()         //!< DayCounter ID.
        );
    };

    %noctor(BlackAtmVolCurve);
    class BlackAtmVolCurve : public VolatilityTermStructure {
      public:

        //! Returns the spot at-the-money (no-smile) volatility at a given option date.
        Volatility atmVol(
            const Date& OptionDate,             //!< The date at which the volatility is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the spot at-the-money (no-smile) volatility at a given option tenor.
        %rename(atmVol2) atmVol;
        Volatility atmVol(
            const Period& OptionTenor,          //!< The time at which the volatility is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the spot at-the-money (no-smile) volatility at a given option time.
        %rename(atmVol3) atmVol;
        Volatility atmVol(
            Time OptionTime,                    //!< The time at which the volatility is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the spot at-the-money (no-smile) variance at a given option date.
        Real atmVariance(
            const Date& OptionDate,             //!< The date at which the volatility is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the spot at-the-money (no-smile) variance at a given option tenor.
        %rename(atmVariance2) atmVariance;
        Real atmVariance(
            const Period& OptionTenor,          //!< The tenor at which the volatility is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the spot at-the-money (no-smile) variance at a given option time.
        %rename(atmVariance3) atmVariance;
        Real atmVariance(
            Time OptionTime,                    //!< The time at which the volatility is evaluated.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;
    };

    class AbcdAtmVolCurve: public BlackAtmVolCurve {
    public:

        AbcdAtmVolCurve(
            QuantLib::Natural SettlementDays,                                         //!< Settlement days.
            const QuantLib::Calendar& Calendar,                                       //!< Holiday calendar (e.g. TARGET).
            const std::vector<QuantLib::Period>& OptionTenors,                        //!< Options tenors.
            const std::vector<QuantLib::Handle<Quote> > & VolatilitiesQuotes,         //!< Volatilities quotes.
            const std::vector<bool> InclusionInInterpolation,               //!< Inclusion flags. If omitted, all volatilities are interpolated.
            QuantLib::BusinessDayConvention Convention,                               //!< Business day convention (e.g. Following).
            const QuantLib::DayCounter& DayCounter=QuantLib::Actual365Fixed()         //!< DayCounter ID.
        );

        //! Returns the options tenors of the atm volatility curve.
        const std::vector<Period>& optionTenors() const;

        //! Returns the options tenors used in the fitting of the atm volatility curve.
        const std::vector<Period>& optionTenorsInInterpolation() const;

        //! Returns the options dates of the atm volatility curve.
        const std::vector<Date>& optionDates() const;

        //! Returns the options times to maturity of the atm volatility curve.
        const std::vector<Time>& optionTimes() const;

        //! Returns the root mean squared error between the abcd implied Black vols and the given Black vols vector.
        Real rmsError() const;

        //! Returns the max error between the abcd implied Black vols and the given Black vols vector.
        Real maxError() const;

        //! Returns the a coefficient in the abcd vol parametrization.
        Real a() const;

        //! Returns the b coefficient in the abcd vol parametrization.
        Real b() const;

        //! Returns the c coefficient in the abcd vol parametrization.
        Real c() const;

        //! Returns the d coefficient in the abcd vol parametrization.
        Real d() const;

        //! Returns the k adjustments factors needed to match the input Black vols.
        std::vector<Real> k() const;

        //! Returns the k adjustments factors needed to match the input Black vols at a given time.
        Real k(
            Time Time   //!< Time.
        ) const;
    };

    class SabrVolSurface : public InterestRateVolSurface {
      public:

        SabrVolSurface(
            const boost::shared_ptr<QuantLib::InterestRateIndex>& InterestRateIndex,//!< Interest rate index object ID.
            const QuantLib::Handle<QuantLib::BlackAtmVolCurve>& BlackAtmVolCurve,   //!< The atm volatility curve.
            const std::vector<QuantLib::Period>& OptionTenors,                      //!< Options tenors.
            const std::vector<QuantLib::Spread>& AtmRateSpreads,                    //!< Spreads.
            const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& VolatilitiesQuotes //!< Volatilities quotes.
        );

        //! Returns the volatilities spread at a given date.
        std::vector<Volatility> volatilitySpreads(
            const Date &OptionDate                                                  //!< The date at which the volatility is evaluated.
        ) const;

        //! Returns the volatilities spread at a given date.
        %rename(volatilitySpreads2) volatilitySpreads;
        std::vector<Volatility> volatilitySpreads(
            const Period &OptionTenor                                               //!< The tenor at which the volatility is evaluated.
        ) const;
%insert(rp_class) %{
        std::string atmCurve();
%}
    };

    class VolatilityTermStructure : public TermStructure {
      public:

        //! Returns the business day convention used in tenor to date conversion.
        virtual BusinessDayConvention businessDayConvention() const;

        //! Returns the option date corrisponding to a given option tenor.
        Date optionDateFromTenor(
            const Period &Tenor     //!< Option tenor.
        ) const;

        //! Returns the minimum strike for which the given VolatilityTermStructure can return vols.
        virtual Rate minStrike() const = 0;

        //! Returns the maximum strike for which the given VolatilityTermStructure can return vols.
        virtual Rate maxStrike() const = 0;
    };

    //! Sabr formula for smile volatility.
    Real sabrVolatility(
        Rate Strike,    //!< Option strike.
        Rate Forward,   //!< Underlying forward value.
        Time ExpTime,   //!< Expiry time (in years).
        Real Alpha,     //!< Alpha.
        Real Beta,      //!< Beta.
        Real Nu,        //!< Nu.
        Real Rho        //!< Rho.
    );
}

namespace QuantLibAddin {

    %noexport(SabrVolSurface);
    %noctor(SabrVolSurface);
    class SabrVolSurface : public InterestRateVolSurface {
      public:

        //! Returns the Atm volatility curve.
        const QuantLib::Handle<QuantLib::BlackAtmVolCurve>& atmCurve() const;
    };
}

