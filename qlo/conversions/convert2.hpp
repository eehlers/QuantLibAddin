
#ifndef qlo_convert2_hpp
#define qlo_convert2_hpp

#include <oh/property.hpp>
#include <oh/conversions/convert2.hpp>

#include <ql/time/date.hpp>
#include <ql/time/period.hpp>

// QuantLibAddin-specific specializations of templates in the ObjectHandler convert2.hpp file.

namespace ObjectHandler {

    template<> 
    QuantLib::Date convert2<QuantLib::Date, property_t>(const property_t& c);   
}

QuantLib::Period f(const std::string &p_inp);

#endif

