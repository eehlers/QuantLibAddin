
%group(utilities);
%override

namespace QuantLibAddin {
    %generate(cpp, version);
    %generate(countify, version);
    std::string version();
    %generate(cpp, ObjectCount);
    %generate(countify, ObjectCount);
    long ObjectCount();
    // temporary hack to extract the accrual start dates from the fixed leg of a swap
    std::vector<QuantLib::Date> temp1(const std::string &s);
}

