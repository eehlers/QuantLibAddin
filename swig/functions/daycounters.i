
%group(daycounters);

%insert(daycounters_library_hpp) %{
#include <ql/time/daycounter.hpp>
%}

namespace QuantLib {

    class DayCounter {

    public:

        %loop(yearFraction, EndDate)
        Time yearFraction(
            const Date& StartDate,
            const Date& EndDate,
            const Date& refPeriodStart,
            const Date& refPeriodEnd);
    };
}

