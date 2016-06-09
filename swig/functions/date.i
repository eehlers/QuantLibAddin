
%group(date);
%override;

//DELETEME
%insert(date_addin_cpp) %{
#include "qlo/objmanual_date.hpp"
%}

namespace QuantLibAddin {

    QuantLib::Period periodEquivalent(const QuantLib::Period& p);

    %generate(countify, IMMNextDates);
    std::vector<QuantLib::Date> IMMNextDates(
        const QuantLib::Date& d,
        const std::vector<bool>& mainCycle);

    %generate(countify, IMMNextCodes);
    std::vector<std::string> IMMNextCodes(
        const QuantLib::Date& RefDate,
        const std::vector<bool>& mainCycle);

    std::vector<QuantLib::Date> ASXNextDates(
        const QuantLib::Date& d,
        const std::vector<bool>& mainCycle);

    std::vector<std::string> ASXNextCodes(
        const QuantLib::Date& d,
        const std::vector<bool>& mainCycle);

    std::vector<QuantLib::Date> ECBKnownDates();
}

namespace QuantLib {

    class Date {
    public:
        static bool isEndOfMonth(const Date& d);
    };

    struct IMM {
        //%generate(countify, date);
        %loop(date, immCode);
        static Date date(
            const std::string& immCode,
            const Date& referenceDate);

        %generate(countify, code);
        %loop(code, immDate);
        static std::string code(const Date& immDate);

        %generate(countify, nextCode);
        static std::string nextCode(
            const Date& d,
            bool mainCycle);
    };

    struct ECB {
        %generate(countify, date);
        static Date date(
            const std::string& ecbCode,
            const Date& referenceDate);

        %generate(countify, code);
        static std::string code(const Date& ecbDate);

        %generate(countify, nextDate);
        static Date nextDate(const Date& d);

        %generate(countify, nextCode);
        static std::string nextCode(const Date& d);
    };
}
