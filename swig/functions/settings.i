
%group(Settings);

%insert(obj_hpp) %{
#include <ql/time/date.hpp>
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_settings.hpp>
%}

namespace QuantLibAddin {

    //! Returns the current value of the Evaluation Date.
    QuantLib::Date settingsEvaluationDate();

    //! Sets the value of the Evaluation Date.
    void settingsSetEvaluationDate(
        const QuantLib::Date& evalDate  //!< new value for the evaluation date. If a null date is provided the current date wiil be used and midnight date change will be detected.
    );

    //! Returns the current value of the boolean which enforce the usage of historic fixings for today's date.
    bool settingsEnforceTodaysHistoricFixings();

    //! Sets the value of the boolean which enforce the usage of historic fixings for today's date.
    void settingsSetEnforceTodaysHistoricFixings(
        bool Boolean=true               //!< New value for the boolean which enforce the usage of historic fixings for today's date.
    );
}

