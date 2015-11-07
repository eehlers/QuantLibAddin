
#include "init.hpp"
#include <rp/repository.hpp>
#include <rp/processor.hpp>
#include <rp/enumerations/enumregistry.hpp>
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

        CFY_LOG_MESSAGE("initializeAddin", "begin intialization...\n");

        // Instantiate the reposit Repository
        static reposit::Repository repository;

        //Instantiate the Processor Factory
        static reposit::ProcessorFactory processorFactory;

        // Instantiate the Serialization Factory
        static QuantLibAddin::SerializationFactory factory;

        // Instantiate the Enumerated Type Registry
        static reposit::EnumTypeRegistry enumTypeRegistry;

        // Instantiate the Enumerated Class Registry
        static reposit::EnumClassRegistry enumClassRegistry;

        // Instantiate the Enumerated Pair Registry
        static reposit::EnumPairRegistry enumPairRegistry;

        // Initialize the Enumeration Registry
        QuantLibAddin::initializeAddin();

//        // Set the evaluation date
//        QuantLibAddin::settingsSetEvaluationDate(QuantLib::Date(12, QuantLib::May, 2015));
//
//        // load the euro market
//        QuantLibAddin::SerializationFactory::instance().loadObject(
//                "/home/countify/", "data2.xml", false, true);

        CFY_LOG_MESSAGE("initializeAddin", "initialization done.\n");
        initializationDone = true;
    } catch (const std::exception &e) {
        CFY_LOG_MESSAGE("initializeAddin", "ERROR - " << e.what());
    } catch (...) {
        CFY_LOG_MESSAGE("initializeAddin", "UNKNOWN ERROR");
    }
}

