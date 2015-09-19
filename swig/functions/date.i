
%group(date);
%override

%insert(date_library_hpp) %{
#include <ql/time/date.hpp>
%}

namespace QuantLibAddin {
    bool dateIsEndOfMonth(const QuantLib::Date& d);
}

