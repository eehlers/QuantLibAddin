
%group(termstructures);

%insert(termstructures_library_hpp) %{
#include <ql/termstructures/yield/flatforward.hpp>
%}

namespace QuantLib {

    class Extrapolator {};

    class TermStructure : public Extrapolator {
      public:
        %generate(cpp, referenceDate);
        %generate(countify, referenceDate);
        Date referenceDate();
    };

    class YieldTermStructure : public TermStructure {
      public:
        %generate(cpp, discount);
        %generate(countify, discount);
        DiscountFactor discount(
            const Date& d,
            bool extrapolate);
    };

    class FlatForward : public YieldTermStructure {
      public:
        %generate(cpp, FlatForward);
        %generate(countify, FlatForward);
        FlatForward(const Date& referenceDate,
                    Rate forward,
                    const DayCounter& dayCounter);
    };
}

