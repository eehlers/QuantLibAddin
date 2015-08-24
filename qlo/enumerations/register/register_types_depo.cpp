
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

#include <qlo/objmanual_ratehelpers.hpp>

#include <oh/enumerations/typefactory.hpp>
#include <qlo/enumerations/register/register_types.hpp>

void QuantLibAddin::registerTypesDepos() {

    ObjectHandler::Create<QuantLibAddin::RateHelper::DepoInclusionCriteria> create;
    create.registerType("AllDepos", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::AllDepos));
    create.registerType("DeposBeforeFirstFuturesExpiryDate", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesExpiryDate));
    create.registerType("DeposBeforeFirstFuturesStartDate", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesStartDate));
    create.registerType("DeposBeforeFirstFuturesStartDatePlusOne", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesStartDatePlusOne));
}

void QuantLibAddin::unregisterTypesDepos() {

    ObjectHandler::Create<QuantLibAddin::RateHelper::DepoInclusionCriteria>().unregisterTypes();
}

