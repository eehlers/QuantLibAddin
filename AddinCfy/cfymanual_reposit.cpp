
// BEGIN buffer b_cfy_grp_cpp


#include "init.hpp"
#include <rp/repository.hpp>

//FIXME this #include is only required if the file contains conversions
#include <qlo/conversions/all.hpp>
#include <qlo/conversions/coercetermstructure.hpp>
// FIXME only required if the file contains a looping function
#include "loop.hpp"
#include "qlo/loop.hpp"
#include "qlo/objmanual_utilities.hpp"

#include <qlo/objmanual_utilities.hpp>

//FIXME include only factories for types used in the current file
#include "qlo/enumerations/factories/all.hpp"
#include <boost/shared_ptr.hpp>
#include <rp/repository.hpp>

extern "C" {
COUNTIFY_API
long
qlTrigger(
        const char * dummy0,
        const char * dummy1,
        const char * dummy2,
        const char * dummy3,
        const char * dummy4,
        const char * dummy5,
        const char * dummy6,
        const char * dummy7,
        const char * dummy8,
        const char * dummy9
) {

    try {

        CFY_LOG_MESSAGE("qlTrigger", "Begin function");

//        initializeAddin();
        // TODO : Verify that none of the inputs has an error
        // value e.g. #NA (ExcelErrorNA?), #REF, etc.

        static long ret = 0;

        CFY_LOG_MESSAGE("qlTrigger", "End function");

        return ret++;

    } catch (const std::exception &e) {
        CFY_LOG_MESSAGE("qlTrigger", "ERROR - " << e.what());
        // BEGIN typemap rp_tm_cfy_rtex std::string
        return 0;
        // END   typemap rp_tm_cfy_rtex
    } catch (...) {
        CFY_LOG_MESSAGE("qlTrigger", "ERROR - UNKNOWN EXCEPTION");
        // BEGIN typemap rp_tm_cfy_rtex std::string
        return 0;
        // END   typemap rp_tm_cfy_rtex
    }
}
} // extern "C"

