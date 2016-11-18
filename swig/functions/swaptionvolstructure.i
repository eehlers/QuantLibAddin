
%group(Swaption Volatility Term Structures);

%insert(obj_hpp) %{
#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/obj_volatilities.hpp>
#include <qlo/objects/obj_smilesection.hpp>

namespace QuantLib {
    class Calendar;
    class SwaptionVolatilityCube;
    class SwaptionVolatilityStructure;
    class SwapIndex;
    class Matrix;
    class Period;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_optimization.hpp>
#include <qlo/objects/obj_indexes.hpp>

#include <ql/termstructures/volatility/swaption/swaptionconstantvol.hpp>
#include <ql/termstructures/volatility/swaption/swaptionvolcube2.hpp>
#include <ql/termstructures/volatility/swaption/swaptionvolcube1.hpp>
#include <ql/termstructures/volatility/swaption/swaptionvolmatrix.hpp>
#include <ql/termstructures/volatility/swaption/spreadedswaptionvol.hpp>
#include <ql/math/optimization/endcriteria.hpp>
#include <ql/time/calendars/nullcalendar.hpp>
%}

namespace QuantLib {

    //%noctor(SwaptionVolatilityStructure);
    class SwaptionVolatilityStructure : public VolatilityTermStructure {
      public:

        //! Returns volatility from the given SwaptionVolatilityStructure object.
        %loop(volatility, Strike);
        %rename2(volatility, SwaptionVTSVolatility);
        Volatility volatility(
            const Date& OptionDate,         //!< Swaption expiry date.
            const Period& SwapTenor,        //!< Underlying swap length as period (e.g. 5Y).
            Rate Strike,                    //!< Swaption strike.
            bool AllowExtrapolation = false //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

// FIXME this overload does not get generated.
//        //! Returns volatility from the given SwaptionVolatilityStructure object.
//        %loop(volatility, Strike);
//        %rename2(volatility, SwaptionVTSVolatility2);
//        Volatility volatility(
//            const Period& OptionTenor,      //!< Swaption option tenor.
//            const Period& SwapTenor,        //!< Underlying swap length as period (e.g. 5Y).
//            Rate Strike,                    //!< Swaption strike.
//            bool AllowExtrapolation = false //!< Extrapolation Flag (TRUE allows extrapolation).
//        ) const;

        //! Returns variance from the given SwaptionVolatilityStructure object.
        %loop(blackVariance, OptionDate);
        %rename2(blackVariance, SwaptionVTSBlackVariance);
        Real blackVariance(
            const Date& OptionDate,         //!< Swaption expiry date.
            const Period& SwapTenor,        //!< Underlying swap length as period (e.g. 5Y).
            Rate Strike,                    //!< Swaption strike.
            bool AllowExtrapolation = false //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

// FIXME this overload does not get generated.
//        //! Returns variance from the given SwaptionVolatilityStructure object.
//        %loop(blackVariance, OptionTenor);
//        %rename2(blackVariance, SwaptionVTSBlackVariance2);
//        Real blackVariance(
//            const Period& OptionTenor,      //!< Swaption option tenor.
//            const Period& SwapTenor,        //!< Underlying swap length as period (e.g. 5Y).
//            Rate Strike,                    //!< Swaption strike.
//            bool AllowExtrapolation = false //!< Extrapolation Flag (TRUE allows extrapolation).
//        ) const;

        //! Returns the max swap tenor (i.e. length) for which the given SwaptionVolatilityStructure object can return vols.
        %rename2(maxSwapTenor, SwaptionVTSMaxSwapTenor);
        virtual const Period& maxSwapTenor() const /*= 0*/;

        //! Returns the business day convention used for option date calculation by the given SwaptionVolatilityStructure object.
        %rename2(businessDayConvention, SwaptionVTSBusinessDayConvention);
        virtual BusinessDayConvention businessDayConvention() const;

        //! Returns the option date corresponding to a given option tenor, taking calendar and business day convention into account, for the given SwaptionVolatilityStructure object.
        %loop(optionDateFromTenor, OptionTenor);
        %rename2(optionDateFromTenor, SwaptionVTSOptionDateFromTenor);
        Date optionDateFromTenor(
            const Period& OptionTenor       //!< Swaption option tenor.
        ) const;

        //! Returns the swap length corresponding to a given swap tenor for the given SwaptionVolatilityStructure object.
        %loop(swapLength, SwapTenor);
        %rename2(swapLength, SwaptionVTSSwapLength);
        Time swapLength(
            const Period& SwapTenor         //!< Swap tenor.
        ) const;

// FIXME this overload does not get generated.
//        //! Returns the swap length corresponding to a given swap tenor for the given SwaptionVolatilityStructure object.
//        %rename2(swapLength, SwaptionVTSSwapLength2);
//        Time swapLength(
//            const Date& SwapStart,  //!< Swap start date.
//            const Date& SwapEnd     //!< Swap end date.
//        ) const;
    };

    class ConstantSwaptionVolatility : public SwaptionVolatilityStructure {
      public:
        ConstantSwaptionVolatility(
            Natural NDays,                                              //!< Number of days to advance from EvaluationDate: it fixes the date at which the variance = 0.0.
            const Calendar& Calendar,                                   //!< Holiday calendar (e.g. TARGET) used for calculating the exercise dates from the expiries.
            BusinessDayConvention BusinessDayConvention,                //!< Business day convention used for calculating the exercise dates from the expiries.
            const Handle<Quote>& Volatility,                            //!< Cap/floor constant volatility Quote.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed()     //!< DayCounter ID.
            //,const VolatilityType type = ShiftedLognormal,
            //const Real shift = 0.0
        );
    };

    class SpreadedSwaptionVolatility : public SwaptionVolatilityStructure {
      public:
        SpreadedSwaptionVolatility(
            const Handle<SwaptionVolatilityStructure>& BaseVolStructure,//!< Base SwaptionVolatilityStructure object ID.
            const Handle<Quote>& Spread                                 //!< Spread.
        );
    };

    class SwaptionVolatilityDiscrete : /*public LazyObject,*/ public SwaptionVolatilityStructure {
      public:

        //! Returns the vector of swaption exercise dates for the given SwaptionVolatilityDiscrete object.
        %rename2(optionDates, SwaptionVTSMatrixOptionDates);
        const std::vector<Date>& optionDates() const;

        //! Returns the vector of swaption exercise tenors for the given SwaptionVolatilityDiscrete object.
        %rename2(optionTenors, SwaptionVTSMatrixOptionTenors);
        const std::vector<Period>& optionTenors() const;

        //! Returns the vector of underlying swap tenors for the given SwaptionVolatilityDiscrete object.
        %rename2(swapTenors, SwaptionVTSMatrixSwapTenors);
        const std::vector<Period>& swapTenors() const;
    };

    class SwaptionVolatilityMatrix : public SwaptionVolatilityDiscrete/*,
                                     private boost::noncopyable*/ {
      public:

        SwaptionVolatilityMatrix(
            const Calendar& Calendar,                                       //!< Holiday calendar (e.g. TARGET) used for calculating the exercise dates from the expiries.
            BusinessDayConvention BusinessDayConvention,                    //!< Business day convention used for calculating the exercise dates from the expiries.
            const std::vector<Period>& OptionTenors,                        //!< Swaption expiries as periods.
            const std::vector<Period>& SwapTenors,                          //!< Underlying swap lengths.
            const std::vector<std::vector<Handle<Quote> > >& Volatilities,  //!< Vol quotes.
            const DayCounter& DayCounter                                    //!< DayCounter ID.
            //,const bool flatExtrapolation = false,
            //const VolatilityType type = ShiftedLognormal,
            //const std::vector<std::vector<Real> >& shifts
            //    = std::vector<std::vector<Real> >()
        );
%insert(rp_class) %{
        std::vector<long> locate(const QuantLib::Date& d,
                                 const QuantLib::Period& p);
%}
    };

    class SwaptionVolatilityCube : public SwaptionVolatilityDiscrete {
      public:

        //! Returns the at-the-money swaption strike, for a given exercise date and underlying swap length, for the given SwaptionVolatilityCube object.
        %loop(atmStrike, OptionDate);
        %rename2(atmStrike, SwaptionVTSatmStrike);
        Rate atmStrike(
            const Date& OptionDate,                                         //!< Swaption expiry date.
            const Period& SwapTenor                                         //!< Underlying swap length as period (e.g. 5Y).
        ) const;

        //! Returns the at-the-money swaption strike, for a given exercise date and underlying swap length, for the given SwaptionVolatilityCube object.
        %loop(atmStrike, OptionTenor);
        %rename2(atmStrike, SwaptionVTSatmStrike2);
        Rate atmStrike(
            const Period& OptionTenor,                                      //!< Swaption's option tenor.
            const Period& SwapTenor                                         //!< Underlying swap length as period (e.g. 5Y).
        );
    };

    class SwaptionVolCube2 : public SwaptionVolatilityCube {
      public:
        SwaptionVolCube2(
            const Handle<SwaptionVolatilityStructure>& AtmVolStructure,     //!< At-the-money volatility structure.
            const std::vector<Period>& OptionTenor,                         //!< Smile cube's expiries as periods.
            const std::vector<Period>& SwapTenor,                           //!< Smile cube's underlying swap lengths.
            const std::vector<Spread>& StrikeSpreads,                       //!< Smile cube's strike spreads over the ATM strike rate.
            const std::vector<std::vector<Handle<Quote> > >& SpreadVols,    //!< Matrix of spread vol quotes.
            const boost::shared_ptr<SwapIndex>& SwapIndexBase,              //!< Base SwapIndex object ID.
            const boost::shared_ptr<SwapIndex>& ShortSwapIndexBase,         //!< Short base SwapIndex object ID.
            bool VegaWeightedSmileFit                                       //!< If TRUE the smile fit is weighted using options' vega.
        );
    };

    class SwaptionVolCube1 : public SwaptionVolatilityCube {
      public:

        %override2(SwaptionVolCube1);
        SwaptionVolCube1(
            const Handle<SwaptionVolatilityStructure>& AtmVolStructure,     //!< At-the-money volatility structure.
            const std::vector<Period>& OptionTenor,                         //!< Smile cube's expiries as periods.
            const std::vector<Period>& SwapTenor,                           //!< Smile cube's underlying swap lengths.
            const std::vector<Spread>& StrikeSpreads,                       //!< Smile cube's strike spreads over the ATM strike rate.
            const std::vector<std::vector<Handle<Quote> > >& SpreadVols,    //!< Matrix of spread vol quotes.
            const boost::shared_ptr<SwapIndex>& SwapIndexBase,              //!< Base SwapIndex object ID.
            const boost::shared_ptr<SwapIndex>& ShortSwapIndexBase,         //!< Short base SwapIndex object ID.
            bool VegaWeightedSmileFit,                                      //!< If TRUE the smile fit is weighted using options' vega.
            const std::vector<std::vector<Handle<Quote> > >& Guess,         //!< Matrix of parameters guess quotes.
            const std::vector<bool>& IsFixed,                               //!< If TRUE parameter guess is not calibrated.
            bool IsAtmCalibrated,                                           //!< If TRUE the cube is calibrated to atm matrix.
            const boost::shared_ptr<EndCriteria>& EndCriteria = boost::shared_ptr<EndCriteria>(),//!< EndCriteria object ID.
            Real MaxErrorTol = Null<Real>(),                                //!< Max error tolerance.
            const boost::shared_ptr<OptimizationMethod>& OptMethod = boost::shared_ptr<OptimizationMethod>()    //!< Optmization method object ID.
        );

%insert(rp_class) %{
        std::vector<std::vector<reposit::property_t> > getSparseSabrParameters();
        std::vector<std::vector<reposit::property_t> > getDenseSabrParameters();
        std::vector<std::vector<reposit::property_t> > getMarketVolCube();
        std::vector<std::vector<reposit::property_t> > getVolCubeAtmCalibrated();
%}
    };
}

namespace QuantLibAddin {
        
    %noctor(SwaptionVolatilityMatrix);
    %noexport(SwaptionVolatilityMatrix);
    class SwaptionVolatilityMatrix /*: public SwaptionVolatilityDiscrete*/ {
      public:

        //! Returns the vector of underlying swap tenors for the given SwaptionVolatilityDiscrete object.
        %rename2(locate, SwaptionVTSMatrixLocate);
        std::vector<long> locate(
            const QuantLib::Date& OptionDate,       //!< Swaption expiry date.
            const QuantLib::Period& SwapTenor       //!< Underlying swap length as period (e.g. 5Y).
        );
    };
    
    %noctor(SwaptionVolCube1);
    %noexport(SwaptionVolCube1);
    class SwaptionVolCube1 /*: public SwaptionVolatilityCube*/ {
      public:

        //! Returns results of Sabr calibration for the given SwaptionVolCube1 object.
        %rename2(getSparseSabrParameters, SparseSabrParameters);
        std::vector<std::vector<reposit::property_t> > getSparseSabrParameters();

        //! Returns results of Sabr calibration for the given SwaptionVolCube1 object.
        %rename2(getDenseSabrParameters, DenseSabrParameters);
        std::vector<std::vector<reposit::property_t> > getDenseSabrParameters();

        //! Returns the market volatility cube for the given SwaptionVolCube1 object.
        %rename2(getMarketVolCube, MarketVolCube);
        std::vector<std::vector<reposit::property_t> > getMarketVolCube();

        //! Returns the volatility cube calibrated to ATM matrix for the given SwaptionVolCube1 object.
        %rename2(VolCubeAtmCalibrated, getVolCubeAtmCalibrated);
        std::vector<std::vector<reposit::property_t> > getVolCubeAtmCalibrated();
    };

    class SmileSectionByCube : public SmileSection {
      public:

        %override2(SmileSectionByCube);
        SmileSectionByCube(
            const boost::shared_ptr<QuantLib::SwaptionVolatilityCube>& VolCube, //!< Swaption volatility cube object ID.
            const QuantLib::Period& OptionTenor,                                //!< Smile's expiry as period.
            const QuantLib::Period& SwapTenor                                   //!< Smile's underlying swap length.
        );

        %override2(SmileSectionByCube);
        %rename(SmileSectionByCube2) SmileSectionByCube;
        SmileSectionByCube(
            const boost::shared_ptr<QuantLib::SwaptionVolatilityCube>& VolCube, //!< Swaption volatility cube object ID.
            const QuantLib::Date& OptionDate,                                   //!< Smile's expiry as date.
            const QuantLib::Period& SwapTenor                                   //!< Smile's underlying swap length.
        );
    };
}

