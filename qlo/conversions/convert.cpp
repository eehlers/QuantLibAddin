/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2004, 2005, 2006, 2007 Eric Ehlers
 Copyright (C) 2005, 2008 Plamen Neykov

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
#include <qlo/conversions/convert.hpp>
#include <qlo/conversions/convert_tmpl.hpp>

namespace reposit {

    template<> 
    QuantLib::Date convert<QuantLib::Date, property_t>(const property_t& c) {
        return convertDate(c);
    }

    template<> 
    QuantLib::Size convert<QuantLib::Size, property_t>(const property_t& p) { 
        return convertSize(p); 
    }

    template<>
    QuantLib::Period convert<QuantLib::Period, property_t>(const property_t& c) {
        return convertPeriod(c);
    }

    //template<>
    //boost::shared_ptr<QuantLib::Quote> convert<boost::shared_ptr<QuantLib::Quote>, property_t>(const property_t& c) {
    //    return convertQuote(c);
    //}

    //template<>
    //QuantLib::Handle<QuantLib::Quote> convert<QuantLib::Handle<QuantLib::Quote>, property_t>(const property_t& c) {
    //    return convertQuoteHandle(c);
    //}

    //template<>
    //QuantLib::TimeSeriesDef convert<QuantLib::TimeSeriesDef, property_t>(const property_t& c) {
    //    return convertTimeSeriesDef(c);
    //}
}
