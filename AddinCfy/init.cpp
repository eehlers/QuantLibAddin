
#include "init.hpp"
#include <oh/repository.hpp>
#include <oh/processor.hpp>
#include <oh/enumerations/enumregistry.hpp>
#include <qlo/enumerations/register/register_all.hpp>
#include <qlo/serialization/serializationfactory.hpp>
#include <qlo/init.hpp>
#include <qlo/objmanual_settings.hpp>
#include <iostream>

void initializeAddin() {

    static bool initializationDone = false;

    if (initializationDone)
        return;

    try {

        RP_LOG_MESSAGE("initializeAddin", "begin intialization...\n");

        // Instantiate the ObjectHandler Repository
        static ObjectHandler::Repository repository;

        //Instantiate the Processor Factory
        static ObjectHandler::ProcessorFactory processorFactory;

        // Instantiate the Serialization Factory
        static QuantLibAddin::SerializationFactory factory;

        // Instantiate the Enumerated Type Registry
        static ObjectHandler::EnumTypeRegistry enumTypeRegistry;

        // Instantiate the Enumerated Class Registry
        static ObjectHandler::EnumClassRegistry enumClassRegistry;

        // Instantiate the Enumerated Pair Registry
        static ObjectHandler::EnumPairRegistry enumPairRegistry;

        // Initialize the Enumeration Registry
        QuantLibAddin::initializeAddin();

        // Set the evaluation date
        QuantLibAddin::settingsSetEvaluationDate(QuantLib::Date(12, QuantLib::May, 2015));

        // load the euro market
        QuantLibAddin::SerializationFactory::instance().loadObject(
                "/home/countify/", "data2.xml", false, true);

        RP_LOG_MESSAGE("initializeAddin", "initialization done.\n");
        initializationDone = true;
    } catch (const std::exception &e) {
        RP_LOG_MESSAGE("initializeAddin", "ERROR - " << e.what());
    } catch (...) {
        RP_LOG_MESSAGE("initializeAddin", "UNKNOWN ERROR");
    }
}

