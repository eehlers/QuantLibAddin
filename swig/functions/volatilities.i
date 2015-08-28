
%feature("rp:group", "volatilities");
%feature("rp:obj_include") %{
#include <ql/termstructures/volatility/equityfx/blackconstantvol.hpp>
#include <qlo/objmanual_piecewiseyieldcurve.hpp>
%}

namespace QuantLib {
    class BlackConstantVol : public TermStructure {
      public:
        BlackConstantVol(const QuantLib::Date& referenceDate,
                         const QuantLib::Calendar& calendar,
                         QuantLib::Volatility volatility,
                         const QuantLib::DayCounter& dayCounter);
    };
}

%feature("rp:group", "");

