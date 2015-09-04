
#ifndef obj_utilities_hpp
#define obj_utilities_hpp

#include <string>
#include <rp/libraryobject.hpp>
#include <rp/valueobject.hpp>
#include <boost/shared_ptr.hpp>
#include <ql/time/date.hpp>

namespace QuantLibAddin {

    // BEGIN typemap rp_tm_obj_ret std::string
    std::string
    // END   typemap rp_tm_obj_ret
    version(
        // BEGIN typemap rp_tm_default
        // END   typemap rp_tm_default
    );

    // quick fix for =countify
    long ObjectCount();
} // namespace QuantLibAddin

#endif

