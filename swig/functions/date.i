
%pragma(reposit) group="date";
%pragma(reposit) override_obj="true";

%insert(date_lib_inc) %{
#include <ql/time/date.hpp>
%}

namespace QuantLibAddin {
    bool dateIsEndOfMonth(const QuantLib::Date& d);
}

