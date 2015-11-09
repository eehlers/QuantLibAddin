
#ifndef addincfy_utils_hpp
#define addincfy_utils_hpp

#include <vector>
#include "FlyLib/FlyLib_Types.h"
#include <rp/property.hpp>

namespace QuantLib {
class Date;
};

std::vector<bool> f6(FLYLIB_OPAQUE);
std::vector<long> f2(FLYLIB_OPAQUE);
std::vector<double> f1(FLYLIB_OPAQUE);
std::vector<std::string> f4(FLYLIB_OPAQUE);
std::vector<reposit::property_t> f3(FLYLIB_OPAQUE);
std::vector<QuantLib::Date> f5(FLYLIB_OPAQUE);

#endif

