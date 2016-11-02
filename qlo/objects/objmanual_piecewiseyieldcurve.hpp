/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2007 Eric Ehlers
 Copyright (C) 2007, 2008, 2009 Ferdinando Ametrano
 Copyright (C) 2016 Stefano Fondi

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

#ifndef qla_piecewiseyieldcurve_hpp
#define qla_piecewiseyieldcurve_hpp

#include <qlo/objects/termstructures/yieldtermstructures.hpp>
#include <qlo/objects/objmanual_ratehelpers.hpp>

namespace QuantLibAddin {

    // A wrapper for QuantLib template class PiecewiseYieldCurve<Traits, Interpolator>.
    // Calls to constructor/member functions must specify values for Traits and Interpolator
    // because it is not possible to expose a template class directly to client platforms
    // such as Excel.
    class PiecewiseYieldCurve : public YieldTermStructure {
      public:
        PiecewiseYieldCurve(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            QuantLib::Natural nDays,
            const QuantLib::Calendar& calendar,
            const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& qlrhs,
            const QuantLib::DayCounter& dayCounter,
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& jumps,
            const std::vector<QuantLib::Date>& jumpDates,
            QuantLib::Real accuracy,
            const std::string& traitsID,
            const std::string& interpolatorID,
            const QuantLib::MixedInterpolation::Behavior behavior,
            const QuantLib::Size n,
            bool permanent);
        PiecewiseYieldCurve(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            QuantLib::Natural nDays,
            const QuantLib::Calendar& calendar,
            const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& qlrhs,
            const QuantLib::DayCounter& dayCounter,
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& jumps,
            const std::vector<QuantLib::Date>& jumpDates,
            QuantLib::Real accuracy,
            const std::string& traitsID,
            const std::string& interpolatorID,
            bool permanent);
        const std::vector<QuantLib::Time>& times() const;

        const std::vector<QuantLib::Date>& dates() const;

        const std::vector<QuantLib::Real>& data() const;

        //const std::vector<QuantLib::Real>& improvements() const;

        //QuantLib::Size iterations() const;

        InterpolatedYieldCurvePair interpolatedYieldCurvePair() const {
            return pair_;
        }

        const std::vector<QuantLib::Time>& jumpTimes() const;

        const std::vector<QuantLib::Date>& jumpDates() const;

	private:
		InterpolatedYieldCurvePair pair_;

    };

}

#endif
