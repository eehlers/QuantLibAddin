
%pragma(reposit) group="utilities";
%pragma(reposit) override_obj="true";

%feature("rp:generate_countify");
%feature("rp:generate_cpp");

namespace QuantLibAddin {
    std::string version();
    long ObjectCount();
}

%feature("rp:generate_countify", "");
%feature("rp:generate_cpp", "");

