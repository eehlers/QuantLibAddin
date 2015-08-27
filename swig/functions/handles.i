
%feature("rp:group", "handles");

%feature("rp:override_obj");

%feature("rp:processorName", "RelinkableHandleProcessor") QuantLibAddin::RelinkableHandleYieldTermStructure::RelinkableHandleYieldTermStructure;

namespace QuantLibAddin {

    class RelinkableHandle {
    public:
        void linkTo(const std::string &objectID2);
    };
    
    class RelinkableHandleYieldTermStructure {
    public:
        RelinkableHandleYieldTermStructure(const std::string &linkTo) {}
    };
}

%feature("rp:override_obj", "");

%feature("rp:group", "");

