
%pragma(reposit) group="handles";
%pragma(reposit) override_obj="true";

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

