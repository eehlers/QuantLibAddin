
%include termstructures.i

%feature("rp:group", "piecewiseyieldcurve");

%feature("rp:override_obj");

namespace QuantLibAddin {

    class PiecewiseYieldCurve : public YieldTermStructure {
      public:
        PiecewiseYieldCurve(
            QuantLib::Natural nDays,
            const QuantLib::Calendar& calendar,
            const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& qlrhs,
            const QuantLib::DayCounter& dayCounter,
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& jumps,
            const std::vector<QuantLib::Date>& jumpDates,
            QuantLib::Real accuracy,
            const std::string& traitsID,
            const std::string& interpolatorID);
        std::vector<QuantLib::Real> data();            
    }; 
}

%feature("rp:override_obj", "");
%feature("rp:group", "");
