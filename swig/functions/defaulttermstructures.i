
%group(defaulttermstructures);
%groupCaption(Default Termstructures);

%override;

//%insert(defaulttermstructures_addin_cpp) %{
//#include <qlo/conversions/coercetermstructure.hpp>
//%}

namespace QuantLibAddin {

    //! Turns a given probability into a flat hazard rate.
    QuantLib::Real probabilityToHazardRate(
        QuantLib::Probability Probability,                                  //!< Probability.
        const QuantLib::Date& Date,                                         //!< Date of the probability given.
        const QuantLib::DayCounter& DayCounter=QuantLib::Actual365Fixed()   //!< DayCounter ID.
    );    
}

namespace QuantLib {

    class RelinkableHandleDefaultProbabilityTermStructure {
    public:
        %processor(RelinkableHandleDefaultProbabilityTermStructure, RelinkableHandleProcessor);
        RelinkableHandleDefaultProbabilityTermStructure(
            const std::string &CurrentLink                                  //!< DefaultProbabilityTermStructure object ID. If omitted, nothing is linked by the RelinkableHandle.
        );
    };

    class DefaultProbabilityTermStructure {
    public:
        %loop(defaultProbability, Dates);
        %rename2(defaultProbability, DefaultTSDefaultProbability);
        //! Returns the probability of default between the reference date and the given date from the given DefaultProbabilityTermStructure object.
        Probability defaultProbability(
            const Date& Dates,                                              //!< vector of dates.
            bool AllowExtrapolation=false                                   //!< TRUE allows extrapolation.
        ) const;
    };

    class FlatHazardRate {
        FlatHazardRate(
            Natural NDays/*=0*/,                                            //!< number of days to advance from EvaluationDate (usually zero or two): it fixes the date at which the discount factor = 1.0.
            const Calendar& Calendar/*=NullCalendar*/,                      //!< holiday calendar (e.g. TARGET) to advance from global EvaluationDate.
            const Handle<Quote>& Rate,                                      //!< the curve level.
            const DayCounter& DayCounter=Actual365Fixed                     //!< DayCounter ID.
        );
    };
}
