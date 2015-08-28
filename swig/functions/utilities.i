
%feature("rp:group", "utilities");

%feature("rp:override_obj");
%feature("rp:generate_countify");

namespace QuantLibAddin {
    std::string version();
}

%feature("rp:override_obj", "");
%feature("rp:generate_countify", "");
%feature("rp:group", "");

