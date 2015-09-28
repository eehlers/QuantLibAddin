
%group(termstructures);

%insert(termstructures_library_hpp) %{
#include <ql/termstructures/yield/flatforward.hpp>
%}

namespace QuantLib {

    class Extrapolator {};

    class TermStructure : public Extrapolator {
      public:
        %generate(c++, referenceDate);
        %generate(countify, referenceDate);
        Date referenceDate();
    };

    class YieldTermStructure : public TermStructure {
      public:
        %generate(c++, discount);
        %generate(countify, discount);
        DiscountFactor discount(
            const Date& d,
            bool extrapolate);
    };

    class FlatForward : public YieldTermStructure {
      public:
        %generate(c++, FlatForward);
        %generate(c#, FlatForward);
        %generate(countify, FlatForward);
        FlatForward(const Date& referenceDate,
                    Rate forward,
                    const DayCounter& dayCounter);
    };
}

