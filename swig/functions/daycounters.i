
%group(daycounters);
%groupCaption(Day Counters);

%insert(daycounters_library_hpp) %{
#include <ql/time/daycounter.hpp>
%}

namespace QuantLib {

    class DayCounter {

    public:

        //! returns the name of the given DayCounter.
        std::string name() const;

        //! calculate the number of days in a period according to a given day count convention.
        %loop(dayCount, EndDate);
        BigInteger dayCount(
            const Date& StartDate,          //!< start date.
            const Date& EndDate             //!< end date.
        ) const;

        //! calculate a year fraction.
        %loop(yearFraction, EndDate);
        Time yearFraction(
            const Date& StartDate,          //!< start date.
            const Date& EndDate,            //!< end date.
            const Date& refPeriodStart,     //!< start date for reference period.
            const Date& refPeriodEnd        //!< end date for reference period.
        ) const;
    };
}

