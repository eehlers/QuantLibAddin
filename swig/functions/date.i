
%pragma(reposit) group="date";
%pragma(reposit) override_obj="true";

%pragma(reposit) obj_include=%{
#include <ql/time/date.hpp>
%}

namespace QuantLibAddin {
    bool dateIsEndOfMonth(const QuantLib::Date& d);
}

