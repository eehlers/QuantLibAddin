
#include "init.hpp"
#include <rp/repository.hpp>
#include <rp/processor.hpp>
#include <rp/enumerations/enumregistry.hpp>
//#include <qlo/enumerations/register/register_all.hpp>
//#include <qlo/serialization/serializationfactory.hpp>
#include "qlo/init.hpp"

void QuantLibAddinCpp::initializeAddin() {

        // Instantiate the reposit Repository
        static reposit::Repository repository;

        //Instantiate the Processor Factory
        //static reposit::ProcessorFactory processorFactory;

        // Instantiate the Serialization Factory
        //static QuantLibAddin::SerializationFactory factory;

        // Instantiate the Enumerated Type Registry
        static reposit::EnumTypeRegistry enumTypeRegistry;

        // Instantiate the Enumerated Class Registry
        static reposit::EnumClassRegistry enumClassRegistry;

        // Instantiate the Enumerated Pair Registry
        static reposit::EnumPairRegistry enumPairRegistry;

        // Initialize the Enumeration Registry
        QuantLibAddin::initializeAddin();
}

