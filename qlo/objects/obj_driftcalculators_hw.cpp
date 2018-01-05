/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
Copyright (C) 2006, 2007 Ferdinando Ametrano
Copyright (C) 2007 Chiara Fornarola
Copyright (C) 2006, 2007 Marco Bianchetti
Copyright (C) 2006, 2007 Cristina Duminuco
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

#if defined(HAVE_CONFIG_H)     // Dynamically created by configure
#include <qlo/config.hpp>
#endif

#include <qlo/objects/obj_driftcalculators.hpp>
#include <ql/models/marketmodels/driftcomputation/lmmdriftcalculator.hpp>
#include <ql/models/marketmodels/driftcomputation/cmsmmdriftcalculator.hpp>
#include <ql/models/marketmodels/driftcomputation/lmmnormaldriftcalculator.hpp>
#include <ql/models/marketmodels/driftcomputation/smmdriftcalculator.hpp>

#include <qlo/objects/obj_curvestate.hpp>
#include <ql/models/marketmodels/curvestates/cmswapcurvestate.hpp>
#include <ql/models/marketmodels/curvestates/coterminalswapcurvestate.hpp>
#include <ql/models/marketmodels/curvestates/lmmcurvestate.hpp>

    QuantLibAddin::LMMDriftCalculator::LMMDriftCalculator(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        // BEGIN typemap rp_tm_default
        QuantLib::Matrix const &Pseudo_square_root,
        std::vector< QuantLib::Spread > const &Displacements,
        std::vector< QuantLib::Time > const &Taus,
        QuantLib::Size Numeraire,
        QuantLib::Size Alive,
        // END   typemap rp_tm_default
        bool permanent)
        : reposit::LibraryObject<QuantLib::LMMDriftCalculator>(properties, permanent), drifts_(Taus.size()) {
        libraryObject_ = boost::shared_ptr<QuantLib::LMMDriftCalculator>(new QuantLib::LMMDriftCalculator(
            // BEGIN typemap rp_tm_default
            Pseudo_square_root,
            Displacements,
            Taus,
            Numeraire,
            Alive
            // END   typemap rp_tm_default
        ));
    }

    std::vector<QuantLib::Real> QuantLibAddin::LMMDriftCalculator::compute(
        const QuantLib::LMMCurveState& cs) const {
        libraryObject_->compute(cs, drifts_);
        return drifts_;
    }

    std::vector<QuantLib::Real> QuantLibAddin::LMMDriftCalculator::computePlain(
        const QuantLib::LMMCurveState& cs) const {
        libraryObject_->computePlain(cs, drifts_);
        return drifts_;
    }

    std::vector<QuantLib::Real> QuantLibAddin::LMMDriftCalculator::computeReduced(
        const QuantLib::LMMCurveState& cs) const {
        libraryObject_->computeReduced(cs, drifts_);
        return drifts_;
    }

    QuantLibAddin::LMMNormalDriftCalculator::LMMNormalDriftCalculator(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        // BEGIN typemap rp_tm_default
        QuantLib::Matrix const &Pseudo_square_root,
        std::vector< QuantLib::Time > const &Taus,
        QuantLib::Size Numeraire,
        QuantLib::Size Alive,
        // END   typemap rp_tm_default
        bool permanent)
        : reposit::LibraryObject<QuantLib::LMMNormalDriftCalculator>(properties, permanent), drifts_(Taus.size()) {
        libraryObject_ = boost::shared_ptr<QuantLib::LMMNormalDriftCalculator>(new QuantLib::LMMNormalDriftCalculator(
            // BEGIN typemap rp_tm_default
            Pseudo_square_root,
            Taus,
            Numeraire,
            Alive
            // END   typemap rp_tm_default
        ));
    }

    std::vector<QuantLib::Real> QuantLibAddin::LMMNormalDriftCalculator::compute(
        const QuantLib::LMMCurveState& cs) const {
        libraryObject_->compute(cs, drifts_);
        return drifts_;
    }

    std::vector<QuantLib::Real> QuantLibAddin::LMMNormalDriftCalculator::computePlain(
        const QuantLib::LMMCurveState& cs) const {
        libraryObject_->computePlain(cs, drifts_);
        return drifts_;
    }

    std::vector<QuantLib::Real> QuantLibAddin::LMMNormalDriftCalculator::computeReduced(
        const QuantLib::LMMCurveState& cs) const {
        libraryObject_->computeReduced(cs, drifts_);
        return drifts_;
    }

    QuantLibAddin::CMSMMDriftCalculator::CMSMMDriftCalculator(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        // BEGIN typemap rp_tm_default
        QuantLib::Matrix const &Pseudo_square_root,
        std::vector< QuantLib::Spread > const &Displacements,
        std::vector< QuantLib::Time > const &Taus,
        QuantLib::Size Numeraire,
        QuantLib::Size Alive,
        QuantLib::Size SpanningFwds,
        // END   typemap rp_tm_default
        bool permanent)
        : reposit::LibraryObject<QuantLib::CMSMMDriftCalculator>(properties, permanent), drifts_(Taus.size()) {
        libraryObject_ = boost::shared_ptr<QuantLib::CMSMMDriftCalculator>(new QuantLib::CMSMMDriftCalculator(
            // BEGIN typemap rp_tm_default
            Pseudo_square_root,
            Displacements,
            Taus,
            Numeraire,
            Alive,
            SpanningFwds
            // END   typemap rp_tm_default
        ));
    }

    std::vector<QuantLib::Real> QuantLibAddin::CMSMMDriftCalculator::compute(
        const QuantLib::CMSwapCurveState& cs) const {
        libraryObject_->compute(cs, drifts_);
        return drifts_;
    }

    QuantLibAddin::SMMDriftCalculator::SMMDriftCalculator(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        // BEGIN typemap rp_tm_default
        QuantLib::Matrix const &Pseudo_square_root,
        std::vector< QuantLib::Spread > const &Displacements,
        std::vector< QuantLib::Time > const &Taus,
        QuantLib::Size Numeraire,
        QuantLib::Size Alive,
        // END   typemap rp_tm_default
        bool permanent)
        : reposit::LibraryObject<QuantLib::SMMDriftCalculator>(properties, permanent), drifts_(Taus.size()) {
        libraryObject_ = boost::shared_ptr<QuantLib::SMMDriftCalculator>(new QuantLib::SMMDriftCalculator(
            // BEGIN typemap rp_tm_default
            Pseudo_square_root,
            Displacements,
            Taus,
            Numeraire,
            Alive
            // END   typemap rp_tm_default
        ));
    }

    std::vector<QuantLib::Real> QuantLibAddin::SMMDriftCalculator::compute(
        const QuantLib::CoterminalSwapCurveState& cs) const {
        libraryObject_->compute(cs, drifts_);
        return drifts_;
    }

