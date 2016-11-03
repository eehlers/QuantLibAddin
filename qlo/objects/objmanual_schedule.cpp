/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2011 Ferdinando Ametrano
 Copyright (C) 2006 Eric Ehlers
 Copyright (C) 2005 Aurelien Chanudet

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

#if defined(HAVE_CONFIG_H)     // Dynamically created by configure
    #include <qlo/config.hpp>
#endif
#include <ql/time/schedule.hpp>
#include <qlo/objects/objmanual_schedule.hpp>

namespace QuantLibAddin {

    Schedule::Schedule(const boost::shared_ptr<reposit::ValueObject>& p,
                       const QuantLib::Date& effectiveDate,
                       const QuantLib::Date& terminationDate,
                       const QuantLib::Period& tenor,
                       const QuantLib::Calendar& calendar,
                       QuantLib::BusinessDayConvention convention,
                       QuantLib::BusinessDayConvention terminationDateConv,
                       QuantLib::DateGeneration::Rule rule,
                       bool endOfMonth,
                       const QuantLib::Date& firstDate,
                       const QuantLib::Date& nextToLastDate,
                       bool permanent)
    : reposit::LibraryObject<QuantLib::Schedule>(p, permanent) {
    
        libraryObject_ = boost::shared_ptr<QuantLib::Schedule>(new
            QuantLib::Schedule(effectiveDate,
                               terminationDate,
                               tenor,
                               calendar,
                               convention,
                               terminationDateConv,
                               rule,
                               endOfMonth,
                               firstDate,
                               nextToLastDate));
    }

    Schedule::Schedule(const boost::shared_ptr<reposit::ValueObject>& p,
                       const std::vector<QuantLib::Date>& dates,
                       bool permanent)
    : reposit::LibraryObject<QuantLib::Schedule>(p, permanent) {
    
        libraryObject_ = boost::shared_ptr<QuantLib::Schedule>(new
            QuantLib::Schedule(dates));
    }

    Schedule::Schedule(const boost::shared_ptr<reposit::ValueObject>& p,
                       const boost::shared_ptr<QuantLib::Schedule>& from,
                       const QuantLib::Date& truncationDate,
                       bool permanent)
    : reposit::LibraryObject<QuantLib::Schedule>(p, permanent) {
    
        libraryObject_ = boost::shared_ptr<QuantLib::Schedule>(new
            QuantLib::Schedule(from->until(truncationDate)));
    }

}
