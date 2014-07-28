
%feature("rp:group", "instruments");
%feature("rp:include") %{
#include <ql/instruments/vanillaoption.hpp>
%}

namespace QuantLib {
    class VanillaOption {
      public:
        VanillaOption(const boost::shared_ptr<QuantLib::StrikedTypePayoff>& payoff,
                      const boost::shared_ptr<QuantLib::Exercise>& exercise);
    };
}

