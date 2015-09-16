
%pragma(reposit) group="instruments";

%pragma(reposit) obj_include=%{
#include <ql/instruments/vanillaoption.hpp>
#include <ql/cashflow.hpp>
#include <ql/instruments/swap.hpp>
#include <ql/instruments/swaption.hpp>
%}

%pragma(reposit) add_include=%{
#include "qlo/obj_pricingengines.hpp"
#include "qlo/obj_payoffs.hpp"
#include "qlo/obj_exercise.hpp"
%}

%feature("rp:generate_countify") QuantLib::VanillaOption::VanillaOption;
%feature("rp:generate_countify") QuantLib::Instrument::setPricingEngine;
%feature("rp:generate_countify") QuantLib::Instrument::NPV;
%feature("rp:generate_cpp") QuantLib::VanillaOption::VanillaOption;
%feature("rp:generate_cpp") QuantLib::Instrument::setPricingEngine;
%feature("rp:generate_cpp") QuantLib::Instrument::NPV;

namespace QuantLib {

    class Instrument {
      public:
        //Instrument();
        void setPricingEngine(const boost::shared_ptr<QuantLib::PricingEngine>& engine);
        QuantLib::Real NPV();
    };

    class VanillaOption : public Instrument {
      public:
        VanillaOption(const boost::shared_ptr<QuantLib::StrikedTypePayoff>& payoff,
                      const boost::shared_ptr<QuantLib::Exercise>& exercise);
    };

    class Swap : public Instrument {
      public:
        Swap(const std::vector<QuantLib::Leg>& legs,
            const std::vector<bool>& payer);
    };
    
    class Swaption : public /*Option*/Instrument {
      public:
        Swaption(const boost::shared_ptr<QuantLib::VanillaSwap>& swap,
                 const boost::shared_ptr<QuantLib::Exercise>& exercise/*,
                 Settlement::Type delivery = Settlement::Physical*/);
    };
}

