/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2007 Eric Ehlers

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

#ifndef qla_handle_hpp
#define qla_handle_hpp

#include <rp/object.hpp>

namespace QuantLibAddin {

    class Handle : public reposit::Object {
    public:
        std::string currentLink() const {
            return boost::get<std::string>(propertyValue("CURRENTLINK"));
        }
        virtual bool empty() const = 0;
    protected:
        Handle(const boost::shared_ptr<reposit::ValueObject> &properties,
           //const std::string &objectId,
           bool permanent) : reposit::Object(properties, permanent) {}
    };

    class RelinkableHandle : public Handle {
    public:
        virtual void linkTo(const std::string &objectID) = 0;
    protected:
        RelinkableHandle(const boost::shared_ptr<reposit::ValueObject> &properties,
           //const std::string &objectId,
           bool permanent) : Handle(properties/*, objectId*/, permanent) {}
    };

}

#endif

