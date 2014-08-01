
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

//#include <qlo/qladdindefines.hpp>

#include <ql/option.hpp>
//#include <ql/default.hpp> // RL ADD 2010-07-15

#include <oh/enumerations/typefactory.hpp>
#include <qlo/enumerations/register/register_types.hpp>

namespace QuantLibAddin {

    void registerTypesOptionTypes() {
    
        ObjectHandler::Create<QuantLib::Option::Type> create;
        create.registerType("Call", new QuantLib::Option::Type(QuantLib::Option::Call));
        create.registerType("Put", new QuantLib::Option::Type(QuantLib::Option::Put));
    }

    void unregisterTypesOptionTypes() {
    
        ObjectHandler::Create<QuantLib::Option::Type>().unregisterTypes();
    }

}

