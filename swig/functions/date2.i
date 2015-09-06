
%pragma(reposit) group="date2";
%pragma(reposit) override_obj="true";

%feature("rp:loopParameter", "immCode") QuantLibAddin::IMMdate;
%feature("rp:loopParameter", "immDate") QuantLibAddin::IMMcode;

namespace QuantLibAddin {

    std::vector<QuantLib::Date> IMMNextDates(
        const QuantLib::Date& d,
        const std::vector<bool>& mainCycle);

    std::vector<std::string> IMMNextCodes(
        const QuantLib::Date& RefDate,
        const std::vector<bool>& MainCycle);
        
    QuantLib::Date IMMdate(
        const std::string& immCode,
        const QuantLib::Date &referenceDate);
        
    std::string IMMcode(const QuantLib::Date& immDate);
    
    std::string IMMnextCode(const QuantLib::Date& d,
                                bool mainCycle);
    
    std::string ECBcode(const QuantLib::Date& ecbDate);
    std::string ECBnextCode(const QuantLib::Date& RefDate);
    QuantLib::Date ECBdate(const std::string& ecbCode,
        const QuantLib::Date& referenceDate);
    QuantLib::Date ECBnextDate(const QuantLib::Date& date);
}

