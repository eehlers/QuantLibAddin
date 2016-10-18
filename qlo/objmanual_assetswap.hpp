
/*
 Copyright (C) 2011 Ferdinando Ametrano
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

#ifndef qla_asset_swap_hpp
#define qla_asset_swap_hpp

#include <string>
#include <rp/libraryobject.hpp>
#include <rp/valueobject.hpp>
#include <boost/shared_ptr.hpp>
#include <ql/instruments/assetswap.hpp>
#include <qlo/obj_instruments.hpp>
#include <qlo/objmanual_swap.hpp>

namespace QuantLib {
    class Bond;
}

namespace QuantLibAddin {
    
    class AssetSwap : public Swap {
    public:
        AssetSwap(const boost::shared_ptr<reposit::ValueObject>& properties,
                  bool payFixedRate,
                  const boost::shared_ptr<QuantLib::Bond>& bond,
                  QuantLib::Real bondCleanPrice,
                  const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
                  QuantLib::Spread spread,
                  const boost::shared_ptr<QuantLib::Schedule>& floatSchedule,
                  const QuantLib::DayCounter& floatingDayCounter,
                  bool parSwap,
                  bool permanent);
        AssetSwap(const boost::shared_ptr<reposit::ValueObject>& properties,
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
                  bool permanent);
                                      
        std::vector<std::vector<reposit::property_t> > bondLegAnalysis(
                                                    const QuantLib::Date& d) {
            return Swap::legAnalysis(0, d);
        }

        std::vector<std::vector<reposit::property_t> > floatingLegAnalysis(
                                                    const QuantLib::Date& d) {
            return Swap::legAnalysis(1, d);
        }

    };
}

#endif
