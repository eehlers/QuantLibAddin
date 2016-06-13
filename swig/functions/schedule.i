
%group(schedule);
%groupCaption(Schedule);

%insert(schedule_library_hpp) %{
#include <ql/time/schedule.hpp>
%}

namespace QuantLib {

    class Schedule {
      public:
        %generate(c#, Schedule);
        %generate(countify, Schedule);
        Schedule(
                 Date effectiveDate,                                //!< effective date.
                 const Date& terminationDate,                       //!< termination date.
                 const Period& tenor,                               //!< tenor (e.g. 2D for two days , 3W for three weeks, 6M for six months, 1Y for one year).
                 const Calendar& calendar,                          //!< holiday calendar (e.g. TARGET).
                 BusinessDayConvention convention,                  //!< accrual dates business day convention.
                 BusinessDayConvention terminationDateConvention,   //!< termination date business day convention.
                 DateGeneration::Rule rule,                         //!< Date generation rule (Backward, Forward, ThirdWednesday, Twentieth, TwentiethIMM, Zero).
                 bool endOfMonth,                                   //!< end of month convention. Ignored for Tenor below 1M.
                 const Date& firstDate,                             //!< stub date, if there is an irregular starting period.
                 const Date& nextToLastDate                         //!< stub date, if there an irregular final period.
        );
        //! returns the dates for the given Schedule object.
         std::vector<Date> dates();
     };
}

