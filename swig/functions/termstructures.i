
%group(termstructures);
%groupCaption(Term Structures);
// FIXME the only class that requires a manual override is InterpolatedYieldCurve.
// So move that into a different file and generate the rest of this file automatically.
%override;

%insert(termstructures_library_hpp) %{
#include <ql/termstructures/yield/flatforward.hpp>
#include <ql/termstructures/yield/discountcurve.hpp>
#include <ql/termstructures/yield/zerocurve.hpp>
#include <ql/termstructures/yield/forwardspreadedtermstructure.hpp>
#include <ql/termstructures/yield/impliedtermstructure.hpp>
#include <ql/termstructures/yield/forwardcurve.hpp>
#include <ql/termstructures/interpolatedcurve.hpp>
%}

%insert(termstructures_addin_cpp) %{
#include <qlo/objects/objmanual_handles.hpp>
%}

namespace QuantLib {

    // FIXME move this into interpolation.i
    class Extrapolator {
      public:

        //! Sets the enable extrapolation flag to the given Extrapolator object.
        void enableExtrapolation(
            bool ExtrapolationFlag=true                                         //!< global extrapolation flag.
        );
    };

    class TermStructure : public Extrapolator {
      public:

        //! Returns the reference date for the given TermStructure object.
        Date referenceDate();

        //! Returns the max date for the given TermStructure object.
        Date maxDate();

        //! Returns the calendar used by the given TermStructure object.
        Calendar calendar();

        //! Returns the DayCounter used by the given TermStructure object.
        DayCounter dayCounter();

        //! Returns the number of settlement days for the given TermStructure object.
        Natural settlementDays();

        //! Returns the time from the reference date for the given TermStructure object.
        %loop(timeFromReference, Date);
        Time timeFromReference(
            const Date& Date                                                    //!< vector of dates.
        ) const;
        
    };

    class YieldTermStructure : public TermStructure {
      public:

        //! Returns a discount factor from the given YieldTermStructure object.
        %alias(discount, YieldTSDiscount);
        %loop(discount, DfDates);
        DiscountFactor discount(
            const Date& DfDates,                                                //!< vector of dates.
            bool AllowExtrapolation=false                                       //!< TRUE allows extrapolation.
        ) const;

        //! Returns the forward interest rate from the given YieldTermStructure object.
        %alias(forwardRate, YieldTSForwardRate);
        %loop(forwardRate, D2);
        InterestRate forwardRate(
            const Date& D1,                                                     //!< first date.
            const Date& D2,                                                     //!< second date.
            const DayCounter& ResultDayCounter,                                 //!< result DayCounter.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Simple),    //!< Interest rate compounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency = QuantLib::Frequency(QuantLib::Annual),        //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            bool AllowExtrapolation = false                                     //!< TRUE allows extrapolation.
        ) const;
        
        // FIXME SWIG does not generate this overload.
        //! Returns the forward interest rate from the given YieldTermStructure object.
        //%alias(forwardRate, YieldTSForwardRate2);
        //%loop(forwardRate, Date);
        //InterestRate forwardRate(
        //    const Date& Date,                                                   //!< first date.
        //    const Period& Period,                                               //!< Period (e.g. '7D', '3M', '1Y', etc).
        //    const DayCounter& ResultDayCounter,                                 //!< result DayCounter.
        //    Compounding Compounding=QuantLib::Compounding(QuantLib::Simple),    //!< Interest rate compounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
        //    Frequency Frequency = QuantLib::Frequency(QuantLib::Annual),        //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
        //    bool AllowExtrapolation = false                                     //!< TRUE allows extrapolation.
        //) const;
        
        //! Returns the zero interest rate from the given YieldTermStructure object.
        %alias(zeroRate, YieldTSZeroRate);
        %loop(zeroRate, Dates);
        InterestRate zeroRate(
            const Date& Dates,                                                  //!< date.
            const DayCounter& ResultDayCounter,                                 //!< resultDayCounter.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Continuous),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency = QuantLib::Frequency(QuantLib::Annual),        //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            bool AllowExtrapolation = false                                     //!< TRUE allows extrapolation.
        ) const;
    };

    class DiscountCurve : public YieldTermStructure {
      public:
        DiscountCurve(
            const std::vector<Date>& CurveDates,                                //!< dates of the curve.
            const std::vector<DiscountFactor>& CurveDiscounts,                  //!< discount factors for the above dates.
            const DayCounter& DayCounter = QuantLib::Actual365Fixed()           //!< DayCounter ID.
        );
    };

    class ZeroCurve : public YieldTermStructure {
      public:
        ZeroCurve(
            const std::vector<Date>& CurveDates,                                //!< dates of the curve.
            const std::vector<Rate>& CurveYields,                               //!< zero rates for the above dates.
            const DayCounter& DayCounter = QuantLib::Actual365Fixed()           //!< DayCounter ID.
        );
    };

    class ForwardCurve : public YieldTermStructure {
      public:
        ForwardCurve(
            const std::vector<Date>& CurveDates,                                //!< dates of the curve.
            const std::vector<Rate>& ForwardYields,                             //!< forwards rates for the above dates.
            const DayCounter& DayCounter = QuantLib::Actual365Fixed()           //!< DayCounter ID.
        );
    };

    class FlatForward : public YieldTermStructure {
      public:
        FlatForward(
            Natural NDays/*=0*/,                                                //!< number of days to advance from EvaluationDate (usually zero or two): it fixes the date at which the discount factor = 1.0.
            const Calendar& Calendar/*=NullCalendar*/,                          //!< holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const Handle<Quote>& Rate,                                          //!< the curve level.
            const DayCounter& DayCounter = QuantLib::Actual365Fixed(),          //!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Continuous),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency = QuantLib::Frequency(QuantLib::Annual)         //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
        );
    };

    class ForwardSpreadedTermStructure : public YieldTermStructure {
      public:
        ForwardSpreadedTermStructure(
            const Handle<YieldTermStructure>& BaseYieldCurve,                   //!< Base YieldTermStructure object ID.
            const Handle<Quote>& Spread                                         //!< spread.
        );
    };

    class ImpliedTermStructure : public YieldTermStructure {
      public:
        ImpliedTermStructure(
            const Handle<YieldTermStructure>& BaseYieldCurve,                   //!< Base YieldTermStructure object ID.
            const Date& ReferenceDate                                           //!< the reference date the base YieldTermStructure should be shifted to.
        );
    };
}

namespace QuantLibAddin {

    class InterpolatedYieldCurve : public YieldTermStructure {
      public:
        InterpolatedYieldCurve(
            const std::vector<QuantLib::Date>& Dates,                           //!< vector of dates, the first one being the one at which discount factor = 1.0
            const std::vector<QuantLib::Real>& Data,                            //!< data vector. Each element should be of the type selected by TraitsID
            const QuantLib::Calendar& Calendar,                                 //!< holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const QuantLib::DayCounter& DayCounter/*=QuantLib::Actual365Fixed()*/,//!< DayCounter ID.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& Jumps,       //!< Jump quotes vector.
            const std::vector<QuantLib::Date>& JumpDates,                       //!< Jump dates vector.
            const std::string& TraitsID = "Discount",                   //!< Discount, ZeroYield, or ForwardRate.
            const std::string& InterpolatorID = "MonotonicLogCubicNaturalSpline",//!< BackwardFlat, ForwardFlat, Linear, LogLinear, LogParabolic, KrugerLogCubic, etc.
            const QuantLib::MixedInterpolation::Behavior MixedInterpolationBehavior = QuantLib::MixedInterpolation::Behavior(QuantLib::MixedInterpolation::ShareRanges),//!< ShareRanges to join two different interpolations over all the pillars, SplitRanges otherwise.
            const QuantLib::Size NRateHelper = 1                                //!< Number of pillar from which change the interpolation ID.
        );

        //! Retrieve list of Times for the given InterpolatedYieldCurve.
        const std::vector<QuantLib::Time>& times() const;

        //! Retrieve list of Dates for the given InterpolatedYieldCurve.
        const std::vector<QuantLib::Date>& dates() const;

        //! Retrieve Data for the given InterpolatedYieldCurve.
        const std::vector<QuantLib::Real>& data() const;

        //! Retrieve list of jump times for the given InterpolatedYieldCurve.
        const std::vector<QuantLib::Time>& jumpTimes() const;

        //! Retrieve list of jump dates for the given InterpolatedYieldCurve.
        const std::vector<QuantLib::Date>& jumpDates() const;
    };
}
