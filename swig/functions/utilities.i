
%pragma(reposit) group="utilities";
%override

%feature("rp:generate_countify");
%feature("rp:generate_cpp") QuantLibAddin::version;
%feature("rp:generate_cpp") QuantLibAddin::ObjectCount;

namespace QuantLibAddin {
    std::string version();
    long ObjectCount();
    // temporary hack to extract the accrual start dates from the fixed leg of a swap
    std::vector<QuantLib::Date> temp1(const std::string &s);
}

%feature("rp:generate_countify", "");

