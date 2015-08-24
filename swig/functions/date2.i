
%feature("rp:group", "date2");

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
    
    std::string IMMnextCode(const QuantLib::Date& d,
                                bool mainCycle);
    
    std::string ECBnextCode(const QuantLib::Date& RefDate);
    QuantLib::Date ECBdate(const std::string& ecbCode,
        const QuantLib::Date& referenceDate);
    
}

%feature("rp:override_obj", "");
%feature("rp:group", "");

