
%feature("rp:group", "volatilities");
%feature("rp:obj_include") %{
#include <ql/termstructures/volatility/equityfx/blackconstantvol.hpp>
#include <qlo/objmanual_piecewiseyieldcurve.hpp>
%}
%feature("rp:generate_countify") QuantLib::BlackConstantVol::BlackConstantVol;

namespace QuantLib {

    class BlackVolTermStructure : public TermStructure {};

    class BlackConstantVol : public BlackVolTermStructure {
      public:
        BlackConstantVol(const QuantLib::Date& referenceDate,
                         const QuantLib::Calendar& calendar,
                         QuantLib::Volatility volatility,
                         const QuantLib::DayCounter& dayCounter);
    };
}

%feature("rp:obj_include", "");
%feature("rp:group", "");

