
%group(daycounters);

%insert(daycounters_library_hpp) %{
#include <ql/time/daycounter.hpp>
%}

%insert(daycounters_addin_cpp) %{
#include <qlo/obj_daycounters.hpp>
%}

namespace QuantLib {

    class DayCounter {

    public:

        %loop(yearFraction, EndDate);
        Time yearFraction(
            const Date& StartDate,
            const Date& EndDate,
            const Date& refPeriodStart,
            const Date& refPeriodEnd);
    };
}

