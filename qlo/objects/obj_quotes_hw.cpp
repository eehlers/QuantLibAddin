/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006 Francois du Vignaud
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


#include <qlo/objects/obj_quotes.hpp>
#include <ql/quotes/compositequote.hpp>
#include <ql/quotes/simplequote.hpp>
#include <ql/quotes/derivedquote.hpp>
#include <ql/quotes/eurodollarfuturesquote.hpp>
#include <ql/quotes/forwardvaluequote.hpp>
#include <ql/quotes/forwardswapquote.hpp>
#include <ql/quotes/futuresconvadjustmentquote.hpp>
#include <ql/quotes/impliedstddevquote.hpp>
#include <ql/quotes/lastfixingquote.hpp>
#include <ql/experimental/risk/sensitivityanalysis.hpp>
#include <ql/termstructures/volatility/optionlet/optionletstripper.hpp>

namespace {

    QuantLib::Real minus(QuantLib::Real x, QuantLib::Real y) { return x-y; }
    QuantLib::Real plus(QuantLib::Real x, QuantLib::Real y) { return x+y; }
}

QuantLibAddin::SimpleQuote::SimpleQuote(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        QuantLib::Real value,
        QuantLib::Real tickValue,
        bool permanent) : QuantLibAddin::Quote(properties, permanent) {
    // The base class requires us to store a reference
    // to a QuantLib::Quote in libraryObject_.
    // For performance reasons we also store a reference to
    // QuantLib::SimpleQuote in simpleQuote_, without this we would have to
    // do a pointer cast on every call to QuantLibAddin::SimpleQuote::setValue().
    libraryObject_ = simpleQuote_ = boost::shared_ptr<QuantLib::SimpleQuote>(
        new QuantLib::SimpleQuote(value));
}

QuantLib::Real QuantLibAddin::SimpleQuote::tickValue() const {
    return boost::get<double>(propertyValue("TickValue"));
}

void QuantLibAddin::SimpleQuote::setTickValue(QuantLib::Real tickValue) {
    properties()->setProperty("TickValue", tickValue);
}

// QuantLibAddin::SimpleQuote::setValue() wraps QuantLib::SimpleQuote::setValue(),
// updating the ValueObject.  The "Value" property of the ValueObject is represented
// as datatype reposit::Variant (rather than double), this is necessary for
// platform-independent processing of value Null<Real>.
QuantLib::Real QuantLibAddin::SimpleQuote::setValue(QuantLib::Real value) {

    QuantLib::Real change;

    try {
        change = simpleQuote_->setValue(value);
    } catch (...) {
        // In the event of an exception, ensure that the ValueObject remains in synch with
        // the simpleQuote_ before rethrowing.
        // If QuantLib::SimpleQuote::isValid() is false then QuantLib::SimpleQuote::value() throws,
        // which here in the catch clause would cause the app to crash, so test for that case.
        if (simpleQuote_->isValid())
            properties()->setProperty("Value", simpleQuote_->value());
        else
            properties()->setProperty("Value", static_cast<double>(QuantLib::Null<QuantLib::Real>()));
        throw;
    }

    if (change!=0.0)
        properties()->setProperty("Value", value);

    return change;
}

void QuantLibAddin::SimpleQuote::reset() {
    simpleQuote_->reset();
}

QuantLibAddin::ForwardValueQuote::ForwardValueQuote(
    const boost::shared_ptr<reposit::ValueObject>& properties,
    const boost::shared_ptr<QuantLib::IborIndex>& index,
    const QuantLib::Date& fixingDate,
    bool permanent) : QuantLibAddin::Quote(properties, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new
        QuantLib::ForwardValueQuote(index, fixingDate));
}

QuantLibAddin::ForwardSwapQuote::ForwardSwapQuote(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const boost::shared_ptr<QuantLib::SwapIndex>& swapIndex,
        const QuantLib::Handle<QuantLib::Quote>& spread,
        const QuantLib::Period& fwdStart,
        bool permanent) : QuantLibAddin::Quote(properties, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new
        QuantLib::ForwardSwapQuote(swapIndex, spread, fwdStart));
}

QuantLibAddin::ImpliedStdDevQuote::ImpliedStdDevQuote(
                        const boost::shared_ptr<reposit::ValueObject>& properties,
                        QuantLib::Option::Type optionType,
                        const QuantLib::Handle<QuantLib::Quote>& forward,
                        const QuantLib::Handle<QuantLib::Quote>& price,
                        QuantLib::Real strike,
                        QuantLib::Real guess,
                        QuantLib::Real accuracy,
                        bool permanent) : QuantLibAddin::Quote(properties, permanent)
{
libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new
    QuantLib::ImpliedStdDevQuote(optionType, forward, price, strike,
                                 guess, accuracy));
}

QuantLibAddin::EurodollarFuturesImpliedStdDevQuote::EurodollarFuturesImpliedStdDevQuote(
                    const boost::shared_ptr<reposit::ValueObject>& properties,
                    const QuantLib::Handle<QuantLib::Quote>& forward,
                    const QuantLib::Handle<QuantLib::Quote>& callPrice,
                    const QuantLib::Handle<QuantLib::Quote>& putPrice,
                    QuantLib::Real strike,
                    QuantLib::Real guess,
                    QuantLib::Real accuracy,
                    bool permanent) : QuantLibAddin::Quote(properties, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new
        QuantLib::EurodollarFuturesImpliedStdDevQuote(forward,
            callPrice, putPrice, strike, guess, accuracy));
}

QuantLibAddin::FuturesConvAdjustmentQuote::FuturesConvAdjustmentQuote(
                           const boost::shared_ptr<reposit::ValueObject>& properties,
                           const boost::shared_ptr<QuantLib::IborIndex>& index,
                           const std::string& immCode,
                           const QuantLib::Handle<QuantLib::Quote>& futuresQuote,
                           const QuantLib::Handle<QuantLib::Quote>& volatility,
                           const QuantLib::Handle<QuantLib::Quote>& meanReversion,
                           bool permanent) : QuantLibAddin::Quote(properties, permanent)
{
    libraryObject_ = futuresConvAdjustmentQuote_ = boost::shared_ptr<QuantLib::FuturesConvAdjustmentQuote>(new
        QuantLib::FuturesConvAdjustmentQuote(index, immCode,
                                             futuresQuote,
                                             volatility,
                                             meanReversion));
}

QuantLib::Real QuantLibAddin::FuturesConvAdjustmentQuote::futuresValue() const
{
    return futuresConvAdjustmentQuote_->futuresValue();
}

QuantLib::Real QuantLibAddin::FuturesConvAdjustmentQuote::volatility() const
{
    return futuresConvAdjustmentQuote_->volatility();
}

QuantLib::Real QuantLibAddin::FuturesConvAdjustmentQuote::meanReversion() const
{
    return futuresConvAdjustmentQuote_->meanReversion();
}

QuantLib::Date QuantLibAddin::FuturesConvAdjustmentQuote::immDate() const
{
    return futuresConvAdjustmentQuote_->immDate();
}

QuantLibAddin::CompositeQuote::CompositeQuote(
                const boost::shared_ptr<reposit::ValueObject>& properties,
                const QuantLib::Handle<QuantLib::Quote>& element1,
                const QuantLib::Handle<QuantLib::Quote>& element2,
                const std::string& op,
                bool permanent) : QuantLibAddin::Quote(properties, permanent)
{

    typedef QuantLib::Real (*binary_f)(QuantLib::Real, QuantLib::Real);
    if (op=="-")
        libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new
            QuantLib::CompositeQuote<binary_f>(element1, element2, minus));
    else if (op=="+")
        libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new
            QuantLib::CompositeQuote<binary_f>(element1, element2, plus));
    else
        QL_FAIL("unknow operator " << op);
}

QuantLibAddin::LastFixingQuote::LastFixingQuote(
                const boost::shared_ptr<reposit::ValueObject>& p,
                const boost::shared_ptr<QuantLib::Index>& index,
                bool permanent) : QuantLibAddin::Quote(p, permanent)
{
    libraryObject_ = lastFixingQuote_ = boost::shared_ptr<QuantLib::LastFixingQuote>(new
        QuantLib::LastFixingQuote(index));
}

QuantLib::Date QuantLibAddin::LastFixingQuote::referenceDate() const
{
    return lastFixingQuote_->referenceDate();
}

std::vector<std::vector<QuantLib::Real> >
QuantLibAddin::bucketAnalysis(const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& q,
               const std::vector<boost::shared_ptr<QuantLib::Instrument> >& instr,
               const std::vector<QuantLib::Real>& quant,
               QuantLib::Real shift,
               QuantLib::SensitivityAnalysis type)
{
    std::pair<std::vector<std::vector<QuantLib::Real> >, std::vector<std::vector<QuantLib::Real> > > result;
    std::vector<std::vector<QuantLib::Handle<QuantLib::SimpleQuote> > > sq(q.size());
    for (QuantLib::Size i=0; i<q.size(); ++i) {
        sq[i] = std::vector<QuantLib::Handle<QuantLib::SimpleQuote> >(q[i].size());
        for (QuantLib::Size j=0; j<q[i].size(); ++j) {
            boost::shared_ptr<QuantLib::Quote> t(q[i][j].currentLink());
            boost::shared_ptr<QuantLib::SimpleQuote> tt =
                boost::dynamic_pointer_cast<QuantLib::SimpleQuote>(t);
            sq[i][j] = QuantLib::Handle<QuantLib::SimpleQuote>(tt);
        }
    }
    result = QuantLib::bucketAnalysis(sq, instr, quant, shift, type);
    return result.first;
}

std::vector<QuantLib::Real>
QuantLibAddin::bucketAnalysisDelta(const QuantLib::Handle<QuantLib::SimpleQuote>& quote,
                    const std::vector<QuantLib::Handle<QuantLib::Quote> >& parameters,
                    QuantLib::Real shift,
                    QuantLib::SensitivityAnalysis type) {
    std::vector<QuantLib::Real> deltaVector;
    std::vector<QuantLib::Real> gammaVector;
    std::vector<QuantLib::Real> refVals;
    QuantLib::bucketAnalysis(deltaVector, gammaVector, refVals,
                             quote, parameters, shift, type);
    return deltaVector;
}

std::vector<std::vector<QuantLib::Real> >
QuantLibAddin::bucketAnalysisDelta2(const std::vector<QuantLib::Handle<QuantLib::Quote> >& quotes,
                     const std::vector<QuantLib::Handle<QuantLib::Quote> >& parameters,
                     QuantLib::Real shift,
                     QuantLib::SensitivityAnalysis type) {
    std::vector<std::vector<QuantLib::Real> > deltaMatrix;
    std::vector<std::vector<QuantLib::Real> > gammamatrix;

    QuantLib::Size n = quotes.size();
    std::vector<QuantLib::Handle<QuantLib::SimpleQuote> > simpleQuotes(n);
    for (QuantLib::Size i=0; i<n;  ++i) {
        boost::shared_ptr<QuantLib::SimpleQuote> sq = 
            boost::dynamic_pointer_cast<QuantLib::SimpleQuote>(quotes[i].currentLink());
        simpleQuotes[i] = QuantLib::Handle<QuantLib::SimpleQuote>(sq);
    }
    QuantLib::bucketAnalysis(deltaMatrix, gammamatrix,
                             simpleQuotes, parameters, shift, type);
    return deltaMatrix;
}

