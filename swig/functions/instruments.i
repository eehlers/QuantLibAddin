
%feature("rp:group", "instruments");
%feature("rp:include") %{
#include <ql/instruments/vanillaoption.hpp>
%}

namespace QuantLib {
    class Instrument {
      public:
        Instrument();
        void setPricingEngine(const boost::shared_ptr<QuantLib::PricingEngine>& engine);
        QuantLib::Real NPV();
    };
    class VanillaOption : public Instrument {
      public:
        VanillaOption(const boost::shared_ptr<QuantLib::StrikedTypePayoff>& payoff,
                      const boost::shared_ptr<QuantLib::Exercise>& exercise);
    };
}

