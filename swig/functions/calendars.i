
%group(calendars);

%insert(calendars_library_hpp) %{
#include <ql/time/calendar.hpp>
%}

namespace QuantLib {

    class Calendar {

    public:

        %loop(isEndOfMonth, date);
        bool isEndOfMonth(const Date& date) const;

        %loop(endOfMonth, date);
        Date endOfMonth(const Date& date) const;

        %generate(c#, advance);
        %loop(advance, period);
        Date advance(
            const Date& date,
            const Period& period,
            BusinessDayConvention convention = Following,
            bool endOfMonth = false) const;

        %loop(adjust, date);
        Date adjust(const Date& date,
            BusinessDayConvention convention);
    };
}

