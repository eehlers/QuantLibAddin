
%group(daycounters);
%groupCaption(Day Counters);

%insert(daycounters_library_hpp) %{
#include <ql/time/daycounter.hpp>
%}

namespace QuantLib {

    class DayCounter {

    public:

        %loop(yearFraction, EndDate);
        //! calculate a year fraction.
        Time yearFraction(
            const Date& StartDate,          //!< start date.
            const Date& EndDate,            //!< end date.
            const Date& refPeriodStart,     //!< start date for reference period.
            const Date& refPeriodEnd        //!< end date for reference period.
        ) const;
    };
}

