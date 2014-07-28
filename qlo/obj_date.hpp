
#ifndef obj_date_hpp
#define obj_date_hpp

#include <string>
#include <oh/libraryobject.hpp>
#include <oh/valueobject.hpp>
#include <boost/shared_ptr.hpp>
#include <ql/time/date.hpp>

namespace QuantLibAddin {

    bool dateIsEndOfMonth(const QuantLib::Date& d);

} // namespace QuantLibAddin

#endif

