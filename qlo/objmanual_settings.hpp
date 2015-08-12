
#ifndef obj_settings_hpp
#define obj_settings_hpp

#include <string>
#include <oh/libraryobject.hpp>
#include <oh/valueobject.hpp>
#include <boost/shared_ptr.hpp>
#include <ql/time/date.hpp>

namespace QuantLibAddin {

    // BEGIN typemap rp_tm_obj_ret long
    long
    // END   typemap rp_tm_obj_ret
    settingsEvaluationDate(
        // BEGIN typemap rp_tm_default
        // END   typemap rp_tm_default
    );

    // BEGIN typemap rp_tm_obj_ret void
    void
    // END   typemap rp_tm_obj_ret
    settingsSetEvaluationDate(
        // BEGIN typemap rp_tm_default
        QuantLib::Date const &evalDate
        // END   typemap rp_tm_default
    );

    // BEGIN typemap rp_tm_obj_ret std::string
    std::string
    // END   typemap rp_tm_obj_ret
    dateToString(
        // BEGIN typemap rp_tm_default
        QuantLib::Date const &d
        // END   typemap rp_tm_default
    );
} // namespace QuantLibAddin

#endif

