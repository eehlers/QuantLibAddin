
// BEGIN buffer b_lib_grp_cpp

#include <qlo/objects/obj_optimization.hpp>

std::string QuantLibAddin::secondsToString(QuantLib::Real elapsed) {
    QuantLib::Integer seconds = static_cast<QuantLib::Integer>(elapsed);
    QuantLib::Integer hours = seconds/3600;
    seconds -= hours * 3600;
    QuantLib::Integer minutes = seconds/60;
    seconds -= minutes * 60;
    std::ostringstream out;
    out << hours << ":" << minutes << ":" << seconds;
    return out.str();
}
