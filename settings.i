
%feature("rp:group", "settings");
%feature("rp:generation", "manual");

namespace QuantLibAddin {
    void settingsSetEvaluationDate(const QuantLib::Date& evalDate);
    std::string dateToString(const QuantLib::Date& d);
}

