
%feature("rp:group", "ratehelpers");

%feature("rp:obj_include") %{
#include <ql/termstructures/yield/ratehelpers.hpp>
%}

namespace QuantLib {

    class FraRateHelper {
        public:
        FraRateHelper(const QuantLib::Handle<QuantLib::Quote>& rate,
                      QuantLib::Period periodToStart,
                      const boost::shared_ptr<QuantLib::IborIndex>& iborIndex);    
    };
}

%feature("rp:group", "");

