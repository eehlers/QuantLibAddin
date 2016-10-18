
/*
 Copyright (C) 2006 Chiara Fornarola

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

#include <qlo/objmanual_assetswap.hpp>
#include <ql/instruments/assetswap.hpp>
#include <ql/pricingengines/swap/discountingswapengine.hpp>

namespace QuantLibAddin {

    AssetSwap::AssetSwap(
                const boost::shared_ptr<reposit::ValueObject>& properties,
                bool payFixedRate,
                const boost::shared_ptr<QuantLib::Bond>& bond,
                const QuantLib::Real bondCleanPrice,
                const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
                QuantLib::Spread spread,
                //const QuantLib::Handle<QuantLib::YieldTermStructure>& hYTS,
                const boost::shared_ptr<QuantLib::Schedule>& floatSchedule,
                const QuantLib::DayCounter& floatingDayCounter,
                bool parSwap,
                bool permanent)
    : Swap(properties, permanent)
    {
        boost::shared_ptr<QuantLib::Schedule> actualFloatSchedule;
        if (floatSchedule.get()==NULL)
            actualFloatSchedule = boost::shared_ptr<QuantLib::Schedule>(new
                QuantLib::Schedule);
        else
            actualFloatSchedule = floatSchedule;

        libraryObject_ = boost::shared_ptr<QuantLib::Instrument>(new
            QuantLib::AssetSwap(payFixedRate,
                                bond,
                                bondCleanPrice,
                                iborIndex,
                                spread,
                                *actualFloatSchedule,
                                floatingDayCounter,
                                parSwap));

       //boost::shared_ptr<QuantLib::PricingEngine> swapEngine(new
       //    QuantLib::DiscountingSwapEngine(hYTS, false,
       //                                    bond->settlementDate()));
       //
       //libraryObject_->setPricingEngine(swapEngine);

    }

    AssetSwap::AssetSwap(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            bool parAssetSwap,
            const boost::shared_ptr<QuantLib::Bond>& bond,
            QuantLib::Real bondCleanPrice,
            QuantLib::Real nonParRepayment,
            QuantLib::Real gearing,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
            QuantLib::Spread spread,
            const QuantLib::DayCounter& floatingDayCounter,
            const QuantLib::Date& dealMaturity,
            bool payFixedRate,
            bool permanent)
    : Swap(properties, permanent)
    {
        boost::shared_ptr<QuantLib::Schedule> actualFloatSchedule(new
            QuantLib::Schedule);

        libraryObject_ = boost::shared_ptr<QuantLib::Instrument>(new
            QuantLib::AssetSwap(parAssetSwap,
                                bond,
                                bondCleanPrice,
                                nonParRepayment,
                                gearing,
                                iborIndex,
                                spread,
                                floatingDayCounter,
                                dealMaturity,
                                payFixedRate));
    }

}
