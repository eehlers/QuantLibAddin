
#include <qlo/init.hpp>
//#include <oh/repository.hpp>
//#include <oh/processor.hpp>
//#include <oh/enumerations/enumregistry.hpp>
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

