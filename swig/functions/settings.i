
%feature("rp:group", "settings");

%feature("rp:override_obj");
%feature("rp:generate_countify") QuantLibAddin::settingsEvaluationDate;
%feature("rp:generate_cpp") QuantLibAddin::settingsEvaluationDate;
%feature("rp:generate_cpp") QuantLibAddin::settingsSetEvaluationDate;

namespace QuantLibAddin {
    long settingsEvaluationDate();
    void settingsSetEvaluationDate(const QuantLib::Date& evalDate);
    std::string dateToString(const QuantLib::Date& d);
}

%feature("rp:override_obj", "");
%feature("rp:group", "");

