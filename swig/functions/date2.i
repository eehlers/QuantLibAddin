
%feature("rp:group", "date2");
//%feature("rp:obj_include") %{
//#include <qlo/date.hpp>
//%}

%feature("rp:override_obj");

%feature("rp:loopParameter", "immDate") QuantLibAddin::IMMcode;

namespace QuantLibAddin {

    std::vector<QuantLib::Date> IMMNextDates(
        const QuantLib::Date& d,
        const std::vector<bool>& mainCycle);

    std::vector<std::string> IMMNextCodes(
        const QuantLib::Date& RefDate,
        const std::vector<bool>& MainCycle);
        
    std::string IMMcode(const QuantLib::Date& immDate);        
}

%feature("rp:override_obj", "");
%feature("rp:group", "");

