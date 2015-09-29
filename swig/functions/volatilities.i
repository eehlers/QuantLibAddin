
%group(volatilities);

%insert(volatilities_library_hpp) %{
#include <ql/termstructures/volatility/equityfx/blackconstantvol.hpp>
#include <qlo/objmanual_piecewiseyieldcurve.hpp>
%}

namespace QuantLib {

    class BlackVolTermStructure : public TermStructure {};

    class BlackConstantVol : public BlackVolTermStructure {
      public:
        %generate(c++, BlackConstantVol);
        %generate(c#, BlackConstantVol);
        %generate(countify, BlackConstantVol);
        BlackConstantVol(const Date& referenceDate,
                         const Calendar& calendar,
                         Volatility volatility,
                         const DayCounter& dayCounter);
    };
}

