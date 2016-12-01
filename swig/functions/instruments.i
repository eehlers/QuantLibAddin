
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
    
    %noctor(Instrument);
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
            const boost::shared_ptr<PricingEngine>& PricingEngine   //!< PricingEngine object ID.
        );

        //! Returns the required result (if available) for the given Instrument object.
        %wrap(results);
        Real results(
            const std::string& ResultType                           //!< Result type (e.g. 'vega').
        ) const;
%insert(rp_class) %{
      protected:
        RP_LIB_CTOR(Instrument, QuantLib::Instrument)
%}
    };
}

