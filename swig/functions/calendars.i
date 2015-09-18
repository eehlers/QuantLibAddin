
%group(calendars);

%insert(calendars_lib_inc) %{
#include <ql/time/calendar.hpp>
%}

%loop(QuantLib::Calendar::isEndOfMonth, date)
%loop(QuantLib::Calendar::endOfMonth, date)
%loop(QuantLib::Calendar::advance, period)
%loop(QuantLib::Calendar::adjust, date)

namespace QuantLib {

    class Calendar {

    public:

        bool isEndOfMonth(const QuantLib::Date& date) const;
        QuantLib::Date endOfMonth(const QuantLib::Date& date) const;

        QuantLib::Date advance(
            const QuantLib::Date& date,
            const QuantLib::Period& period,
            QuantLib::BusinessDayConvention convention,
            bool endOfMonth) const;

        QuantLib::Date adjust(const QuantLib::Date& date,
            QuantLib::BusinessDayConvention convention);
    };
}

