
%feature("rp:group", "utilities");

%feature("rp:override_obj");
%feature("rp:generate_countify");
%feature("rp:generate_cpp");

namespace QuantLibAddin {
    std::string version();
    long ObjectCount();
}

%feature("rp:override_obj", "");
%feature("rp:generate_countify", "");
%feature("rp:generate_cpp", "");
%feature("rp:group", "");

