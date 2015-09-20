
%group(calendars);

%insert(calendars_library_hpp) %{
#include <ql/time/calendar.hpp>
%}

namespace QuantLib {

    class Calendar {

    public:

        %loop(isEndOfMonth, date)
        bool isEndOfMonth(const Date& date) const;

        %loop(endOfMonth, date)
        Date endOfMonth(const Date& date) const;

        %loop(advance, period)
        Date advance(
            const Date& date,
            const Period& period,
            BusinessDayConvention convention,
            bool endOfMonth) const;

        %loop(adjust, date)
        Date adjust(const Date& date,
            BusinessDayConvention convention);
    };
}

