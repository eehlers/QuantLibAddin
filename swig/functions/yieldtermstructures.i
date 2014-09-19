
%feature("rp:group", "yieldtermstructures");
%feature("rp:obj_include") %{
#include <ql/termstructures/yield/flatforward.hpp>
%}

namespace QuantLib {
    class FlatForward {
      public:
        FlatForward(const QuantLib::Date& referenceDate,
                    QuantLib::Rate forward,
                    const QuantLib::DayCounter& dayCounter);
    };
}

%feature("rp:group", "");

