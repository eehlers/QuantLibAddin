/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2016 Eric Ehlers

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

#ifndef qlo_temp_hpp
#define qlo_temp_hpp

#include <string>

namespace QuantLib {
    class Period;
}

#include <ql/handle.hpp>

namespace QuantLibAddin {

    QuantLib::Period getPeriod(const std::string &in);

    // FIXME this generic behavior should be implemented in the reposit project/namespace.
    template <class QuantLibAddinObject, class QuantLibObject>
    struct GetObject {
        static boost::shared_ptr<QuantLibObject> f(const std::string &in) {
            RP_GET_REFERENCE(ret, in, QuantLibAddinObject, QuantLibObject);
            return ret;
        }
    };

    template <class QuantLibAddinQuote, class QuantLibQuote>
    boost::shared_ptr<QuantLibQuote> getQuote(const std::string &in);

    template <class QuantLibAddinYts, class QuantLibYts>
    boost::shared_ptr<QuantLibYts> getYieldTermStructure(const std::string &in);

    template <class QuantLibAddinHandle, class QuantLibHandle>
    QuantLib::Handle<QuantLibHandle> getHandle(
        const std::string &in
    );

    template <class QuantLibAddinHandle, class QuantLibHandle>
    QuantLib::Handle<QuantLibHandle> getHandle(
        const std::string &in,
        const QuantLib::Handle<QuantLibHandle> &defaultValue
    );
}

#endif

