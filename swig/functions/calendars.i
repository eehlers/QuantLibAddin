
%group(calendars);
%groupCaption(Calendars);

%insert(calendars_library_hpp) %{
#include <ql/time/calendar.hpp>
%}

namespace QuantLib {

    class Calendar {

    public:

        %loop(isEndOfMonth, date);
        //! returns TRUE if the date is last business day for the month in the given calendar.
        bool isEndOfMonth(
            const Date& date    //!< date.
            ) const;

        %loop(endOfMonth, date);
        Date endOfMonth(
            const Date& date    //!< date.
            ) const;

        %generate(c#, advance);
        %loop(advance, period);
        //! advances a date according to a given calendar.
        Date advance(
            const Date& date,                   //!< start date to be advanced.
            const Period& period,               //!< period(s) to advance (e.g. 2D for two days , 3W for three weeks, 6M for six months, 1Y for one year).
            BusinessDayConvention convention,   //!< rolling convention.
            bool endOfMonth                     //!< flag to enforce end of month convention.
            ) const;

        %loop(adjust, date);
        //! Adjusts a non-business day to the appropriate near business day according to a given calendar with respect to the given convention.
        Date adjust(
            const Date& date,                   //!< date to be adjusted.
            BusinessDayConvention convention    //!< rolling convention.
            ) const;
    };
}

