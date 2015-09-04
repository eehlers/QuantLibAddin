
#include <qlo/init.hpp>
//#include <rp/repository.hpp>
//#include <rp/processor.hpp>
//#include <rp/enumerations/enumregistry.hpp>
#include <qlo/enumerations/register/register_all.hpp>
//#include <qlo/serialization/serializationfactory.hpp>

void QuantLibAddin::initializeAddin() {

        // Initialize the Enumeration Registry
        registerEnumerations();
}

void QuantLibAddin::closeAddin() {

        // Clear the Enumeration Registry
        unregisterEnumerations();
}

