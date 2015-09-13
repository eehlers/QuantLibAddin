/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2007 Ferdinando Ametrano
 Copyright (C) 2005, 2015 Eric Ehlers
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

//#if defined(HAVE_CONFIG_H)
//    #include <qlo/config.hpp>
//#endif

#include <qlo/indexes/ibor/euribor.hpp>

#include <ql/indexes/ibor/euribor.hpp>
#include <ql/indexes/ibor/eonia.hpp>
#include <ql/utilities/dataparsers.hpp>

#include <boost/algorithm/string/case_conv.hpp>

QuantLibAddin::Euribor::Euribor(const boost::shared_ptr<reposit::ValueObject>& properties,
                 QuantLib::Period const &tenor,
                 QuantLib::Handle< QuantLib::YieldTermStructure > const &YieldCurve,
                 bool permanent)
: IborIndex(properties, permanent)
{
//    std::string p = boost::algorithm::to_upper_copy(p_inp);
//    if (p=="SW")
//        libraryObject_ = boost::shared_ptr<QuantLib::IborIndex>(new
//        QuantLib::Euribor(1*QuantLib::Weeks, h));
//    else {
//        QuantLib::Period pp = QuantLib::PeriodParser::parse(p);
//        pp.normalize();
//        libraryObject_ = boost::shared_ptr<QuantLib::IborIndex>(new
//            QuantLib::Euribor(pp, h));
//    }
    libraryObject_ = boost::shared_ptr<QuantLib::IborIndex>(new QuantLib::Euribor(
        // BEGIN typemap rp_tm_default
        tenor,
        YieldCurve
        // END   typemap rp_tm_default
    ));
}

//QuantLibAddin::Euribor365::Euribor365(const boost::shared_ptr<ValueObject>& properties,
//                       const std::string& p_inp,
//                       const QuantLib::Handle<QuantLib::YieldTermStructure>& h,
//                       bool permanent)
//: IborIndex(properties, permanent)
//{
//    std::string p = boost::algorithm::to_upper_copy(p_inp);
//    if (p=="SW")
//        libraryObject_ = boost::shared_ptr<QuantLib::IborIndex>(new
//        QuantLib::Euribor365(1*QuantLib::Weeks, h));
//    else {
//        QuantLib::Period pp = QuantLib::PeriodParser::parse(p);
//        pp.normalize();
//        libraryObject_ = boost::shared_ptr<QuantLib::IborIndex>(new
//            QuantLib::Euribor365(pp, h));
//    }
//}

QuantLibAddin::Eonia::Eonia(const boost::shared_ptr<reposit::ValueObject>& properties,
             const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve,
             bool permanent)
: OvernightIndex(properties, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::OvernightIndex>(new QuantLib::Eonia(
        // BEGIN typemap rp_tm_default
        YieldCurve
        // END   typemap rp_tm_default
    ));
}

