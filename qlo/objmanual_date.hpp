
#ifndef obj_date_hpp
#define obj_date_hpp

#include <string>
#include <vector>
#include <rp/libraryobject.hpp>
#include <rp/valueobject.hpp>
#include <boost/shared_ptr.hpp>
#include <ql/time/date.hpp>
#include <ql/time/frequency.hpp>
#include <ql/time/imm.hpp>
#include <ql/time/ecb.hpp>
#include <ql/time/asx.hpp>

namespace QuantLib {
    class Period;
}

namespace QuantLibAddin {

    // to be removed using coercion
    QuantLib::Period periodFromFrequency(QuantLib::Frequency f);

    // to be removed using coercion
    QuantLib::Frequency frequencyFromPeriod(const QuantLib::Period& p);

    // it is not a dummy function!
    // e.g. it returns "11M" when the input is "1Y-1M"
    QuantLib::Period periodEquivalent(const QuantLib::Period& p);

    std::vector<QuantLib::Date> IMMNextDates(const QuantLib::Date& d,
                                               const std::vector<bool>& mainCycle);

    std::vector<std::string> IMMNextCodes(const QuantLib::Date& d,
                                            const std::vector<bool>& mainCycle);
    std::vector<QuantLib::Date> ASXNextDates(const QuantLib::Date& d,
                                               const std::vector<bool>& mainCycle);

    std::vector<std::string> ASXNextCodes(const QuantLib::Date& d,
                                            const std::vector<bool>& mainCycle);
    std::vector<QuantLib::Date> ECBKnownDates();

} // namespace QuantLibAddin


#endif

