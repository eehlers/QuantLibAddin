
%feature("rp:group", "settings");

namespace QuantLibAddin {
    void settingsSetEvaluationDate(const QuantLib::Date& evalDate);
    std::string dateToString(const QuantLib::Date& d);
}

