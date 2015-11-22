
%group(piecewiseyieldcurve);
%override;

namespace QuantLibAddin {

    class PiecewiseYieldCurve : public YieldTermStructure {
      public:
        PiecewiseYieldCurve(
            QuantLib::Natural nDays,
            const QuantLib::Calendar& calendar,
            const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& qlrhs,
            const QuantLib::DayCounter& dayCounter = QuantLib::Actual365Fixed(),
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& jumps,
            const std::vector<QuantLib::Date>& jumpDates,
            QuantLib::Real accuracy = 1.0e-12,
            const std::string& traitsID,
            const std::string& interpolatorID);
        std::vector<QuantLib::Real> data();
    };
}

