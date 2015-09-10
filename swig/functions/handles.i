
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
        // NB: The parameter below must be called "CurrentLink" because there
        // is code which updates a property with that name in the value object.
        RelinkableHandleYieldTermStructure(const std::string &CurrentLink) {}
    };
}

