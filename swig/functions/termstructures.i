
%group(termstructures);
%groupCaption(Term Structures);

%insert(termstructures_library_hpp) %{
#include <ql/termstructures/yield/flatforward.hpp>
%}

%insert(termstructures_addin_cpp) %{
#include <qlo/objmanual_handles.hpp>
%}

namespace QuantLib {

    class Extrapolator {
      public:
        //! Sets the enable extrapolation flag to the given Extrapolator object.
        void enableExtrapolation(
            bool b      //!< global extrapolation flag.
        );
    };

    class TermStructure : public Extrapolator {
      public:
        %generate(c++, referenceDate);
        %generate(countify, referenceDate);
        //! Returns the reference date for the given TermStructure object.
        Date referenceDate();
        //! Returns the max date for the given TermStructure object.
        Date maxDate();
    };

    class YieldTermStructure : public TermStructure {
      public:
        %generate(c++, discount);
        %generate(countify, discount);
        // For purposes of backward compatibility we use the %alias directive to export this function twice,
        // once under its old name (qlYieldTSDiscount) and once under its new name (qlYieldTermStructureDiscount)
        %alias(discount, YieldTSDiscount);
        //! Returns a discount factor from the given YieldTermStructure object.
        DiscountFactor discount(
            const Date& d,      //!< vector of dates.
            bool extrapolate    //!< TRUE allows extrapolation.
        );
    };

    class FlatForward : public YieldTermStructure {
      public:
        %generate(c++, FlatForward);
        %generate(c#, FlatForward);
        %generate(countify, FlatForward);
        FlatForward(
            const Date& referenceDate,
            Rate forward,
            const DayCounter& dayCounter
        );
    };
}

