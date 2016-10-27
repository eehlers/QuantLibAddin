/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2007 Eric Ehlers
 Copyright (C) 2008 Ferdinando Ametrano
 Copyright (C) 2008 Plamen Neykov

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

#ifndef qlo_convert_date_hpp
#define qlo_convert_date_hpp

#include <rp/conversions/convert.hpp>
#include <ql/types.hpp>
#include <map>

namespace QuantLib {
    class Date;
    class Period;
    class Quote;
    template <class T> class Handle;

    template<class T, class Container>
    class TimeSeries;

    typedef TimeSeries<QuantLib::Real, std::map<QuantLib::Date, QuantLib::Real> > TimeSeriesDef;
};

namespace reposit {

    template<> QuantLib::Date convert<QuantLib::Date, property_t>(const property_t& p);

    template<> QuantLib::Size convert<QuantLib::Size, property_t>(const property_t& p);

    template<>
    QuantLib::Period convert<QuantLib::Period, property_t>(const property_t& p);

    template<>
    boost::shared_ptr<QuantLib::Quote> convert<boost::shared_ptr<QuantLib::Quote>, property_t>(const property_t& c);

    template<>
    QuantLib::Handle<QuantLib::Quote> convert<QuantLib::Handle<QuantLib::Quote>, property_t>(const property_t& c);

    template<> QuantLib::TimeSeriesDef convert<QuantLib::TimeSeriesDef, property_t>(const property_t& c);
}

#endif
