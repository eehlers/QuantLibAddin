
%pragma(reposit) group="utilities";
%pragma(reposit) override_obj="true";

%feature("rp:generate_countify");
%feature("rp:generate_cpp");

namespace QuantLibAddin {
    std::string version();
    long ObjectCount();
    // temporary hack to extract the accrual start dates from the fixed leg of a swap
    std::vector<QuantLib::Date> temp1(const std::string &s);
}

%feature("rp:generate_countify", "");
%feature("rp:generate_cpp", "");

