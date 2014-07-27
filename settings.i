
%feature("rp:group", "settings");
%feature("rp:generation", "manual");

namespace QuantLibAddin {
    long settingsSetEvaluationDate(const QuantLib::Date& evalDate);
    std::string dateToString(const QuantLib::Date& d);
}

