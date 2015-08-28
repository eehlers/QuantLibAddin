
%feature("rp:group", "daycounters");
%feature("rp:obj_include") %{
#include <ql/time/daycounter.hpp>
%}

%feature("rp:loopParameter", "EndDate") QuantLib::DayCounter::yearFraction;

namespace QuantLib {

    class DayCounter {
    
    public:
    
        QuantLib::Time yearFraction(
            const QuantLib::Date& StartDate,
            const Date& EndDate,
            const QuantLib::Date& refPeriodStart,
            const QuantLib::Date& refPeriodEnd);
    };
}

%feature("rp:obj_include", "");
%feature("rp:group", "");

