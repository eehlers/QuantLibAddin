
%group(piecewiseyieldcurve);
%groupCaption(Piecewise Yield Curve);
%override;

namespace QuantLibAddin {

    class PiecewiseYieldCurve : public YieldTermStructure {
      public:
        PiecewiseYieldCurve(
            QuantLib::Natural nDays,                                                //!< number of days to advance from EvaluationDate (usually zero or two): it fixes the date at which the discount factor = 1.0.
            const QuantLib::Calendar& calendar,                                     //!< holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& qlrhs,     //!< vector of rate-helpers.
            const QuantLib::DayCounter& dayCounter = QuantLib::Actual365Fixed(),    //!< DayCounter ID.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& jumps,           //!< Jump quotes vector.
            const std::vector<QuantLib::Date>& jumpDates,                           //!< Jump dates vector.
            QuantLib::Real accuracy = 1.0e-12,                                      //!< Bootstrapping accuracy.
            const std::string& traitsID,                                            //!< Discount, ZeroRate, or ForwardRate.
            const std::string& interpolatorID                                       //!< BackwardFlat, ForwardFlat, Linear, LogLinear, CubicSpline, or LogCubic.
        );
        //! Retrieve Data for the given PiecewiseYieldCurve&lt;Traits, Interpolator&gt;.
        std::vector<QuantLib::Real> data();
        //! Retrieve list of Dates for the given PiecewiseYieldCurve&lt;Traits, Interpolator&gt;.
        std::vector<QuantLib::Date> dates();        
    };
}

