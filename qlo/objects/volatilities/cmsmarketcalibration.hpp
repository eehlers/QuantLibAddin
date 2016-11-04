/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2007 Ferdinando Ametrano
 Copyright (C) 2006 Giorgio Facchinetti

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

#ifndef qla_cmsmarket_calibration_hpp
#define qla_cmsmarket_calibration_hpp

#include <rp/libraryobject.hpp>

// To be removed later
#include <ql/termstructures/volatility/swaption/cmsmarketcalibration.hpp>

#include <ql/types.hpp>

#include <ql/math/array.hpp>

namespace QuantLib {
    class CmsCouponPricer;
    class Matrix;
    class CmsMarket;
    class Period;
    class SwapIndex;
    class Quote;
    class YieldTermStructure;
    class CmsMarketCalibration;
    class SwaptionVolatilityStructure;
    class EndCriteria;
    class OptimizationMethod;
}

namespace QuantLibAddin {
 
    class CmsMarketCalibration: public reposit::LibraryObject<QuantLib::CmsMarketCalibration>{
      public:
        CmsMarketCalibration(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& volCube,
            boost::shared_ptr<QuantLib::CmsMarket>& cmsMarket,
            const QuantLib::Matrix& weights,
            QuantLib::CmsMarketCalibration::CalibrationType calibrationType,
            bool permanent);
        
        std::vector<std::vector<reposit::property_t> > getSparseSabrParameters();
        std::vector<std::vector<reposit::property_t> > getDenseSabrParameters();
        std::vector<std::vector<reposit::property_t> > getCmsMarket();
        QuantLib::Real elapsed() {return elapsed_ ; }
        QuantLib::Array compute(const boost::shared_ptr<QuantLib::EndCriteria>& endCriteria,
                                const boost::shared_ptr<QuantLib::OptimizationMethod>& method,
                                const QuantLib::Array& guess,
                                bool isMeanReversionFixed);
      private:
        QuantLib::Real elapsed_;
    }; 
}

#endif

