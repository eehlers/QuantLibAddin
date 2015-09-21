
%group(schedule);

%insert(schedule_library_hpp) %{
#include <ql/time/schedule.hpp>
%}

namespace QuantLib {

    class Schedule {
      public:
        Schedule(
                 Date effectiveDate,
                 const Date& terminationDate,
                 const Period& tenor,
                 const Calendar& calendar,
                 BusinessDayConvention convention,
                 BusinessDayConvention terminationDateConvention,
                 DateGeneration::Rule rule,
                 bool endOfMonth,
                 const Date& firstDate,
                 const Date& nextToLastDate);
         std::vector<Date> dates();
     };
}

