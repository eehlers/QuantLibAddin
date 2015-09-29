
%group(instruments);

%insert(instruments_library_hpp) %{
#include <ql/instruments/vanillaoption.hpp>
#include <ql/cashflow.hpp>
#include <ql/instruments/swap.hpp>
#include <ql/instruments/swaption.hpp>
%}

%insert(instruments_addin_cpp) %{
#include <qlo/obj_pricingengines.hpp>
#include <qlo/obj_payoffs.hpp>
#include <qlo/obj_exercise.hpp>
#include <qlo/objmanual_leg.hpp>
#include <qlo/obj_vanillaswaps.hpp>
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
        Swap(const std::vector<Leg>& legs,
            const std::vector<bool>& payer);
    };
    
    class Swaption : public /*Option*/Instrument {
      public:
        Swaption(const boost::shared_ptr<VanillaSwap>& swap,
                 const boost::shared_ptr<Exercise>& exercise/*,
                 Settlement::Type delivery = Settlement::Physical*/);
    };
}

