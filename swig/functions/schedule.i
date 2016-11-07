
%group(schedule);
%groupCaption(Schedule);

%insert(schedule_library_hpp) %{
#include <ql/time/dategenerationrule.hpp>

namespace QuantLib {
    class Schedule;
    class Date;
    class Period;
    class Calendar;
    enum BusinessDayConvention;
}
%}

%insert(schedule_addin_cpp) %{
#include <ql/time/schedule.hpp>
%}

namespace QuantLib {

    class Schedule {
      public:

        Schedule(
                 const Date &EffectiveDate/*=Date()*/,              //!< effective date.
                 const Date &TerminationDate,                       //!< termination date.
                 const Period &Tenor,                               //!< tenor (e.g. 2D for two days , 3W for three weeks, 6M for six months, 1Y for one year).
                 const Calendar &Calendar=QuantLib::NullCalendar(), //!< holiday calendar (e.g. TARGET).
                 BusinessDayConvention Convention=QuantLib::BusinessDayConvention(QuantLib::Unadjusted),//!< accrual dates business day convention.
                 BusinessDayConvention TermDateConv=QuantLib::BusinessDayConvention(QuantLib::Unadjusted),//!< termination date business day convention.
                 DateGeneration::Rule GenRule=QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Backward),//!< Date generation rule (Backward, Forward, ThirdWednesday, Twentieth, TwentiethIMM, Zero).
                 bool EndOfMonth=false,                             //!< end of month convention. Ignored for Tenor below 1M.
                 const Date& FirstDate=Date(),                      //!< stub date, if there is an irregular starting period.
                 const Date& NextToLastDate=Date()                  //!< stub date, if there an irregular final period.
        );
        
        %rename(ScheduleFromDateVector) Schedule;
        Schedule(
            const std::vector<Date>& EffectiveDate/*=std::vector<Date>()*/ //!< Date vector.
        );

        %rename(ScheduleTruncated) Schedule;
        %override2(Schedule);
        Schedule(
            const boost::shared_ptr<Schedule>& OriginalSchedule,    //!< Original schedule object ID.
            const Date& TruncationDate                              //!< Truncation date.
        );

        //! Returns the number of dates in the given Schedule object.
        Size size() const;

        //! Returns the highest date in the given Schedule object preceding the input reference date.
        Date previousDate(
            const Date& RefDate=Date()                              //!< Reference date.
        ) const;

        //! Returns the lowest date in the given Schedule object following the input reference date.
        Date nextDate(
            const Date& RefDate=Date()                              //!< Reference date.
        ) const;

        //! Returns the dates for the given Schedule object.
        std::vector<Date> dates();

        //! Returns TRUE if the selected period in the given Schedule object is regular.
        bool isRegular(
            Size Index=1                                            //!< One based period index.
        ) const;

        //! Returns TRUE if the given Schedule object is empty.
        bool empty() const;

        //! Returns the Calendar used to calculate the given Schedule object.
        const Calendar& calendar() const;

        //! Returns the start date of the given Schedule object.
        const Date& startDate() const;

        //! Returns the end date of the given Schedule object.
        const Date& endDate() const;

        //! Returns the tenor used to calculate the given Schedule object.
        const Period& tenor() const;

        //! Returns the business day convention used to calculate the given Schedule object.
        %rename(BDC) businessDayConvention;
        //%alias(BDC, businessDayConvention);
        BusinessDayConvention businessDayConvention() const;

        //! Returns the business day convention used to calculate the termination date of the given Schedule object.
        %rename(terminationDateBDC) terminationDateBusinessDayConvention;
        //%alias(terminationDateBDC, terminationDateBusinessDayConvention);
        BusinessDayConvention terminationDateBusinessDayConvention() const;

        //! Returns the DateGeneration::Rule of the given Schedule object.
        DateGeneration::Rule rule() const;

        //! Returns TRUE if end-of-month convention has been used to calculate the given Schedule object.
        bool endOfMonth() const;
     };
}

