
%group(settings);
%override;

namespace QuantLibAddin {

    %generate(c++, settingsEvaluationDate);
    %generate(countify, settingsEvaluationDate);
    long settingsEvaluationDate();

    %generate(c++, settingsSetEvaluationDate);
    %generate(c#, settingsSetEvaluationDate);
    void settingsSetEvaluationDate(const QuantLib::Date& evalDate);

    std::string dateToString(const QuantLib::Date& d);
}

