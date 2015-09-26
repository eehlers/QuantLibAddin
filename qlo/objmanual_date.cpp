
#include <qlo/objmanual_date.hpp>
#include <ql/settings.hpp>
#include <ql/time/imm.hpp>
#include <ql/time/asx.hpp>
#include <ql/time/ecb.hpp>

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

/* All of the functions below are temporary workarounds for a glitch in SWIG.
   At present the reposit SWIG module is unable to wrap functions in the form:
   namespace QuantLib {
       struct Foo {
           static void f();
       };
    };
    SWIG autogenerates the identifier Foo_f where we want Foo::f.
    With Foo_f the underscore gets exported to the Excel function name.
    So as a temporary workaround we wrap the QuantLib functions
    with QuantLibAddin functions that have the name we want.
*/

QuantLib::Date QuantLibAddin::IMMdate(
    const std::string& immCode,
    const QuantLib::Date &referenceDate) {
    return QuantLib::IMM::date(immCode);
}

std::string QuantLibAddin::IMMcode(const QuantLib::Date& immDate) {
    return QuantLib::IMM::code(immDate);
}

std::string QuantLibAddin::IMMnextCode(
    const QuantLib::Date& RefDate,
    bool MainCycle) {
    return QuantLib::IMM::nextCode(RefDate, MainCycle);
}

std::string QuantLibAddin::ECBcode(const QuantLib::Date& ecbDate) {
    return QuantLib::ECB::code(ecbDate);
}

std::string QuantLibAddin::ECBnextCode(const QuantLib::Date& RefDate) {
    return QuantLib::ECB::nextCode(RefDate);
}

QuantLib::Date QuantLibAddin::ECBdate(
    const std::string& ecbCode,
    const QuantLib::Date& referenceDate) {
    return QuantLib::ECB::date(ecbCode, referenceDate);
}

QuantLib::Date QuantLibAddin::ECBnextDate(const QuantLib::Date& date) {
    return QuantLib::ECB::nextDate(date);
}

bool QuantLibAddin::dateIsEndOfMonth(const QuantLib::Date& d) {
    return QuantLib::Date::isEndOfMonth(d);
}
