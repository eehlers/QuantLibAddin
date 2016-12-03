
%group(Default Termstructures);

%insert(obj_hpp) %{
#include <qlo/objects/obj_termstructures.hpp>
#include <ql/types.hpp>
#include <ql/time/businessdayconvention.hpp>

namespace QuantLib {
    class DefaultProbabilityTermStructure;

    class Calendar;
    class DayCounter;
    class Period;
    class Quote;
    class Date;

    template <class T>
    class Handle;
}
%}

%insert(obj_cpp) %{
#include <ql/termstructures/credit/flathazardrate.hpp>
%}

//%insert(defaulttermstructures_addin_cpp) %{
//#include <qlo/conversions/coercetermstructure.hpp>
//%}

namespace QuantLibAddin {

    //! Turns a given probability into a flat hazard rate.
    QuantLib::Real probabilityToHR(
        QuantLib::Probability Probability,                                  //!< Probability.
        const QuantLib::Date& Date,                                         //!< Date of the probability given.
        const QuantLib::DayCounter& DayCounter=QuantLib::Actual365Fixed()   //!< DayCounter ID.
    );    
}

namespace QuantLib {

    class DefaultProbabilityTermStructure : public TermStructure {
      public:

        %loop(defaultProbability, Dates);
        %rename2(defaultProbability, DefaultTSDefaultProbability);
        //! Returns the probability of default between the reference date and the given date from the given DefaultProbabilityTermStructure object.
        Probability defaultProbability(
            const Date& Dates,                                              //!< Vector of dates.
            bool AllowExtrapolation=false                                   //!< TRUE allows extrapolation.
        ) const;
    };
    
    class HazardRateStructure : public DefaultProbabilityTermStructure {};

    class FlatHazardRate : public HazardRateStructure {
      public:

        FlatHazardRate(
            Natural NDays/*=0*/,                                            //!< Number of days to advance from EvaluationDate (usually zero or two): it fixes the date at which the discount factor = 1.0.
            const Calendar& Calendar/*=NullCalendar*/,                      //!< Holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const Handle<Quote>& Rate,                                      //!< The curve level.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed()         //!< DayCounter ID.
        );
    };
}
