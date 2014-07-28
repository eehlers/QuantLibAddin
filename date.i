
%feature("rp:group", "date");
%feature("rp:generation", "manual");
//%feature("rp:include") %{
//#include <ql/time/date.hpp>
//%}

namespace QuantLibAddin {
    bool dateIsEndOfMonth(const QuantLib::Date& d);
}

