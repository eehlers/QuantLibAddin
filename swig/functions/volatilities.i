
%group(volatilities);
%groupCaption(Volatilities);

%insert(volatilities_library_hpp) %{
#include <ql/termstructures/volatility/equityfx/blackconstantvol.hpp>
#include <qlo/objects/objmanual_piecewiseyieldcurve.hpp>
%}

namespace QuantLib {

    class BlackVolTermStructure : public TermStructure {};

    class BlackConstantVol : public BlackVolTermStructure {
      public:
        %generate(c++, BlackConstantVol);
        %generate(c#, BlackConstantVol);
        %generate(countify, BlackConstantVol);
        BlackConstantVol(
            const Date& referenceDate,      //!< settlement date.
            const Calendar& calendar,       //!< holiday calendar (e.g. TARGET).
            Volatility volatility,          //!< volatility.
            const DayCounter& dayCounter    //!< DayCounter ID.
        );
    };
}

