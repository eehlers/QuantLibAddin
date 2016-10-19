
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

    class Extrapolator {
      public:
        //! Sets the enable extrapolation flag to the given Extrapolator object.
        void enableExtrapolation(
            bool b      //!< global extrapolation flag.
        );
    };

    class TermStructure : public Extrapolator {
      public:
        %generate(c++, referenceDate);
        %generate(countify, referenceDate);
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
        %loop(timeFromReference, Date);
        //! Returns the time from the reference date for the given TermStructure object.
        Time timeFromReference(
            const Date& Date                                            //!< vector of dates.
        ) const;
        
    };

    class YieldTermStructure : public TermStructure {
      public:
        %generate(c++, discount);
        %generate(countify, discount);
        // For purposes of backward compatibility we use the %alias directive to export this function twice,
        // once under its old name (qlYieldTSDiscount) and once under its new name (qlYieldTermStructureDiscount)
        %alias(discount, YieldTSDiscount);
        //! Returns a discount factor from the given YieldTermStructure object.
        DiscountFactor discount(
            const Date& d,      //!< vector of dates.
            bool extrapolate    //!< TRUE allows extrapolation.
        );
        %alias(forwardRate, YieldTSForwardRate);
        %loop(forwardRate, d2);
        //! Returns the forward interest rate from the given YieldTermStructure object.
        InterestRate forwardRate(const Date& d1,                        //!< first date.
                                 const Date& d2,                        //!< second date.
                                 const DayCounter& resultDayCounter,    //!< result DayCounter.
                                 Compounding comp,                      //!< Interest rate compounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
                                 Frequency freq = Annual,               //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
                                 bool extrapolate = false               //!< TRUE allows extrapolation.
        ) const;
        
        %alias(forwardRate, YieldTSForwardRate2);
        %loop(forwardRate, d);
        InterestRate forwardRate(const Date& d,                         //!< first date.
                                 const Period& p,                       //!< Period (e.g. '7D', '3M', '1Y', etc).
                                 const DayCounter& resultDayCounter,    //!< result DayCounter.
                                 Compounding comp,                      //!< Interest rate compounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
                                 Frequency freq = Annual,               //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
                                 bool extrapolate = false               //!< TRUE allows extrapolation.
        ) const;
        
        %alias(zeroRate, YieldTSZeroRate);
        %loop(zeroRate, d);
        //! Returns the zero interest rate from the given YieldTermStructure object.
        InterestRate zeroRate(const Date& d,                            //!< date.
                              const DayCounter& resultDayCounter,       //!< resultDayCounter.
                              Compounding comp,                         //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
                              Frequency freq = Annual,                  //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
                              bool extrapolate = false                  //!< TRUE allows extrapolation.
        ) const;
    };

    class DiscountCurve : public YieldTermStructure {
      public:
        DiscountCurve(
            const std::vector<Date>& dates,                             //!< dates of the curve.
            const std::vector<DiscountFactor>& dfs,                     //!< discount factors for the above dates.
            const DayCounter& dayCounter = Actual365Fixed               //!< DayCounter ID.
        );
    };

    class ZeroCurve : public YieldTermStructure {
      public:
        ZeroCurve(
            const std::vector<Date>& dates,                             //!< dates of the curve.
            const std::vector<Rate>& zeroRates,                         //!< zero rates for the above dates.
            const DayCounter& dayCounter = Actual365Fixed               //!< DayCounter ID.
        );
    };

    class ForwardCurve : public YieldTermStructure {
      public:
        ForwardCurve(
            const std::vector<Date>& dates,                             //!< dates of the curve.
            const std::vector<Rate>& forwardRates,                      //!< forwards rates for the above dates.
            const DayCounter& dayCounter = Actual365Fixed               //!< DayCounter ID.
        );
    };

    class FlatForward : public YieldTermStructure {
      public:
        FlatForward(
            Natural nDays,                                              //!< number of days to advance from EvaluationDate (usually zero or two): it fixes the date at which the discount factor = 1.0.
            const Calendar& calendar,                                   //!< holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const Handle<Quote>& forward,                               //!< the curve level.
            const DayCounter& dayCounter = Actual365Fixed,              //!< DayCounter ID.
            Compounding compounding = Continuous,                       //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency = Annual                                //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
        );
    };

    class ForwardSpreadedTermStructure : public YieldTermStructure {
      public:
        ForwardSpreadedTermStructure(
            const Handle<YieldTermStructure>& hYTS,                     //!< Base YieldTermStructure object ID.
            const Handle<Quote>& spread                                 //!< spread.
        );
    };

    class ImpliedTermStructure : public YieldTermStructure {
      public:
        ImpliedTermStructure(
            const Handle<YieldTermStructure>& hYTS,                     //!< Base YieldTermStructure object ID.
            const Date& referenceDate                                   //!< the reference date the base YieldTermStructure should be shifted to.
        );
    };
}

namespace QuantLibAddin {

    class InterpolatedYieldCurve : public YieldTermStructure {
      public:
        InterpolatedYieldCurve(
            const std::vector<QuantLib::Date>& dates,                   //!< vector of dates, the first one being the one at which discount factor = 1.0
            const std::vector<QuantLib::Real>& data,                    //!< data vector. Each element should be of the type selected by TraitsID
            const QuantLib::Calendar& calendar,                         //!< holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const QuantLib::DayCounter& dayCounter/* = Actual365Fixed*/,//!< DayCounter ID.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& jumps,//!< Jump quotes vector.
            const std::vector<QuantLib::Date>& jumpDates,               //!< Jump dates vector.
            const std::string& traitsID = "Discount",                   //!< Discount, ZeroYield, or ForwardRate.
            const std::string& interpolatorID = "MonotonicLogCubicNaturalSpline",//!< BackwardFlat, ForwardFlat, Linear, LogLinear, LogParabolic, KrugerLogCubic, etc.
            const QuantLib::MixedInterpolation::Behavior behavior = QuantLib::ShareRanges,  //!< ShareRanges to join two different interpolations over all the pillars, SplitRanges otherwise.
            const QuantLib::Size n = 1                                  //!< Number of pillar from which change the interpolation ID.
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
