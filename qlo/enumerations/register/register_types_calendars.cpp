
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

#include <ql/time/calendars/all.hpp>

#include <oh/enumerations/typefactory.hpp>
#include <qlo/enumerations/register/register_types.hpp>

void QuantLibAddin::registerTypesCalendars() {

    ObjectHandler::Create<QuantLib::Calendar> create;
    create.registerType("Argentina::Merval", new QuantLib::Argentina(QuantLib::Argentina::Merval));
    create.registerType("Australia", new QuantLib::Australia());
    create.registerType("BOVESPA", new QuantLib::Brazil(QuantLib::Brazil::Exchange));
    create.registerType("Bratislava stock exchange", new QuantLib::Slovakia(QuantLib::Slovakia::BSSE));
    create.registerType("Brazil", new QuantLib::Brazil(QuantLib::Brazil::Settlement));
    create.registerType("Brazil::Exchange", new QuantLib::Brazil(QuantLib::Brazil::Exchange));
    create.registerType("Brazil::Settlement", new QuantLib::Brazil(QuantLib::Brazil::Settlement));
    create.registerType("Buenos Aires stock exchange", new QuantLib::Argentina(QuantLib::Argentina::Merval));
    create.registerType("Calendar", new QuantLib::Calendar());
    create.registerType("Canada", new QuantLib::Canada(QuantLib::Canada::Settlement));
    create.registerType("Canada::Settlement", new QuantLib::Canada(QuantLib::Canada::Settlement));
    create.registerType("Canada::TSX", new QuantLib::Canada(QuantLib::Canada::TSX));
    create.registerType("China", new QuantLib::China());
    create.registerType("CzechRepublic::PSE", new QuantLib::CzechRepublic(QuantLib::CzechRepublic::PSE));
    create.registerType("Denmark", new QuantLib::Denmark());
    create.registerType("EUR", new QuantLib::TARGET());
    create.registerType("Eurex", new QuantLib::Germany(QuantLib::Germany::Eurex));
    create.registerType("Finland", new QuantLib::Finland());
    create.registerType("Frankfurt stock exchange", new QuantLib::Germany(QuantLib::Germany::FrankfurtStockExchange));
    create.registerType("GBP", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Exchange));
    create.registerType("German settlement", new QuantLib::Germany(QuantLib::Germany::Settlement));
    create.registerType("Germany::Eurex", new QuantLib::Germany(QuantLib::Germany::Eurex));
    create.registerType("Germany::FrankfurtStockExchange", new QuantLib::Germany(QuantLib::Germany::FrankfurtStockExchange));
    create.registerType("Germany::Settlement", new QuantLib::Germany(QuantLib::Germany::Settlement));
    create.registerType("Germany::Xetra", new QuantLib::Germany(QuantLib::Germany::Xetra));
    create.registerType("Hong Kong stock exchange", new QuantLib::HongKong(QuantLib::HongKong::HKEx));
    create.registerType("HongKong::HKEx", new QuantLib::HongKong(QuantLib::HongKong::HKEx));
    create.registerType("Hungary", new QuantLib::Hungary());
    create.registerType("Iceland stock exchange", new QuantLib::Iceland(QuantLib::Iceland::ICEX));
    create.registerType("Iceland::ICEX", new QuantLib::Iceland(QuantLib::Iceland::ICEX));
    create.registerType("India::NSE", new QuantLib::India(QuantLib::India::NSE));
    create.registerType("Indonesia::BEJ", new QuantLib::Indonesia(QuantLib::Indonesia::BEJ));
    create.registerType("Indonesia::JSX", new QuantLib::Indonesia(QuantLib::Indonesia::JSX));
    create.registerType("Italian settlement", new QuantLib::Italy(QuantLib::Italy::Settlement));
    create.registerType("Italy::Exchange", new QuantLib::Italy(QuantLib::Italy::Exchange));
    create.registerType("Italy::Settlement", new QuantLib::Italy(QuantLib::Italy::Settlement));
    create.registerType("Jakarta stock exchange", new QuantLib::Indonesia(QuantLib::Indonesia::JSX));
    create.registerType("Japan", new QuantLib::Japan());
    create.registerType("LONDON", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Exchange));
    create.registerType("London metals exchange", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Metals));
    create.registerType("London stock exchange", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Exchange));
    create.registerType("Mexican stock exchange", new QuantLib::Mexico(QuantLib::Mexico::BMV));
    create.registerType("Mexico::BMV", new QuantLib::Mexico(QuantLib::Mexico::BMV));
    create.registerType("Milan stock exchange", new QuantLib::Italy(QuantLib::Italy::Exchange));
    create.registerType("National Stock Exchange of India", new QuantLib::India(QuantLib::India::NSE));
    create.registerType("New York stock exchange", new QuantLib::UnitedStates(QuantLib::UnitedStates::NYSE));
    create.registerType("New Zealand", new QuantLib::NewZealand());
    create.registerType("NewZealand", new QuantLib::NewZealand());
    create.registerType("NoCalendar", new QuantLib::Calendar());
    create.registerType("North American Energy Reliability Council", new QuantLib::UnitedStates(QuantLib::UnitedStates::NERC));
    create.registerType("Norway", new QuantLib::Norway());
    create.registerType("Null", new QuantLib::NullCalendar());
    create.registerType("NullCalendar", new QuantLib::NullCalendar());
    create.registerType("Poland", new QuantLib::Poland());
    create.registerType("Prague stock exchange", new QuantLib::CzechRepublic(QuantLib::CzechRepublic::PSE));
    create.registerType("Russia", new QuantLib::Russia());
    create.registerType("Russian settlement", new QuantLib::Russia());
    create.registerType("SaudiArabia::Tadawul", new QuantLib::SaudiArabia(QuantLib::SaudiArabia::Tadawul));
    create.registerType("Shanghai stock exchange", new QuantLib::China());
    create.registerType("Singapore exchange", new QuantLib::Singapore(QuantLib::Singapore::SGX));
    create.registerType("Singapore::SGX", new QuantLib::Singapore(QuantLib::Singapore::SGX));
    create.registerType("Slovakia::BSSE", new QuantLib::Slovakia(QuantLib::Slovakia::BSSE));
    create.registerType("South Africa", new QuantLib::SouthAfrica());
    create.registerType("South-Korea exchange", new QuantLib::SouthKorea(QuantLib::SouthKorea::KRX));
    create.registerType("SouthAfrica", new QuantLib::SouthAfrica());
    create.registerType("SouthKorea::KRX", new QuantLib::SouthKorea(QuantLib::SouthKorea::KRX));
    create.registerType("Sweden", new QuantLib::Sweden());
    create.registerType("Switzerland", new QuantLib::Switzerland());
    create.registerType("TARGET", new QuantLib::TARGET());
    create.registerType("TSX", new QuantLib::Canada(QuantLib::Canada::TSX));
    create.registerType("Tadawul", new QuantLib::SaudiArabia(QuantLib::SaudiArabia::Tadawul));
    create.registerType("Taiwan stock exchange", new QuantLib::Taiwan(QuantLib::Taiwan::TSEC));
    create.registerType("Taiwan::TSEC", new QuantLib::Taiwan(QuantLib::Taiwan::TSEC));
    create.registerType("Turkey", new QuantLib::Turkey());
    create.registerType("UK settlement", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Settlement));
    create.registerType("US government bond market", new QuantLib::UnitedStates(QuantLib::UnitedStates::GovernmentBond));
    create.registerType("US settlement", new QuantLib::UnitedStates(QuantLib::UnitedStates::Settlement));
    create.registerType("Ukraine::USE", new QuantLib::Ukraine(QuantLib::Ukraine::USE));
    create.registerType("Ukrainian stock exchange", new QuantLib::Ukraine(QuantLib::Ukraine::USE));
    create.registerType("UnitedKingdom::Exchange", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Exchange));
    create.registerType("UnitedKingdom::Metals", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Metals));
    create.registerType("UnitedKingdom::Settlement", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Settlement));
    create.registerType("UnitedStates::GovernmentBond", new QuantLib::UnitedStates(QuantLib::UnitedStates::GovernmentBond));
    create.registerType("UnitedStates::NERC", new QuantLib::UnitedStates(QuantLib::UnitedStates::NERC));
    create.registerType("UnitedStates::NYSE", new QuantLib::UnitedStates(QuantLib::UnitedStates::NYSE));
    create.registerType("UnitedStates::Settlement", new QuantLib::UnitedStates(QuantLib::UnitedStates::Settlement));
    create.registerType("Xetra", new QuantLib::Germany(QuantLib::Germany::Xetra));
}

void QuantLibAddin::unregisterTypesCalendars() {

    ObjectHandler::Create<QuantLib::Calendar>().unregisterTypes();
}
