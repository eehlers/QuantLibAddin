
%group(termstructures);

%insert(termstructures_library_hpp) %{
#include <ql/termstructures/yield/flatforward.hpp>
%}

%insert(termstructures_addin_cpp) %{
#include <qlo/objmanual_handles.hpp>
%}

namespace QuantLib {

    class Extrapolator {
      public:
        void enableExtrapolation(bool b);
    };

    class TermStructure : public Extrapolator {
      public:
        %generate(c++, referenceDate);
        %generate(countify, referenceDate);
        Date referenceDate();
        Date maxDate();
    };

    class YieldTermStructure : public TermStructure {
      public:
        %generate(c++, discount);
        %generate(countify, discount);
        %alias(discount, YieldTSDiscount);
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

