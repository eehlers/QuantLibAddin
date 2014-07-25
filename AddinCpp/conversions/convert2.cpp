
#include "convert2.hpp"

namespace ObjectHandler {
    template<> 
    QuantLib::Date convert2<QuantLib::Date, property_t>(const property_t& c) {
        return convertDate(c);
    }
}

