
%feature("rp:group", "volatilities");
%feature("rp:include") %{
#include <ql/termstructures/volatility/equityfx/blackconstantvol.hpp>
%}

namespace QuantLib {
    class BlackConstantVol {
      public:
        BlackConstantVol(const QuantLib::Date& referenceDate,
                         const QuantLib::Calendar& calendar,
                         QuantLib::Volatility volatility,
                         const QuantLib::DayCounter& dayCounter);
    };
}

