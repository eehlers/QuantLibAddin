
%group(Caplet Volatility Term Structures);

%insert(obj_hpp) %{

#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/handleimpl.hpp>

#include <ql/types.hpp>
#include <ql/time/businessdayconvention.hpp>
#include <ql/termstructures/volatility/volatilitytype.hpp>

namespace QuantLib {
    class Period;
    class SmileSection;
    class IborIndex;
    class Calendar;
    class DayCounter;
    class Quote;
    class Date;

    template <class T>
    class Handle;

    class CapFloorTermVolSurface;
    class CapFloorTermVolCurve;
    class OptionletStripper1;
    class OptionletStripper2;
    class StrippedOptionletAdapter;
    class StrippedOptionlet;
    class StrippedOptionletBase;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_indexes.hpp>
#include <qlo/objects/obj_volatilities.hpp>

#include <ql/termstructures/volatility/capfloor/capfloortermvolcurve.hpp>
#include <ql/termstructures/volatility/capfloor/capfloortermvolsurface.hpp>
#include <ql/termstructures/volatility/capfloor/capfloortermvolatilitystructure.hpp>
#include <ql/termstructures/volatility/optionlet/constantoptionletvol.hpp>
#include <ql/termstructures/volatility/optionlet/optionletstripper1.hpp>
#include <ql/termstructures/volatility/optionlet/optionletstripper2.hpp>
#include <ql/termstructures/volatility/optionlet/optionletvolatilitystructure.hpp>
#include <ql/termstructures/volatility/optionlet/spreadedoptionletvol.hpp>
#include <ql/termstructures/volatility/optionlet/strippedoptionlet.hpp>
#include <ql/termstructures/volatility/optionlet/strippedoptionletadapter.hpp>
%}

%insert(rp_namespace) %{
    class RelinkableHandleOptionletVolatilityStructure : public RelinkableHandleImpl<QuantLibAddin::OptionletVolatilityStructure, QuantLib::OptionletVolatilityStructure>{
    public:
        RelinkableHandleOptionletVolatilityStructure(const boost::shared_ptr<reposit::ValueObject> &properties,
            const std::string &linkTo,
            bool permanent) : RelinkableHandleImpl<QuantLibAddin::OptionletVolatilityStructure, QuantLib::OptionletVolatilityStructure>(properties, linkTo, permanent) {}
    };
%}

namespace QuantLib {

    %noctor(RelinkableHandleOptionletVolatilityStructure);
    class RelinkableHandleOptionletVolatilityStructure {
    public:
        // attach processor RelinkableHandleProcessor to ctor RelinkableHandleOptionletVolatilityStructure.
        %processor(RelinkableHandleOptionletVolatilityStructure, RelinkableHandleProcessor);
        // NB: The parameter below must be called "CurrentLink" because there
        // is code which updates a property with that name in the value object.
        RelinkableHandleOptionletVolatilityStructure(
            const std::string &CurrentLink  //!< OptionletVolatilityStructure object ID. If omitted, nothing is linked by the RelinkableHandle.
        ) {}
    };

    class OptionletVolatilityStructure : public VolatilityTermStructure {
      public:

        //! Returns volatility from the given OptionletVolatilityStructure object.
        %loop(volatility, Strike);
        %rename2(volatility, OptionletVTSVolatility);
        Volatility volatility(
            const Date& OptionDate,         //!< Caplet/floorlet expiry date.
            Rate Strike,                    //!< Caplet/floorlet strike.
            bool AllowExtrapolation = false //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns volatility from the given OptionletVolatilityStructure object.
        %loop(volatility, Strike);
        %rename2(volatility, OptionletVTSVolatility2);
        Volatility volatility(
            const Period& OptionTenor,      //!< Caplet/floorlet option tenor.
            Rate Strike,                    //!< Caplet/floorlet strike.
            bool AllowExtrapolation = false //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the black variance corresponding to a given strike for a given exercise date.
        %loop(blackVariance, OptionDate);
        %rename2(blackVariance, OptionletVTSBlackVariance);
        Real blackVariance(
            const Date& OptionDate,         //!< Cap/floor expiry date.
            Rate Strike,                    //!< Cap/floor strike.
            bool AllowExtrapolation = false //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;

        //! Returns the black variance corresponding to a given strike for a given exercise date.
        %loop(blackVariance, OptionTenor);
        %rename2(blackVariance, OptionletVTSBlackVariance2);
        Real blackVariance(
            const Period& OptionTenor,      //!< Cap/floor option tenor.
            Rate Strike,                    //!< Cap/floor strike.
            bool AllowExtrapolation = false //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;
    };

    class ConstantOptionletVolatility : public OptionletVolatilityStructure {
      public:

        ConstantOptionletVolatility(
            Natural NDays/*=0*/,                                    //!< Number of days to advance from EvaluationDate: it fixes the date at which the variance = 0.0.
            const Calendar &Calendar,                               //!< Holiday calendar (e.g. TARGET) used for calculating the exercise dates from the expiries.
            BusinessDayConvention BusinessDayConvention,            //!< Business day convention used for calculating the exercise dates from the expiries.
            const Handle< Quote > &Volatility,                      //!< Cap/floor constant volatility Quote.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),//!< DayCounter ID.
            VolatilityType VolatilityType = ShiftedLognormal,       //!< Volatility type: Normal or ShiftedLognormal.
            Real Displacement = 0.0                                 //!< Shift for the lognormal model.
        );
    };

    class SpreadedOptionletVolatility : public OptionletVolatilityStructure {
      public:

        SpreadedOptionletVolatility(
            const Handle<OptionletVolatilityStructure> &BaseVolStructure,   //!< Base OptionletVolatilityStructure object ID.
            const Handle<Quote>& Spread                                     //!< Spread.
        );
    };
    class StrippedOptionletAdapter : public OptionletVolatilityStructure/*, public LazyObject*/ {
      public:
        StrippedOptionletAdapter(
            const boost::shared_ptr<StrippedOptionletBase> &StrippedOptionletBase   //!< Stripped Optionlet object id.
        );
    };

    class StrippedOptionletBase /*: public LazyObject*/ {
      public:

        //! Returns optionlet strike from the given StrippedOptionletBase object.
        %rename2(optionletStrikes, StrippedOptionletBaseStrikes);
        virtual const std::vector<Rate>& optionletStrikes(
            Size Index      //!< Optionlet index.
        ) const;

        //! Returns optionlet volatilities from the given StrippedOptionletBase object.
        virtual const std::vector<Volatility>& optionletVolatilities(
            Size Index      //!< Optionlet index.
        ) const;

        //! Returns optionlet fixing dates from the given StrippedOptionletBase object.
        virtual const std::vector<Date>& optionletFixingDates() const;

        //! Returns optionlet fixing times from the given StrippedOptionletBase object.
        virtual const std::vector<Time>& optionletFixingTimes() const;

        //! Returns atm optionlet rates from the given StrippedOptionletBase object.
        virtual const std::vector<Rate>& atmOptionletRates() const;

        //! Returns the DayCounter used by the given StrippedOptionletBase object.
        virtual DayCounter dayCounter() const;

        //! Returns the calendar used by the given StrippedOptionletBase object.
        virtual Calendar calendar() const;

        //! Returns the number of settlement days for the given StrippedOptionletBase object.
        virtual Natural settlementDays() const;

        //! Returns the business day convention used in tenor to date conversion.
        virtual BusinessDayConvention businessDayConvention() const;
    };

    class StrippedOptionlet : public StrippedOptionletBase {
      public:

        StrippedOptionlet(
            Natural SettlementDays/*=0*/,                               //!< Number of settlement days.
            const Calendar& Calendar,                                   //!< Holiday calendar (e.g. TARGET) used for calculating the exercise dates from the expiries.
            BusinessDayConvention BusinessDayConvention,                //!< Business day convention used for calculating the exercise dates from the expiries.
            const boost::shared_ptr< IborIndex > &IborIndex,            //!< IborIndex object ID.
            const std::vector< Date > &OptionletDates,                  //!< Optionlet dates.
            const std::vector< Rate > &Strikes,                         //!< Strikes.
            const std::vector< std::vector< Handle< Quote > > > &Volatilities,//!< Vol quotes.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),    //!< DayCounter ID.
            VolatilityType VolatilityType = ShiftedLognormal,           //!< Volatility type: Normal or ShiftedLognormal.
            Real Displacement = 0.0                                     //!< Shift for the lognormal model.
        );
    };

    class OptionletStripper : public StrippedOptionletBase {
      public:

        //! Returns optionlet fixing tenors from the given OptionletStripper object.
        const std::vector<Period>& optionletFixingTenors() const;

        //! Returns optionlet payment dates from the given OptionletStripper object.
        const std::vector<Date>& optionletPaymentDates() const;

        //! Returns optionlet accrual periods from the given OptionletStripper object.
        const std::vector<Time>& optionletAccrualPeriods() const;
    };

    class OptionletStripper1 : public OptionletStripper {
      public:

        %noimpl(OptionletStripper1);
        OptionletStripper1(
            const boost::shared_ptr< CapFloorTermVolSurface > &TermVolSurface,  //!< CapFloorTermVolSurface object ID.
            const boost::shared_ptr< IborIndex > &IborIndex,                    //!< Cap index object ID.
            Rate SwitchStrike = Null< Rate >(),                                 //!< Switch strike.
            Real Accuracy = 1.0e-6,                                             //!< Solver accuracy.
            Natural MaxIter = 100,                                              //!< Solver max iterations.
            const VolatilityType VolatilityType = ShiftedLognormal,             //!< Volatility type: Normal or ShiftedLognormal.
            const Real Displacement = 0.0                                       //!< Shift for the lognormal model.
        );

        //! Returns option prices matrix from the given OptionletStripper1 object.
        const Matrix& capFloorPrices() const;

        //! Returns option volatilities matrix from the given OptionletStripper1 object.
        const Matrix& capFloorVolatilities() const;

        //! Returns optionlet prices matrix from the given OptionletStripper1 object.
        const Matrix& optionletPrices() const;

        //! Returns option switch strike from the given OptionletStripper1 object.
        Rate switchStrike() const;
    };

    class CapFloorTermVolatilityStructure : public VolatilityTermStructure {
      public:

        //! Returns volatility from the given CapFloorTermVolatilityStructure object.
        %loop(volatility, Strike);
        %rename2(volatility, CapFloorTermVTSVolatility);
        Volatility volatility(
            const Date& OptionDate,             //!< Caplet/floorlet expiry date.
            Rate Strike,                        //!< Caplet/floorlet strike.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;


        //! Returns volatility from the given OptionletVolatilityStructure object.
        %loop(volatility, Strike);
        %rename2(volatility, CapFloorTermVTSVolatility2);
        Volatility volatility(
            const Period& OptionTenor,          //!< Caplet/floorlet option tenor.
            Rate Strike,                        //!< Caplet/floorlet strike.
            bool AllowExtrapolation = false     //!< Extrapolation Flag (TRUE allows extrapolation).
        ) const;
    };

    class CapFloorTermVolCurve : /*public LazyObject,*/ public CapFloorTermVolatilityStructure/*, private boost::noncopyable*/ {
      public:

        //! Returns the option tenors from the given CapFloorTermVolCurve object.
        const std::vector<Period>& optionTenors() const;

        //! Returns the option dates from the given CapFloorTermVolCurve object.
        const std::vector<Date>& optionDates() const;

        CapFloorTermVolCurve(
            Natural SettlementDays,                                 //!< Number of settlement days.
            const Calendar &Calendar,                               //!< Holiday calendar (e.g. TARGET) used for calculating the exercise dates from the expiries.
            BusinessDayConvention BusinessDayConvention,            //!< Business day convention used for calculating the exercise dates from the expiries.
            const std::vector<Period>& OptionTenors,                //!< Option tenors.
            const std::vector<Handle<Quote> >& Volatilities,        //!< Vol quotes vector.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed() //!< DayCounter ID.
        );
    };

    class OptionletStripper2 : public OptionletStripper {
      public:

        OptionletStripper2(
            const boost::shared_ptr<OptionletStripper1>& OptionletStripper1,    //!< OptionletStripper1 object id.
            const Handle<CapFloorTermVolCurve>& TermVolCurve                    //!< CapFloorTermVolCurve object id.
        );

        //! Returns optionlet spread (with respect to ATM) vols from the given OptionletStripper2 object.
        std::vector<Volatility> spreadsVol() const;

        //! Returns ATM option prices from the given OptionletStripper2 object.
        std::vector<Real> atmCapFloorPrices() const;

        //! Returns option ATM strikes from the given OptionletStripper2 object.
        std::vector<Rate> atmCapFloorStrikes() const;
    };

    class CapFloorTermVolSurface : /*public LazyObject,*/ public CapFloorTermVolatilityStructure {
      public:

        CapFloorTermVolSurface(
            Natural SettlementDays,                                         //!< Number of settlement days.
            const Calendar &Calendar,                                       //!< Holiday calendar (e.g. TARGET) used for calculating the exercise dates from the expiries.
            BusinessDayConvention BusinessDayConvention,                    //!< Business day convention used for calculating the exercise dates from the expiries.
            const std::vector<Period>& OptionTenors,                        //!< Option tenors.
            const std::vector<Rate>& Strikes,                               //!< Strikes.
            const std::vector<std::vector<Handle<Quote> > >&Volatilities,   //!< Vol quotes matrix.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed()         //!< DayCounter ID.
        );

        //! Returns the option tenors from the given CapFloorTermVolSurface object.
        const std::vector<Period>& optionTenors() const;

        //! Returns the option dates from the given CapFloorTermVolSurface object.
        const std::vector<Date>& optionDates() const;

        //! Returns the option strikes from the given CapFloorTermVolSurface object.
        const std::vector<Rate>& strikes() const;
    };
}

