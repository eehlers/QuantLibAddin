//
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
//
 QuantLib is free software: you can redistribute it and/or modify it
 under the terms of the QuantLib license.  You should have received a
 copy of the license along with this program; if not, please email
 <quantlib-dev@lists.sf.net>. The license is also available online at
 <http://quantlib.org/license.shtml>.
//
 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
*/

#include <ql/time/businessdayconvention.hpp>

#include <oh/enumerations/typefactory.hpp>
#include <qlo/enumerations/register/register_types.hpp>

void QuantLibAddin::registerTypesConventions() {

    ObjectHandler::Create<QuantLib::BusinessDayConvention> create;
    create.registerType("F", new QuantLib::BusinessDayConvention(QuantLib::Following));
    create.registerType("Following", new QuantLib::BusinessDayConvention(QuantLib::Following));
    create.registerType("HMMF", new QuantLib::BusinessDayConvention(QuantLib::HalfMonthModifiedFollowing));
    create.registerType("Half-Month Modified Following", new QuantLib::BusinessDayConvention(QuantLib::HalfMonthModifiedFollowing));
    create.registerType("Indifferent", new QuantLib::BusinessDayConvention(QuantLib::Unadjusted));
    create.registerType("MF", new QuantLib::BusinessDayConvention(QuantLib::ModifiedFollowing));
    create.registerType("MP", new QuantLib::BusinessDayConvention(QuantLib::ModifiedPreceding));
    create.registerType("Modified Following", new QuantLib::BusinessDayConvention(QuantLib::ModifiedFollowing));
    create.registerType("Modified Preceding", new QuantLib::BusinessDayConvention(QuantLib::ModifiedPreceding));
    create.registerType("P", new QuantLib::BusinessDayConvention(QuantLib::Preceding));
    create.registerType("Preceding", new QuantLib::BusinessDayConvention(QuantLib::Preceding));
    create.registerType("Unadjusted", new QuantLib::BusinessDayConvention(QuantLib::Unadjusted));
}

void QuantLibAddin::unregisterTypesConventions() {

    ObjectHandler::Create<QuantLib::BusinessDayConvention>().unregisterTypes();
}
