
%group(settings);
%groupCaption(Settings);

%insert(settings_library_hpp) %{
#include <ql/time/date.hpp>
%}

%insert(settings_addin_cpp) %{
#include <qlo/objects/obj_settings.hpp>
%}

namespace QuantLibAddin {

    //! returns the current value of the Evaluation Date.
    long settingsEvaluationDate();

    //! sets the value of the Evaluation Date.
    void settingsSetEvaluationDate(
        const QuantLib::Date& evalDate                      //!< new value for the evaluation date. If a null date is provided the current date wiil be used and midnight date change will be detected.
    );

    //std::string dateToString(const QuantLib::Date& d);
}

