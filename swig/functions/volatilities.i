
%group(volatilities);

%insert(volatilities_library_hpp) %{
#include <ql/termstructures/volatility/equityfx/blackconstantvol.hpp>
#include <qlo/objmanual_piecewiseyieldcurve.hpp>
%}


namespace QuantLib {

    class BlackVolTermStructure : public TermStructure {};

    class BlackConstantVol : public BlackVolTermStructure {
      public:
        %generate(cpp, BlackConstantVol);
        %generate(countify, BlackConstantVol);
        BlackConstantVol(const QuantLib::Date& referenceDate,
                         const QuantLib::Calendar& calendar,
                         QuantLib::Volatility volatility,
                         const QuantLib::DayCounter& dayCounter);
    };
}

