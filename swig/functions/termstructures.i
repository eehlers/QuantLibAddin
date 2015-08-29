
%feature("rp:group", "termstructures");
%feature("rp:obj_include") %{
#include <ql/termstructures/yield/flatforward.hpp>
%}

%feature("rp:generate_countify") QuantLib::FlatForward::FlatForward;
%feature("rp:generate_countify") QuantLib::TermStructure::referenceDate;
%feature("rp:generate_countify") QuantLib::YieldTermStructure::discount;

namespace QuantLib {

    class Extrapolator {};
    
    class TermStructure : public Extrapolator {
      public:
        QuantLib::Date referenceDate();
    };
    
    class YieldTermStructure : public TermStructure {
      public:
        QuantLib::DiscountFactor discount(
            const QuantLib::Date& d,
            bool extrapolate);
    };
    
    class FlatForward : public YieldTermStructure {
      public:
        FlatForward(const QuantLib::Date& referenceDate,
                    QuantLib::Rate forward,
                    const QuantLib::DayCounter& dayCounter);
    };
}

%feature("rp:obj_include", "");
%feature("rp:group", "");

