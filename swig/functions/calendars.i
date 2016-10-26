
%group(calendars);
%groupCaption(Calendars);

%insert(calendars_library_hpp) %{
#include <ql/time/calendar.hpp>
%}

namespace QuantLib {

    class Calendar {
      public:

        //! Returns the name of the given calendar.
        std::string name() const;

        //! Returns TRUE if the date is a business day for the given calendar.
        %loop(isBusinessDay, Date);
        bool isBusinessDay(
            const Date& Date                //!< date.
        ) const;

        //! returns TRUE if the date is a holiday for the given calendar.
        %loop(isBusinessDay, Date);
        bool isHoliday(
            const Date& Date                //!< date.
        ) const;

        //! returns TRUE if the date is last business day for the month in the given calendar.
        %loop(isEndOfMonth, Date);
        bool isEndOfMonth(
            const Date& Date                //!< date.
        ) const;

        //! returns the last business day in the given calendar of the month to which the given date belongs.
        %loop(endOfMonth, Date);
        Date endOfMonth(
            const Date& Date                //!< date.
        ) const;

        //! adds an holiday to the given calendar.
        void addHoliday(
            const Date& Date                //!< date.
        );

        //! removes an holiday from the given calendar.
        void removeHoliday(
            const Date& Date                //!< date.
        );

        //! returns the holidays in a period between two dates according to a given holiday calendar.
        static std::vector<Date> holidayList(
            const Calendar& Calendar,       //!< Calendar to use for holiday determination.
            const Date& FromDate,           //!< first date of the period.
            const Date& ToDate,             //!< last date of the period.
            bool IncludeWeekEnds = false    //!< include week-end as holidays.
        );

        //! Adjusts a non-business day to the appropriate near business day according to a given calendar with respect to the given convention.
        %loop(adjust, Date);
        Date adjust(
            const Date& Date,               //!< date to be adjusted.
            BusinessDayConvention BusinessDayConvention=QuantLib::BusinessDayConvention(QuantLib::Following)    //!< rolling convention.
        ) const;

        //! advances a date according to a given calendar.
        %loop(advance, Period);
        Date advance(
            const Date& StartDate,          //!< start date to be advanced.
            const Period& Period,           //!< period(s) to advance (e.g. 2D for two days , 3W for three weeks, 6M for six months, 1Y for one year).
            BusinessDayConvention BusinessDayConvention=QuantLib::BusinessDayConvention(QuantLib::Following),   //!< rolling convention.
            bool EndOfMonth=false           //!< flag to enforce end of month convention.
            ) const;

        //! Returns the number of business days between two dates.
        %loop(businessDaysBetween, FirstDate);
        BigInteger businessDaysBetween(
            const Date& FirstDate,          //!< first date of the period.
            const Date& LastDate,           //!< last date of the period.
            bool IncludeFirst = false,      //!< include the first date when counting business days.
            bool IncludeLast = false        //!< include the last date when counting business days.
        ) const;
    };
}

