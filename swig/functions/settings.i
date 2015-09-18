
%group(settings);
%override

%feature("rp:generate_countify") QuantLibAddin::settingsEvaluationDate;
%feature("rp:generate_cpp") QuantLibAddin::settingsEvaluationDate;
%feature("rp:generate_cpp") QuantLibAddin::settingsSetEvaluationDate;

namespace QuantLibAddin {
    long settingsEvaluationDate();
    void settingsSetEvaluationDate(const QuantLib::Date& evalDate);
    std::string dateToString(const QuantLib::Date& d);
}

