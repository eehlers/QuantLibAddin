
%feature("rp:group", "handles");

%feature("rp:override_obj");

namespace QuantLibAddin {
    class RelinkableHandleYieldTermStructure {
    public:
        RelinkableHandleYieldTermStructure(const std::string &linkTo) {}
    };
}

%feature("rp:override_obj", "");

%feature("rp:group", "");

