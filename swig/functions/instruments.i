
%group(Instruments);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class Instrument;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_pricingengines.hpp>
%}

namespace QuantLib {

    //class Foo {};
    
    %explicit_class(Instrument);
    class Instrument {
      public:

        //! Returns the NPV for the given Instrument object.
        Real NPV();

        //! Returns the NPV error estimation (for e.g. Monte Carlo simulation) for the given Instrument object.
        Real errorEstimate() const;

        //! Returns the date to which the net present value refers.
        const Date& valuationDate() const;

        //! Returns TRUE if the given Instrument object is expired.
        virtual bool isExpired() const;

        //! Sets a new pricing engine to the given Instrument object.
        void setPricingEngine(
            const boost::shared_ptr<PricingEngine>& PricingEngine      //!< PricingEngine object ID.
        );
%insert(rp_class) %{
        QuantLib::Real results(const std::string& tag) const;
      protected:
        RP_LIB_CTOR(Instrument, QuantLib::Instrument)
%}
    };
}

namespace QuantLibAddin {

    %noctor(Instrument);
    %noexport(Instrument);
    class Instrument {
      public:
        QuantLib::Real results(const std::string& tag) const;
    };
}
