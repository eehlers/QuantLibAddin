
/*  
 Copyright (C) 2006, 2007, 2008, 2014 Ferdinando Ametrano
 Copyright (C) 2005, 2006, 2007, 2014 Eric Ehlers
 Copyright (C) 2007 Marco Bianchetti
 Copyright (C) 2006 Giorgio Facchinetti
 Copyright (C) 2006 Chiara Fornarola
 Copyright (C) 2006 Katiuscia Manzoni
 Copyright (C) 2005 Plamen Neykov
 
 This file is part of QuantLib, a free-software/open-source library
 for financial quantitative analysts and developers - http://quantlib.org/

 QuantLib is free software: you can redistribute it and/or modify it
 under the terms of the QuantLib license.  You should have received a
 copy of the license along with this program; if not, please email
 <quantlib-dev@lists.sf.net>. The license is also available online at
 <http://quantlib.org/license.shtml>.

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
*/

//#if defined(HAVE_CONFIG_H)     // Dynamically created by configure
//    #include <qlo/config.hpp>
//#endif
//
//#include <qlo/qladdindefines.hpp>
//
#include <ql/time/daycounters/all.hpp>
//#include <ql/default.hpp> // RL ADD 2010-07-15

#include <oh/enumerations/typefactory.hpp>
#include <qlo/enumerations/register/register_types.hpp>

namespace QuantLibAddin {

    void registerTypesDayCounters() {
    
        ObjectHandler::Create<QuantLib::DayCounter> create;
        create.registerType("1/1", new QuantLib::OneDayCounter());
        create.registerType("30/360", new QuantLib::Thirty360(QuantLib::Thirty360::BondBasis));
        create.registerType("30/360 (Bond Basis)", new QuantLib::Thirty360(QuantLib::Thirty360::BondBasis));
        create.registerType("30/360 (Eurobond Basis)", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
        create.registerType("30/360 (Italian)", new QuantLib::Thirty360(QuantLib::Thirty360::Italian));
        create.registerType("30E/360", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
        create.registerType("30E/360 (Eurobond Basis)", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
        create.registerType("360/360", new QuantLib::Thirty360(QuantLib::Thirty360::BondBasis));
        create.registerType("A/360", new QuantLib::Actual360());
        create.registerType("A/365", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
        create.registerType("A/365 (Fixed)", new QuantLib::Actual365Fixed());
        create.registerType("A/365F", new QuantLib::Actual365Fixed());
        create.registerType("Act/360", new QuantLib::Actual360());
        create.registerType("Act/365", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
        create.registerType("Act/365 (Fixed)", new QuantLib::Actual365Fixed());
        create.registerType("Act/365 (NL)", new QuantLib::Actual365NoLeap());
        create.registerType("Act/Act", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
        create.registerType("Actual/360", new QuantLib::Actual360());
        create.registerType("Actual/365", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
        create.registerType("Actual/365 (Fixed)", new QuantLib::Actual365Fixed());
        create.registerType("Actual/365 (JGB)", new QuantLib::Actual365NoLeap());
        create.registerType("Actual/365 (No Leap)", new QuantLib::Actual365NoLeap());
        create.registerType("Actual/Actual", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
        create.registerType("Actual/Actual (AFB)", new QuantLib::ActualActual(QuantLib::ActualActual::AFB));
        create.registerType("Actual/Actual (Bond)", new QuantLib::ActualActual(QuantLib::ActualActual::ISMA));
        create.registerType("Actual/Actual (Euro)", new QuantLib::ActualActual(QuantLib::ActualActual::AFB));
        create.registerType("Actual/Actual (ISDA)", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
        create.registerType("Actual/Actual (ISMA)", new QuantLib::ActualActual(QuantLib::ActualActual::ISMA));
        create.registerType("Bond Basis", new QuantLib::Thirty360(QuantLib::Thirty360::BondBasis));
        create.registerType("Business252", new QuantLib::Business252());
        create.registerType("DayCounter", new QuantLib::DayCounter());
        create.registerType("Eurobond Basis", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
        create.registerType("LIN 30/360", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
        create.registerType("LIN ACT/360", new QuantLib::Actual360());
        create.registerType("LIN ACT/365", new QuantLib::Actual365Fixed());
        create.registerType("LIN ACT/ACT", new QuantLib::ActualActual(QuantLib::ActualActual::AFB));
        create.registerType("LIN ACTACT ISDA", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
        create.registerType("LIN ACTACT ISMA", new QuantLib::ActualActual(QuantLib::ActualActual::ISMA));
        create.registerType("NL/365", new QuantLib::Actual365NoLeap());
        create.registerType("NoDayCounter", new QuantLib::DayCounter());
        create.registerType("Simple", new QuantLib::SimpleDayCounter());
    }

    void unregisterTypesDayCounters() {
    
        ObjectHandler::Create<QuantLib::DayCounter>().unregisterTypes();
    }

}

