
%pragma(reposit) group="date";
%override

%insert(date_lib_inc) %{
#include <ql/time/date.hpp>
%}

namespace QuantLibAddin {
    bool dateIsEndOfMonth(const QuantLib::Date& d);
}

