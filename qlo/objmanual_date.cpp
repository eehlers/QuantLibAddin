
#include <qlo/objmanual_date.hpp>
#include <ql/settings.hpp>

QuantLib::Period QuantLibAddin::periodFromFrequency(QuantLib::Frequency f) {
    return QuantLib::Period(f);
}

QuantLib::Frequency QuantLibAddin::frequencyFromPeriod(const QuantLib::Period& p) {
    return p.frequency();
}

QuantLib::Period QuantLibAddin::periodEquivalent(const QuantLib::Period& p) {
    return p;
}

std::vector<QuantLib::Date> QuantLibAddin::IMMNextDates(const QuantLib::Date& date,
                            const std::vector<bool>& mainCycle) {
    QL_REQUIRE(!mainCycle.empty(), "Main cycle flags vector is empty.");
    QuantLib::Date d = (date == QuantLib::Date() ?
              QuantLib::Date(QuantLib::Settings::instance().evaluationDate()) :
              date);
              std::vector<QuantLib::Date> out(1, QuantLib::IMM::nextDate(d, mainCycle[0]));

    QuantLib::Size n = mainCycle.size();
    out.reserve(n);
    for (QuantLib::Size i=1; i<n; ++i)
        out.push_back(QuantLib::IMM::nextDate(out[i-1]+1*QuantLib::Days, mainCycle[i]));
    return out;
}

std::vector<std::string> QuantLibAddin::IMMNextCodes(const QuantLib::Date& date,
                              const std::vector<bool>& mainCycle) {
    std::vector<QuantLib::Date> immDates = IMMNextDates(date, mainCycle);
    std::vector<std::string> out;
    QuantLib::Size n = mainCycle.size();
    out.reserve(n);
    for (QuantLib::Size i=0; i<n; ++i)
        out.push_back(QuantLib::IMM::code(immDates[i]));
    return out;
}

std::vector<QuantLib::Date> QuantLibAddin::ASXNextDates(const QuantLib::Date& date,
                            const std::vector<bool>& mainCycle) {
    QL_REQUIRE(!mainCycle.empty(), "Main cycle flags vector is empty.");
    QuantLib::Date d = (date == QuantLib::Date() ?
              QuantLib::Date(QuantLib::Settings::instance().evaluationDate()) :
              date);
    std::vector<QuantLib::Date> out(1, QuantLib::ASX::nextDate(d, mainCycle[0]));

    QuantLib::Size n = mainCycle.size();
    out.reserve(n);
    for (QuantLib::Size i = 1; i<n; ++i)
        out.push_back(QuantLib::ASX::nextDate(out[i - 1] + 1 * QuantLib::Days, mainCycle[i]));
    return out;
}

std::vector<std::string> QuantLibAddin::ASXNextCodes(const QuantLib::Date& date,
                              const std::vector<bool>& mainCycle) {
    std::vector<QuantLib::Date> asxDates = ASXNextDates(date, mainCycle);
    std::vector<std::string> out;
    QuantLib::Size n = mainCycle.size();
    out.reserve(n);
    for (QuantLib::Size i = 0; i<n; ++i)
        out.push_back(QuantLib::ASX::code(asxDates[i]));
    return out;
}

std::vector<QuantLib::Date> QuantLibAddin::ECBKnownDates() {
    return std::vector<QuantLib::Date>(QuantLib::ECB::knownDates().begin(),
                        QuantLib::ECB::knownDates().end());
}
