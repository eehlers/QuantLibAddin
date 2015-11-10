
#include <iostream>
#include <iomanip>
//#include "AddinCfy/init.hpp"

#include <oh/ohdefines.hpp>
#if defined BOOST_MSVC
#include <oh/auto_link.hpp>
#include <ql/auto_link.hpp>
#endif

//extern "C" {
//extern COUNTIFY_API const char *qlVersion();
//}

int main() {
    try {
        std::cout << "hi" << std::endl;
        //std::cout << qlVersion() << std::endl;
        //initializeAddin();
        std::cout << "bye" << std::endl;
    } catch (const std::exception &e) {
        std::cout << "error " << e.what() << std::endl;
    } catch (...) {
        std::cout << "error" << std::endl;
    }
    return 0;
}

