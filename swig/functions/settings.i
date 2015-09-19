
%group(settings);
%override

namespace QuantLibAddin {
    %generate(cpp, settingsEvaluationDate);
    %generate(countify, settingsEvaluationDate);
    long settingsEvaluationDate();
    %generate(cpp, settingsSetEvaluationDate);
    void settingsSetEvaluationDate(const QuantLib::Date& evalDate);
    std::string dateToString(const QuantLib::Date& d);
}

