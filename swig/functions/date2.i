
%feature("rp:group", "date2");
//%feature("rp:obj_include") %{
//#include <qlo/date.hpp>
//%}

%feature("rp:override_obj");

namespace QuantLibAddin {
    std::vector<std::string> IMMNextCodes(
        const QuantLib::Date& RefDate,
        const std::vector<bool>& MainCycle);
}

%feature("rp:override_obj", "");
%feature("rp:group", "");

