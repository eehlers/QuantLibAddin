
%pragma(reposit) group="models";

%pragma(reposit) obj_include=%{
#include <ql/models/shortrate/calibrationhelpers/swaptionhelper.hpp>
%}

namespace QuantLib {

    class SwaptionHelper /*: public CalibrationHelper*/ {
      public:
        SwaptionHelper(const QuantLib::Period& maturity,
                       const QuantLib::Period& length,
                       const QuantLib::Handle<QuantLib::Quote>& volatility,
                       const boost::shared_ptr<QuantLib::IborIndex>& index,
                       const QuantLib::Period& fixedLegTenor,
                       const QuantLib::DayCounter& fixedLegDayCounter,
                       const QuantLib::DayCounter& floatingLegDayCounter,
                       const QuantLib::Handle<QuantLib::YieldTermStructure>& termStructure/*,
                       QuantLib::CalibrationHelper::CalibrationErrorType errorType
                                      = QuantLib::CalibrationHelper::RelativePriceError,
                       const QuantLib::Real strike = QuantLib::Null<QuantLib::Real>(),
                       const QuantLib::Real nominal = 1.0,
                       const QuantLib::Real shift = 0.0*/);
        };
}
