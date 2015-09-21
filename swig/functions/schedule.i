
%group(schedule);

%insert(schedule_library_hpp) %{
#include <ql/time/schedule.hpp>
%}

namespace QuantLib {

    class Schedule {
      public:
        Schedule(
                 // FIXME we declare effectiveDate as "const Date&" instead of "Date".
                 // This is because the typemaps currently work for "const Date&" as an input value
                 // and for "Date" as a return value but not for "Date" as an input value.
                 //Date effectiveDate,
                 const Date& effectiveDate,
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

