
%feature("rp:group", "date");
%feature("rp:obj_include") %{
#include <ql/time/date.hpp>
%}

%feature("rp:override_obj");

namespace QuantLibAddin {
    bool dateIsEndOfMonth(const QuantLib::Date& d);
}

%feature("rp:obj_include", "");
%feature("rp:override_obj", "");
%feature("rp:group", "");

