
// FIXME Relocate these relinkable handle classes to their respective function groups.
// For an example, see class RelinkableHandleOptionletVolatilityStructure in group capletvolstructure.

%override;
%group(Handles);

namespace QuantLibAddin {

    class RelinkableHandle {
    public:
        //! Relink the RelinkableHandle to the given object.
        void linkTo(
            const std::string &objectID2    //!< ID of Object to which the RelinkableHandle should be relinked, or empty string for null object.
        );
    };

    class RelinkableHandleYieldTermStructure {
    public:
        // attach processor RelinkableHandleProcessor to ctor RelinkableHandleYieldTermStructure.
        %processor(RelinkableHandleYieldTermStructure, RelinkableHandleProcessor);
        // NB: The parameter below must be called "CurrentLink" because there
        // is code which updates a property with that name in the value object.
        RelinkableHandleYieldTermStructure(
            const std::string &CurrentLink  //!< YieldTermStructure object ID. If omitted, nothing is linked by the RelinkableHandle.
        );
    };

    class RelinkableHandleQuote {
    public:
        // attach processor RelinkableHandleProcessor to ctor RelinkableHandleQuote.
        %processor(RelinkableHandleQuote, RelinkableHandleProcessor);
        // NB: The parameter below must be called "CurrentLink" because there
        // is code which updates a property with that name in the value object.
        RelinkableHandleQuote(
            const std::string &CurrentLink  //!< Quote object ID. If omitted, nothing is linked by the RelinkableHandle.
        );
    };

    class RelinkableHandleSwaptionVolatilityStructure {
    public:
        // attach processor RelinkableHandleProcessor to ctor RelinkableHandleSwaptionVolatilityStructure.
        %processor(RelinkableHandleSwaptionVolatilityStructure, RelinkableHandleProcessor);
        // NB: The parameter below must be called "CurrentLink" because there
        // is code which updates a property with that name in the value object.
        RelinkableHandleSwaptionVolatilityStructure(
            const std::string &CurrentLink  //!< SwaptionVolatilityStructure object ID. If omitted, nothing is linked by the RelinkableHandle.
        );
    };

    class RelinkableHandleDefaultProbabilityTermStructure {
      public:

        %processor(RelinkableHandleDefaultProbabilityTermStructure, RelinkableHandleProcessor);
        RelinkableHandleDefaultProbabilityTermStructure(
            const std::string &CurrentLink                                  //!< DefaultProbabilityTermStructure object ID. If omitted, nothing is linked by the RelinkableHandle.
        );
    };
}

