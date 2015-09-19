
%group(daycounters);

%insert(daycounters_library_hpp) %{
#include <ql/time/daycounter.hpp>
%}

%loop(QuantLib::DayCounter::yearFraction, EndDate)

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

