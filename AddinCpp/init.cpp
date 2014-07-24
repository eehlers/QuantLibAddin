
#include "init.hpp"
#include <oh/repository.hpp>
#include <oh/processor.hpp>
#include <oh/enumerations/enumregistry.hpp>
//#include <qlo/enumerations/register/register_all.hpp>
//#include <qlo/serialization/serializationfactory.hpp>
#include "qlo/init.hpp"

void QuantLibAddinCpp::initializeAddin() {

        // Instantiate the ObjectHandler Repository
        static ObjectHandler::Repository repository;

        //Instantiate the Processor Factory
        //static ObjectHandler::ProcessorFactory processorFactory;

        // Instantiate the Serialization Factory
        //static QuantLibAddin::SerializationFactory factory;

        // Instantiate the Enumerated Type Registry
        static ObjectHandler::EnumTypeRegistry enumTypeRegistry;

        // Instantiate the Enumerated Class Registry
        static ObjectHandler::EnumClassRegistry enumClassRegistry;

        // Instantiate the Enumerated Pair Registry
        static ObjectHandler::EnumPairRegistry enumPairRegistry;

        // Initialize the Enumeration Registry
        QuantLibAddin::initializeAddin();
}

