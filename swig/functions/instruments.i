
%group(instruments);

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
#include <qlo/obj_termstructures.hpp>
#include <qlo/objmanual_indexes.hpp>
%}

namespace QuantLib {

    class Instrument {
      public:
        %generate(c++, setPricingEngine);
        %generate(c#, setPricingEngine);
        %generate(countify, setPricingEngine);
        void setPricingEngine(const boost::shared_ptr<PricingEngine>& engine);

        %generate(c++, NPV);
        %generate(c#, NPV);
        %generate(countify, NPV);
        Real NPV();
    };

    class VanillaOption : public Instrument {
      public:
        %generate(c++, VanillaOption);
        %generate(c#, VanillaOption);
        %generate(countify, VanillaOption);
        VanillaOption(const boost::shared_ptr<StrikedTypePayoff>& payoff,
                      const boost::shared_ptr<Exercise>& exercise);
    };

    class Swap : public Instrument {
      public:
        %generate(countify, Swap);
        Swap(const std::vector<Leg>& legs,
            const std::vector<bool>& payer);
    };
    
    class Swaption : public /*Option*/Instrument {
      public:
        %generate(c#, Swaption);
        Swaption(const boost::shared_ptr<VanillaSwap>& swap,
                 const boost::shared_ptr<Exercise>& exercise/*,
                 Settlement::Type delivery = Settlement::Physical*/);
    };
    
    class ForwardRateAgreement: public /*Forward*/Instrument {
      public:
        ForwardRateAgreement(const Date& valueDate,
                             const Date& maturityDate,
                             Position::Type type,
                             Rate strikeForwardRate,
                             Real notionalAmount,
                             const boost::shared_ptr<IborIndex>& index,
                             const Handle<YieldTermStructure>& discountCurve /*=
                                                 Handle<YieldTermStructure>()*/);
    };
    
}

