/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006 Ferdinando Ametrano
 Copyright (C) 2006 Silvia Frasson
 Copyright (C) 2006 Mario Pucci
 Copyright (C) 2006, 2007 Giorgio Facchinetti

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

#if defined(HAVE_CONFIG_H)
    #include <qlo/config.hpp>
#endif

#include <qlo/objects/volatilities/swaptionvolstructure.hpp>

#include <ql/termstructures/volatility/swaption/swaptionconstantvol.hpp>
#include <ql/termstructures/volatility/swaption/swaptionvolcube2.hpp>
#include <ql/termstructures/volatility/swaption/swaptionvolcube1.hpp>
#include <ql/termstructures/volatility/swaption/swaptionvolmatrix.hpp>
#include <ql/termstructures/volatility/swaption/spreadedswaptionvol.hpp>
#include <ql/math/optimization/endcriteria.hpp>
#include <ql/time/calendars/nullcalendar.hpp>

namespace QuantLibAddin {

    ConstantSwaptionVolatility::ConstantSwaptionVolatility(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        QuantLib::Natural settlementDays,
        const QuantLib::Calendar& cal,
        QuantLib::BusinessDayConvention bdc,
        const QuantLib::Handle<QuantLib::Quote>& vol,
        const QuantLib::DayCounter& dayCounter,
        bool permanent)
    : SwaptionVolatilityStructure(properties, permanent)
    {
        libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::ConstantSwaptionVolatility(settlementDays,
                                                 cal,
                                                 bdc,
                                                 vol,
                                                 dayCounter));
    }

    SpreadedSwaptionVolatility::SpreadedSwaptionVolatility(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& underlyingVolStructure,
            const QuantLib::Handle<QuantLib::Quote>& spread,
            bool permanent)
    : SwaptionVolatilityStructure(properties, permanent)
    {
        libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::SpreadedSwaptionVolatility(underlyingVolStructure,
                                                 spread));
    }

    SwaptionVolatilityMatrix::SwaptionVolatilityMatrix(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Calendar& calendar,
            const QuantLib::BusinessDayConvention bdc,
            const std::vector<QuantLib::Period>& optionTenors,
            const std::vector<QuantLib::Period>& swapTenors,
            const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& vols,
            const QuantLib::DayCounter& dayCounter,
            bool permanent)
    : SwaptionVolatilityDiscrete(properties, permanent)
    {
        libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::SwaptionVolatilityMatrix(calendar,
                                               bdc,
                                               optionTenors,
                                               swapTenors,
                                               vols,
                                               dayCounter));
    }

    std::vector<long> SwaptionVolatilityMatrix::locate(
                                                const QuantLib::Date& d,
                                                const QuantLib::Period& p) {
        std::pair<QuantLib::Size, QuantLib::Size> indexes =
            boost::dynamic_pointer_cast<QuantLib::SwaptionVolatilityMatrix>(
                libraryObject_)->locate(d,p);
        std::vector<long> result(2);
        result[0]=indexes.first;
        result[1]=indexes.second;
        return result;
    }

    SwaptionVolCube2::SwaptionVolCube2(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& atmVol,
        const std::vector<QuantLib::Period>& optionTenors,
        const std::vector<QuantLib::Period>& swapTenors,
        const std::vector<QuantLib::Spread>& strikeSpreads,
        const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& volSpreads,
        const boost::shared_ptr<QuantLib::SwapIndex>& swapIndexBase,
        const boost::shared_ptr<QuantLib::SwapIndex>& shortSwapIndexBase,
        bool vegaWeightedSmileFit,
        bool permanent) : SwaptionVolatilityCube(properties, permanent)
    {
        libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::SwaptionVolCube2(atmVol,
                                       optionTenors,
                                       swapTenors,
                                       strikeSpreads,
                                       volSpreads,
                                       swapIndexBase,
                                       shortSwapIndexBase,
                                       vegaWeightedSmileFit));
    }

    SwaptionVolCube1::SwaptionVolCube1(
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
        bool permanent) : SwaptionVolatilityCube(properties, permanent)
    {
        QL_REQUIRE(!atmVol.empty(), "atm vol handle not linked to anything");
        libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::SwaptionVolCube1(atmVol,
                                       optionTenors,
                                       swapTenors,
                                       strikeSpreads,
                                       volSpreads,
                                       swapIndexBase,
                                       shortSwapIndexBase,
                                       vegaWeightedSmileFit,
                                       parametersGuess,
                                       isParameterFixed,
                                       isAtmCalibrated,
                                       endCriteria,
                                       maxErrorTolerance,
                                       optMethod ));
    }

    std::vector<std::vector<reposit::property_t> >
    SwaptionVolCube1::getSparseSabrParameters() {
        const boost::shared_ptr<QuantLib::SwaptionVolCube1>&
            volCube = boost::dynamic_pointer_cast<
                    QuantLib::SwaptionVolCube1>(libraryObject_);
        return getSabrParameters(volCube->sparseSabrParameters());
    }

    std::vector<std::vector<reposit::property_t> >
    SwaptionVolCube1::getDenseSabrParameters() {
        const boost::shared_ptr<QuantLib::SwaptionVolCube1>&
            volCube = boost::dynamic_pointer_cast<
                    QuantLib::SwaptionVolCube1>(libraryObject_);
        return getSabrParameters(volCube->denseSabrParameters());
    }

    std::vector<std::vector<reposit::property_t> >
    SwaptionVolCube1::getMarketVolCube() {
        const boost::shared_ptr<QuantLib::SwaptionVolCube1>&
            volCube = boost::dynamic_pointer_cast<
                    QuantLib::SwaptionVolCube1>(libraryObject_);
        return getVolCube(volCube->marketVolCube());
    }

    std::vector<std::vector<reposit::property_t> >
    SwaptionVolCube1::getVolCubeAtmCalibrated() {
        const boost::shared_ptr<QuantLib::SwaptionVolCube1>&
            volCube = boost::dynamic_pointer_cast<
                    QuantLib::SwaptionVolCube1>(libraryObject_);
        return getVolCube(volCube->volCubeAtmCalibrated());
    }

    std::vector<std::vector<reposit::property_t> > getSabrParameters(QuantLib::Matrix sabrParameters)
    {
        std::vector<std::vector<reposit::property_t> > sparseSabrParameters;
        QuantLib::Size numberOfColumn = 10;

        std::vector<reposit::property_t> headings(numberOfColumn);
        headings[0]=std::string("Swap Length");
        headings[1]=std::string("Expiry");

        headings[2]=std::string("Alpha");
        headings[3]=std::string("Beta");
        headings[4]=std::string("Nu");
        headings[5]=std::string("Rho");
        headings[6]=std::string("Forward");
        headings[7]=std::string("Error");
        headings[8]=std::string("Max Error");
        headings[9]=std::string("End Criteria");


        sparseSabrParameters.push_back(headings);

        for(QuantLib::Size i=0; i<sabrParameters.rows(); ++i) {
            std::vector<reposit::property_t> par(numberOfColumn, std::string("N/A"));
            for(QuantLib::Size j=0; j<sabrParameters.columns()-1; ++j) {
               par[j] = sabrParameters[i][j];
            }
            std::ostringstream endCriteria;
            endCriteria << QuantLib::EndCriteria::Type(static_cast<QuantLib::Integer>(sabrParameters[i][numberOfColumn-1]));
            par[numberOfColumn-1] = endCriteria.str();

            sparseSabrParameters.push_back(par);
        }
        return sparseSabrParameters;
    }

    std::vector<std::vector<reposit::property_t> > getVolCube(QuantLib::Matrix volCube)
    {
        std::vector<std::vector<reposit::property_t> > volatilityCube;
        QuantLib::Size numberOfColumn = 11;

        std::vector<reposit::property_t> headings(numberOfColumn);
        headings[0]=std::string("Swap Length");
        headings[1]=std::string("Expiry");

        headings[ 2] = -200*1e-4;
        headings[ 3] = -100*1e-4;
        headings[ 4] = - 50*1e-4;
        headings[ 5] = - 25*1e-4;
        headings[ 6] =    0*1e-4;
        headings[ 7] = + 25*1e-4;
        headings[ 8] = + 50*1e-4;
        headings[ 9] = +100*1e-4;
        headings[10] = +200*1e-4;

        volatilityCube.push_back(headings);

        for(QuantLib::Size i=0; i<volCube.rows(); ++i)
        {
            std::vector<reposit::property_t> vol(numberOfColumn, std::string("N/A"));
            for(QuantLib::Size j=0; j<volCube.columns(); ++j)
            {
               vol[j] = volCube[i][j];
            }
            volatilityCube.push_back(vol);
        }
        return volatilityCube;
    }

    SmileSectionByCube::SmileSectionByCube(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const boost::shared_ptr<QuantLib::SwaptionVolatilityCube>& cube,
            const QuantLib::Period& optionTenor,
            const QuantLib::Period& swapTenors,
            bool permanent) : SmileSection(properties, permanent) {
             libraryObject_ = cube->smileSection(optionTenor,swapTenors);
    }

    SmileSectionByCube::SmileSectionByCube(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const boost::shared_ptr<QuantLib::SwaptionVolatilityCube>& cube,
            const QuantLib::Date& optionDate,
            const QuantLib::Period& swapTenors,
            bool permanent) : SmileSection(properties, permanent) {
             libraryObject_ = cube->smileSection(optionDate,swapTenors);
    }

}
