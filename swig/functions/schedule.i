
%feature("rp:group", "schedule");
%feature("rp:obj_include") %{
#include <ql/time/schedule.hpp>
%}

namespace QuantLib {

    class Schedule {
      public:
        Schedule(
                 // FIXME we declare effectiveDate as "const QuantLib::Date&" instead of "QuantLib::Date".
                 // This is because the typemaps currently work for "const Date&" as an input value
                 // and for "Date" as a return value but not for "Date" as an input value.
                 //QuantLib::Date effectiveDate,
                 const QuantLib::Date& effectiveDate,
                 const QuantLib::Date& terminationDate,
                 const QuantLib::Period& tenor,
                 const QuantLib::Calendar& calendar,
                 QuantLib::BusinessDayConvention convention,
                 QuantLib::BusinessDayConvention terminationDateConvention,
                 QuantLib::DateGeneration::Rule rule,
                 bool endOfMonth,
                 const QuantLib::Date& firstDate,
                 const QuantLib::Date& nextToLastDate);
     };
}

%feature("rp:obj_include", "");
%feature("rp:group", "");

