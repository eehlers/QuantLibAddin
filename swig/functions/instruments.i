
%group(instruments);
%groupCaption(Instruments);

%insert(instruments_library_hpp) %{
#include <ql/instruments/vanillaoption.hpp>
#include <ql/cashflow.hpp>
#include <ql/instruments/swap.hpp>
#include <ql/instruments/swaption.hpp>
#include <ql/instruments/forwardrateagreement.hpp>
%}

%insert(instruments_addin_cpp) %{
#include <qlo/obj_pricingengines.hpp>
#include <qlo/obj_payoffs.hpp>
#include <qlo/obj_exercise.hpp>
#include <qlo/objmanual_leg.hpp>
#include <qlo/obj_vanillaswaps.hpp>
#include <qlo/objmanual_termstructures.hpp>
#include <qlo/indexes/iborindex.hpp>
%}

namespace QuantLib {

    class Instrument {
      public:
        %generate(c++, setPricingEngine);
        %generate(c#, setPricingEngine);
        %generate(countify, setPricingEngine);
        //!< Sets a new pricing engine to the given Instrument object.
        void setPricingEngine(
            //!< PricingEngine object ID.
            const boost::shared_ptr<PricingEngine>& engine
        );

        %generate(c++, NPV);
        %generate(c#, NPV);
        %generate(countify, NPV);
        //! Returns the NPV for the given Instrument object.
        Real NPV();
    };

    class VanillaOption : public Instrument {
      public:
        %generate(c++, VanillaOption);
        %generate(c#, VanillaOption);
        %generate(countify, VanillaOption);
        VanillaOption(
            const boost::shared_ptr<StrikedTypePayoff>& payoff,     //!< StrikedTypePayoff object ID.
            const boost::shared_ptr<Exercise>& exercise             //!< Exercise object ID.
        );
    };
    
    class Swaption : public /*Option*/Instrument {
      public:
        %generate(c#, Swaption);
        Swaption(
            const boost::shared_ptr<VanillaSwap>& swap,     //!< underlying (vanilla) swap object ID.
            const boost::shared_ptr<Exercise>& exercise     //!< Exercise object ID.
            /*,Settlement::Type delivery = Settlement::Physical*/
        );
    };
    
    class ForwardRateAgreement: public /*Forward*/Instrument {
      public:
        ForwardRateAgreement(
            const Date& valueDate,                              //!< Value date.
            const Date& maturityDate,                           //!< Maturity date.
            Position::Type type,                                //!< Instrument position (Long = purchase, Short = sale).
            Rate strikeForwardRate,                             //!< Strike rate.
            Real notionalAmount,                                //!< Notional amount.
            const boost::shared_ptr<IborIndex>& index,          //!< Underlying index object ID.
            const Handle<YieldTermStructure>& discountCurve     //!< discounting YieldTermStructure object ID.
            /*,Handle<YieldTermStructure>()*/
            );
    };
}

