
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
        //! Returns the calendar used by the given TermStructure object.
        Calendar calendar();
        //! Returns the DayCounter used by the given TermStructure object.
        DayCounter dayCounter();
        //! Returns the number of settlement days for the given TermStructure object.
        Natural settlementDays();
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
        %alias(forwardRate, YieldTSForwardRate);
        %loop(forwardRate, d2);
        //! Returns the forward interest rate from the given YieldTermStructure object.
        InterestRate forwardRate(const Date& d1,                        //!< first date.
                                 const Date& d2,                        //!< second date.
                                 const DayCounter& resultDayCounter,    //!< result DayCounter.
                                 Compounding comp,                      //!< Interest rate compounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
                                 Frequency freq = Annual,               //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
                                 bool extrapolate = false               //!< TRUE allows extrapolation.
        ) const;
        %alias(zeroRate, YieldTSZeroRate);
        %loop(zeroRate, d);
        //! Returns the zero interest rate from the given YieldTermStructure object.
        InterestRate zeroRate(const Date& d,                            //!< date.
                              const DayCounter& resultDayCounter,       //!< resultDayCounter.
                              Compounding comp,                         //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
                              Frequency freq = Annual,                  //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
                              bool extrapolate = false                  //!< TRUE allows extrapolation.
        ) const;
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

