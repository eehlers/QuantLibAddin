/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2010 Ferdinando Ametrano
 Copyright (C) 2006 Silvia Frasson
 Copyright (C) 2006 Mario Pucci
 Copyright (C) 2006, 2007 Giorgio Facchinetti
 Copyright (C) 2007 Eric Ehlers

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

#ifndef qla_swaptionvolstructure_hpp
#define qla_swaptionvolstructure_hpp

#include <qlo/objects/objmanual_termstructures.hpp>
#include <qlo/objects/volatilities/smilesection.hpp>
#include <ql/time/businessdayconvention.hpp>

namespace QuantLib {
    class Calendar;
    class SwaptionVolatilityCube;
    class SwapIndex;
    class Matrix;
    class Period;
}

namespace QuantLibAddin {

    class ConstantSwaptionVolatility : public SwaptionVolatilityStructure {
      public:
        ConstantSwaptionVolatility(
                        const boost::shared_ptr<reposit::ValueObject>&,
                        QuantLib::Natural settlementDays,
                        const QuantLib::Calendar& cal,
                        QuantLib::BusinessDayConvention bdc,
                        const QuantLib::Handle<QuantLib::Quote>& vol,
                        const QuantLib::DayCounter& dayCounter,
                        bool permanent);
    };

    class SpreadedSwaptionVolatility : public SwaptionVolatilityStructure {
      public:
        SpreadedSwaptionVolatility(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& underlyingVolStructure,
            const QuantLib::Handle<QuantLib::Quote>&,
            bool permanent);
    };
        
    class SwaptionVolatilityMatrix : public SwaptionVolatilityDiscrete {
      public:
        SwaptionVolatilityMatrix(const boost::shared_ptr<reposit::ValueObject>& properties,
                                 const QuantLib::Calendar& calendar,
                                 const QuantLib::BusinessDayConvention bdc,
                                 const std::vector<QuantLib::Period>& optionTenors,
                                 const std::vector<QuantLib::Period>& tenors,
                                 const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& vols,
                                 const QuantLib::DayCounter& dayCounter,
                                 bool permanent);
        std::vector<long> locate(const QuantLib::Date& d,
                                 const QuantLib::Period& p);
    };
    
    class SwaptionVolCube2 : public SwaptionVolatilityCube {
      public:
        SwaptionVolCube2(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& atmVol,
            const std::vector<QuantLib::Period>& optionTenors,
            const std::vector<QuantLib::Period>& swapTenors,
            const std::vector<QuantLib::Spread>& strikeSpreads,
            const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& volSpreads,
            const boost::shared_ptr<QuantLib::SwapIndex>& swapIndexBase,
            const boost::shared_ptr<QuantLib::SwapIndex>& shortSwapIndexBase,
            bool vegaWeightedSmileFit,
            bool permanent);
    };
    
    // The 2 functions below must declare their input parameters as pass by value rather
    // than pass by reference to allow clients of these functions to pass temporary objects.
    std::vector<std::vector<reposit::property_t> > getSabrParameters(QuantLib::Matrix sabrParameters);
    std::vector<std::vector<reposit::property_t> > getVolCube(QuantLib::Matrix volCube);
    
    class SwaptionVolCube1 : public SwaptionVolatilityCube {
      public:
        SwaptionVolCube1(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& atmVol,
            const std::vector<QuantLib::Period>& optionTenors,
            const std::vector<QuantLib::Period>& swapTenors,
            const std::vector<QuantLib::Spread>& strikeSpreads,
            const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& volSpreads,
            const boost::shared_ptr<QuantLib::SwapIndex>& swapIndexBase,
            const boost::shared_ptr<QuantLib::SwapIndex>& shortSwapIndexBase,
            bool vegaWeightedSmileFit,
            const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& parametersGuess,
            const std::vector<bool>& isParameterFixed,
            bool isAtmCalibrated,
            const boost::shared_ptr<QuantLib::EndCriteria>& endCriteria,
            QuantLib::Real maxErrorTolerance,
            const boost::shared_ptr<QuantLib::OptimizationMethod>& optMethod,
            bool permanent);
        std::vector<std::vector<reposit::property_t> > getSparseSabrParameters();
        std::vector<std::vector<reposit::property_t> > getDenseSabrParameters();
        std::vector<std::vector<reposit::property_t> > getMarketVolCube();
        std::vector<std::vector<reposit::property_t> > getVolCubeAtmCalibrated();
    };

    class SmileSectionByCube : public SmileSection {
      public:
        SmileSectionByCube(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const boost::shared_ptr<QuantLib::SwaptionVolatilityCube>& cube,
            const QuantLib::Period& optionTenors,
            const QuantLib::Period& swapTenors,
            bool permanent);
        SmileSectionByCube(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const boost::shared_ptr<QuantLib::SwaptionVolatilityCube>& cube,
            const QuantLib::Date& optionDate,
            const QuantLib::Period& swapTenors,
            bool permanent);
    };
    
}

#endif
