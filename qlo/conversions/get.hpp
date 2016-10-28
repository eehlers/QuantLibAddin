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
    class Quote;
    class YieldTermStructure;
}

#include <ql/handle.hpp>

namespace QuantLibAddin {

    template <class In, class Out>
    class Get {
    public:
        Out operator()(const In&);
    };

    template<> class Get<std::string, QuantLib::Period> {
    public:
        QuantLib::Period operator()(const std::string&);
    };

    //template<> class Get<std::string, QuantLib::Handle<QuantLib::Quote> > {
    //public:
    //    QuantLib::Handle<QuantLib::Quote> operator()(const std::string&);
    //};

    template<> class Get<std::string, QuantLib::Handle<QuantLib::YieldTermStructure> > {
    public:
        QuantLib::Handle<QuantLib::YieldTermStructure> operator()(
            const std::string&,
            const QuantLib::Handle<QuantLib::YieldTermStructure>& = QuantLib::Handle<QuantLib::YieldTermStructure>());
    };
}

#endif

