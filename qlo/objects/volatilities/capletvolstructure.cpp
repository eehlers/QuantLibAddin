/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006 Ferdinando Ametrano
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

#if defined(HAVE_CONFIG_H)
    #include <qlo/config.hpp>
#endif

#include <qlo/objects/volatilities/capletvolstructure.hpp>

#include <ql/termstructures/volatility/optionlet/constantoptionletvol.hpp>
#include <ql/termstructures/volatility/optionlet/spreadedoptionletvol.hpp>
#include <ql/termstructures/volatility/capfloor/capfloortermvolcurve.hpp>
#include <ql/termstructures/volatility/capfloor/capfloortermvolsurface.hpp>
#include <ql/termstructures/volatility/optionlet/strippedoptionletadapter.hpp>
#include <ql/termstructures/volatility/optionlet/optionletstripper1.hpp>
#include <ql/termstructures/volatility/optionlet/optionletstripper2.hpp>
#include <ql/termstructures/volatility/optionlet/strippedoptionlet.hpp>

using std::vector;
using QuantLib::Handle;
using QuantLib::Quote;
using QuantLib::BusinessDayConvention;
using boost::shared_ptr;
using reposit::ValueObject;
using reposit::LibraryObject;

namespace QuantLibAddin {

    ConstantOptionletVolatility::ConstantOptionletVolatility(
                                    const shared_ptr<ValueObject>& properties,
                                    QuantLib::Natural settlementDays,
                                    const QuantLib::Calendar& cal,
                                    BusinessDayConvention bdc,
                                    const Handle<Quote>& volatility,
                                    const QuantLib::DayCounter& dayCounter,
                                    QuantLib::VolatilityType type,
                                    QuantLib::Real shift,
                                    bool permanent)
    : OptionletVolatilityStructure(properties, permanent)
    {
        libraryObject_ = shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::ConstantOptionletVolatility(settlementDays,
                                                  cal,
                                                  bdc,
                                                  volatility,
                                                  dayCounter,
                                                  type,
                                                  shift));
    }

    SpreadedOptionletVolatility::SpreadedOptionletVolatility(
                const shared_ptr<ValueObject>& properties,
                const Handle<QuantLib::OptionletVolatilityStructure>& baseVol,
                const Handle<Quote>& spread,
                bool permanent)
    : OptionletVolatilityStructure(properties, permanent)
    {
        libraryObject_ = shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::SpreadedOptionletVolatility(baseVol,
                                                  spread));
    }

    StrippedOptionletAdapter::StrippedOptionletAdapter(
                        const shared_ptr<ValueObject>& properties,
                        const shared_ptr<QuantLib::StrippedOptionletBase>& v,
                        bool permanent)
    : OptionletVolatilityStructure(properties, permanent)
    {
        libraryObject_ = shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::StrippedOptionletAdapter(v));
    }

    CapFloorTermVolCurve::CapFloorTermVolCurve(
                                const shared_ptr<ValueObject>& properties,
                                QuantLib::Natural settlementDays,
                                const QuantLib::Calendar& calendar,
                                BusinessDayConvention bdc,
                                const vector<QuantLib::Period>& optionTenors,
                                const vector<Handle<Quote> >& vols,
                                const QuantLib::DayCounter& dc,
                                bool permanent)
    : CapFloorTermVolatilityStructure(properties, permanent)
    {
       libraryObject_ = shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::CapFloorTermVolCurve(settlementDays,
                                           calendar,
                                           bdc,
                                           optionTenors,
                                           vols,
                                           dc));
    }

    CapFloorTermVolSurface::CapFloorTermVolSurface(
                                const shared_ptr<ValueObject>& properties,
                                QuantLib::Natural settlementDays,
                                const QuantLib::Calendar& calendar,
                                BusinessDayConvention bdc,
                                const vector<QuantLib::Period>& optionLengths,
                                const vector<QuantLib::Rate>& strikes,
                                const vector<vector<Handle<Quote> > >& vols,
                                const QuantLib::DayCounter& dc,
                                bool permanent)
    : CapFloorTermVolatilityStructure(properties, permanent)
    {
        libraryObject_ = shared_ptr<QuantLib::Extrapolator>(new
            QuantLib::CapFloorTermVolSurface(settlementDays,
                                             calendar,
                                             bdc,
                                             optionLengths,
                                             strikes,
                                             vols,
                                             dc));
    }

    StrippedOptionlet::StrippedOptionlet(
                                const shared_ptr<ValueObject>& properties,
                                QuantLib::Natural settlementDays,
                                const QuantLib::Calendar& calendar,
                                BusinessDayConvention businessDayConvention,
                                const shared_ptr<QuantLib::IborIndex>& index,
                                const vector<QuantLib::Date>& optionletDates,
                                const vector<QuantLib::Rate>& strikes,
                                const vector<vector<Handle<Quote> > >& vols,
                                const QuantLib::DayCounter& dc,
                                QuantLib::VolatilityType type,
                                QuantLib::Real shift,
                                bool permanent)
    : StrippedOptionletBase(properties, permanent)
    {
        libraryObject_ = shared_ptr<QuantLib::StrippedOptionlet>(new
            QuantLib::StrippedOptionlet(settlementDays,
                                        calendar,
                                        businessDayConvention,
                                        index,
                                        optionletDates,
                                        strikes,
                                        vols,
                                        dc,
                                        type,
                                        shift));
    }

    OptionletStripper1::OptionletStripper1(
                        const shared_ptr<ValueObject>& properties,
                        const shared_ptr<QuantLib::CapFloorTermVolSurface>& s,
                        const shared_ptr<QuantLib::IborIndex>& index,
                        QuantLib::Rate switchStrike,
                        QuantLib::Real accuracy,
                        QuantLib::Natural maxIterations,
                        QuantLib::VolatilityType type,
                        QuantLib::Real shift,
                        bool permanent)
    : OptionletStripper(properties, permanent)
    {
        libraryObject_ = shared_ptr<QuantLib::OptionletStripper1>(new
            QuantLib::OptionletStripper1(s,
                                         index,
                                         switchStrike,
                                         accuracy,
                                         maxIterations,
                                         QuantLib::Handle<QuantLib::YieldTermStructure>(),
                                         type,
                                         shift));
    }

    OptionletStripper2::OptionletStripper2(
                    const shared_ptr<ValueObject>& properties,
                    const shared_ptr<QuantLib::OptionletStripper1>& o,
                    const Handle<QuantLib::CapFloorTermVolCurve>& atmV,
                    bool permanent)
    : OptionletStripper(properties, permanent)
    {
        libraryObject_ = shared_ptr<QuantLib::OptionletStripper2>(new
            QuantLib::OptionletStripper2(o,
                                         atmV));
    }

}
