
%group(Piecewise Yield Curve);

%insert(obj_hpp) %{
#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/obj_ratehelpers.hpp>
%}

namespace QuantLibAddin {

    class PiecewiseYieldCurve : public YieldTermStructure {
      public:

        PiecewiseYieldCurve(
            QuantLib::Natural NDays/*=0*/,                                          //!< number of days to advance from EvaluationDate (usually zero or two): it fixes the date at which the discount factor = 1.0.
            const QuantLib::Calendar& Calendar,                                     //!< holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& RateHelpers,//!< vector of rate-helpers.
            const QuantLib::DayCounter& DayCounter=QuantLib::Actual365Fixed(),      //!< DayCounter ID.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& Jumps,           //!< Jump quotes vector.
            const std::vector<QuantLib::Date>& JumpDates,                           //!< Jump dates vector.
            QuantLib::Real Accuracy=1.0e-12,                                        //!< Bootstrapping accuracy.
            const std::string& TraitsID="Discount",                                 //!< Discount, ZeroRate, or ForwardRate.
            const std::string& InterpolatorID="LogLinear"                           //!< BackwardFlat, ForwardFlat, Linear, LogLinear, CubicSpline, or LogCubic.
        );

        %rename(PiecewiseYieldCurveMixedInterpolation) PiecewiseYieldCurve;
        PiecewiseYieldCurve(
            QuantLib::Natural NDays/*=0*/,                                          //!< number of days to advance from EvaluationDate (usually zero or two): it fixes the date at which the discount factor = 1.0.
            const QuantLib::Calendar& Calendar,                                     //!< holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& RateHelpers,//!< vector of rate-helpers.
            const QuantLib::DayCounter& DayCounter = QuantLib::Actual365Fixed(),    //!< DayCounter ID.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& Jumps,           //!< Jump quotes vector.
            const std::vector<QuantLib::Date>& JumpDates,                           //!< Jump dates vector.
            QuantLib::Real Accuracy/*=1.0e-12*/,                                    //!< Bootstrapping accuracy.
            const std::string& TraitsID/*="Discount"*/,                             //!< Discount, ZeroRate, or ForwardRate.
            const std::string& InterpolatorID/*="LogLinear"*/,                      //!< BackwardFlat, ForwardFlat, Linear, LogLinear, CubicSpline, or LogCubic.
            const QuantLib::MixedInterpolation::Behavior MixedInterpolationBehavior/*=ShareRanges*/,//!< ShareRanges to join two different interpolations over all the pillars, SplitRanges otherwise.
            const QuantLib::Size PillarsBeforeChange                                //!< Number of pillars before the interpolation change.
        );

        //! Retrieve list of Times for the given PiecewiseYieldCurve&lt;Traits, Interpolator&gt;.
        const std::vector<QuantLib::Time>& times() const;

        //! Retrieve Data for the given PiecewiseYieldCurve&lt;Traits, Interpolator&gt;.
        const std::vector<QuantLib::Real>& data() const;

        //! Retrieve list of Dates for the given PiecewiseYieldCurve&lt;Traits, Interpolator&gt;.
        const std::vector<QuantLib::Date>& dates() const;

        //! Retrieve list of jump times for the given PiecewiseYieldCurve&lt;Traits, Interpolator&gt;.
        const std::vector<QuantLib::Time>& jumpTimes() const;

        //! Retrieve list of jump dates for the given PiecewiseYieldCurve&lt;Traits, Interpolator&gt;.
        const std::vector<QuantLib::Date>& jumpDates() const;
%insert(rp_class) %{
        InterpolatedYieldCurvePair interpolatedYieldCurvePair() const {
            return pair_;
        }
        private:
		InterpolatedYieldCurvePair pair_;
%}
    };
}

