
#ifndef addincfy_utils_hpp
#define addincfy_utils_hpp

#include <vector>
#include "FlyLib/FlyLib_Types.h"
#include "FlyLib/FlyLib_Multi.h"
#include <rp/property.hpp>

namespace QuantLib {
class Date;
class Period;
};

std::vector<bool> f6(FLYLIB_OPAQUE);
std::vector<long> f2(FLYLIB_OPAQUE);
std::vector<double> f1(FLYLIB_OPAQUE);
std::vector<std::string> f4(FLYLIB_OPAQUE);
std::vector<reposit::property_t> f3(FLYLIB_OPAQUE);
std::vector<QuantLib::Date> f5(FLYLIB_OPAQUE);
std::vector<QuantLib::Period> f7(FLYLIB_OPAQUE);
FlyLib_Multi *f8(const std::vector<QuantLib::Date> &v);
FlyLib_Multi *f9(const std::vector<std::string> &v);
//void debug_flylib(FlyLib_Multi * _in_params);

#endif

