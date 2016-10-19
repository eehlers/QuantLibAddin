/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2007 Ferdinando Ametrano
 Copyright (C) 2006, 2007 Cristina Duminuco
 Copyright (C) 2006 Giorgio Facchinetti
 Copyright (C) 2006 Francois du Vignaud

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

#ifndef qla_conundrumpricer_hpp
#define qla_conundrumpricer_hpp


#include <qlo/objects/objmanual_couponvectors.hpp>
#include <ql/cashflows/conundrumpricer.hpp>

namespace QuantLibAddin {

    class CmsCouponPricer : public FloatingRateCouponPricer {
      public:
        CmsCouponPricer(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& vol,
            const std::string& typeOfCmsCouponPricer,
            QuantLib::GFunctionFactory::YieldCurveModel modelOfYieldCurve,
            const QuantLib::Handle<QuantLib::Quote>& meanReversion,
            bool permanent);
      protected:
        RP_OBJ_CTOR(CmsCouponPricer, FloatingRateCouponPricer);
    };

    class NumericHaganPricer: public CmsCouponPricer{
    public:
      NumericHaganPricer(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& swaptionVol,
            QuantLib::GFunctionFactory::YieldCurveModel modelOfYieldCurve,
            const QuantLib::Handle<QuantLib::Quote>& meanReversion,
            QuantLib::Rate lowerLimit,
            QuantLib::Rate upperLimit,
            QuantLib::Real precision,
            bool permanent);
    };
}

#endif

