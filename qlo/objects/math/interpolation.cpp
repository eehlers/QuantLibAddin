/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2007, 2009, 2010 Ferdinando Ametrano

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
#include <qlo/objects/math/interpolation.hpp>
#include <qlo/enumerations/factories/interpolationsfactory.hpp>

#include <ql/math/interpolations/linearinterpolation.hpp>
#include <ql/math/interpolations/backwardflatinterpolation.hpp>
#include <ql/math/interpolations/forwardflatinterpolation.hpp>

// fix for gcc
#ifdef __GNUC__
namespace QuantLib {
    const Size QuantLib::Cubic::requiredPoints;
    const Size QuantLib::Linear::requiredPoints;
};
#endif

namespace {
    class QuoteHandleSorter {
      public:
        bool operator()(const std::pair<QuantLib::Real, QuantLib::Handle<QuantLib::Quote> >& h1,
                const std::pair<QuantLib::Real, QuantLib::Handle<QuantLib::Quote> >& h2) const {
            if (h1.first >= h2.first)
                return false;
            return true;
        }
    };
}

QuantLibAddin::Interpolation::Interpolation(const boost::shared_ptr<reposit::ValueObject>& prop,
                             const std::vector<QuantLib::Real>& x,
                             const std::vector<QuantLib::Handle<QuantLib::Quote> >& yh,
                             bool permanent)
: Extrapolator(prop, permanent)
{
    QL_REQUIRE(!x.empty(), "empty x vector");
    QuantLib::Size n = x.size();
    QL_REQUIRE(n==yh.size(),
               "unmatched size between x (" << n << ") and y(" <<
               yh.size() << ")");
    x_.reserve(n);
    yh_.reserve(n);
    y_.reserve(n);

    std::vector<std::pair<QuantLib::Real, QuantLib::Handle<QuantLib::Quote> > > pairs(n);
    for (QuantLib::Size i=0; i<n; ++i)
        pairs[i] = std::make_pair(x[i], yh[i]);
    std::sort(pairs.begin(), pairs.end(), QuoteHandleSorter());

    std::vector<std::pair<QuantLib::Real, QuantLib::Handle<QuantLib::Quote> > >::iterator j=pairs.begin();
    x_.push_back(j->first);
    yh_.push_back(j->second);
    registerWith(yh_.back());
    yh_.back()->isValid() ? y_.push_back(yh_.back()->value())
                          : y_.push_back(1.0);
    for (j=pairs.begin()+1; j<pairs.end(); ++j) {
        if (x_.back() == j->first) {
            QL_ENSURE(yh_.back() == j->second,
                      "duplicated x value (" << j->first <<
                      ") with different y values");
        } else {
            x_.push_back(j->first);
            yh_.push_back(j->second);
            registerWith(yh_.back());
            yh_.back()->isValid() ? y_.push_back(yh_.back()->value())
                                  : y_.push_back(1.0);
        }
    }
    n_ = x_.size();
}

void QuantLibAddin::Interpolation::performCalculations() const {
    for (QuantLib::Size i=0; i<n_; ++i)
        y_[i] = yh_[i]->value();
    qlInterpolation_->update();
}

QuantLibAddin::GenericInterp::GenericInterp(const boost::shared_ptr<reposit::ValueObject>& p,
                             const std::string& type,
                             const std::vector<QuantLib::Real>& x,
                             const std::vector<QuantLib::Handle<QuantLib::Quote> >& yh,
                             bool permanent)
: Interpolation(p, x, yh, permanent)
{
    libraryObject_ = reposit::Create<boost::shared_ptr<QuantLib::Interpolation> >()
        (type, x_.begin(), x_.end(), y_.begin());
    qlInterpolation_ = boost::dynamic_pointer_cast<QuantLib::Interpolation>(
        libraryObject_);
}

QuantLibAddin::MixedLinearCubicInterpolation::MixedLinearCubicInterpolation(
    const boost::shared_ptr<reposit::ValueObject>& properties,
    const std::vector<QuantLib::Real>& x,
    const std::vector<QuantLib::Handle<QuantLib::Quote> >& yh,
    QuantLib::Size n,
    QuantLib::CubicInterpolation::DerivativeApprox da,
    bool monotonic,
    QuantLib::CubicInterpolation::BoundaryCondition leftCondition,
    QuantLib::Real leftValue,
    QuantLib::CubicInterpolation::BoundaryCondition rightCondition,
    QuantLib::Real rightValue,
    bool permanent)
: Interpolation(properties, x, yh, permanent)
{
    // This constructor does not compile under gcc because of problems with
    // static const template arguments.
#ifdef __GNUC__
    QL_FAIL("class QuantLibAddin::MixedLinearCubicInterpolation is not "
        "supported under gcc");
#else
    libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
        QuantLib::MixedLinearCubicInterpolation(
                                            x_.begin(), x_.end(),
                                            y_.begin(), n,
                                            da, monotonic,
                                            leftCondition, leftValue,
                                            rightCondition, rightValue));
    qlInterpolation_ =
        boost::dynamic_pointer_cast<QuantLib::Interpolation>(libraryObject_);
    qlMixedLinearCubicInterpolation_ =
        boost::dynamic_pointer_cast<QuantLib::MixedLinearCubicInterpolation>(libraryObject_);
#endif
}

QuantLibAddin::CubicInterpolation::CubicInterpolation(
    const boost::shared_ptr<reposit::ValueObject>& properties,
    const std::vector<QuantLib::Real>& x,
    const std::vector<QuantLib::Handle<QuantLib::Quote> >& yh,
    QuantLib::CubicInterpolation::DerivativeApprox da,
    bool monotonic,
    QuantLib::CubicInterpolation::BoundaryCondition leftCondition,
    QuantLib::Real leftValue,
    QuantLib::CubicInterpolation::BoundaryCondition rightCondition,
    QuantLib::Real rightValue,
    bool permanent)
: Interpolation(properties, x, yh, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
        QuantLib::CubicInterpolation(x_.begin(), x_.end(),
                                     y_.begin(),
                                     da, monotonic,
                                     leftCondition, leftValue,
                                     rightCondition, rightValue));
    qlInterpolation_ = boost::dynamic_pointer_cast<QuantLib::Interpolation>(
        libraryObject_);
    qlCubicInterpolation_ = boost::dynamic_pointer_cast<QuantLib::CubicInterpolation>(
        libraryObject_);
}

QuantLibAddin::AbcdInterpolation::AbcdInterpolation(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::vector<QuantLib::Real>& x,
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& yh,
        QuantLib::Real a,
        QuantLib::Real b,
        QuantLib::Real c,
        QuantLib::Real d,
        bool aIsFixed,
        bool bIsFixed,
        bool cIsFixed,
        bool dIsFixed,
        bool vegaWeighted,
        const boost::shared_ptr<QuantLib::EndCriteria>& ec,
        const boost::shared_ptr<QuantLib::OptimizationMethod>& om,
        bool permanent)
: Interpolation(properties, x, yh, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
        QuantLib::AbcdInterpolation(x_.begin(), x_.end(), y_.begin(),
                                    a, b, c, d,
                                    aIsFixed, bIsFixed, cIsFixed, dIsFixed,
                                    vegaWeighted,
                                    ec, om));
    qlInterpolation_ = boost::dynamic_pointer_cast<QuantLib::Interpolation>(
        libraryObject_);
    qlAbcdInterpolation_ = boost::dynamic_pointer_cast<QuantLib::AbcdInterpolation>(
        libraryObject_);
}

QuantLibAddin::SABRInterpolation::SABRInterpolation(
                                const boost::shared_ptr<reposit::ValueObject>& p,
                                const std::vector<QuantLib::Real>& x,
                                const std::vector<QuantLib::Handle<QuantLib::Quote> >& yh,
                                QuantLib::Time t,
                                const QuantLib::Handle<QuantLib::Quote>& forwardh,
                                QuantLib::Real alpha,
                                QuantLib::Real beta,
                                QuantLib::Real nu,
                                QuantLib::Real rho,
                                bool isAlphaFixed,
                                bool isBetaFixed,
                                bool isNuFixed,
                                bool isRhoFixed,
                                bool vegaWeighted,
                                const boost::shared_ptr<QuantLib::EndCriteria>& ec,
                                const boost::shared_ptr<QuantLib::OptimizationMethod>& om,
                                bool permanent)
: Interpolation(p, x, yh, permanent), forwardh_(forwardh), forward_(0.01)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
        QuantLib::SABRInterpolation(x_.begin(), x_.end(), y_.begin(),
                                    t, forward_, alpha, beta, nu, rho,
                                    isAlphaFixed, isBetaFixed,
                                    isNuFixed, isRhoFixed,
                                    vegaWeighted,
                                    ec, om));
    qlInterpolation_ = boost::dynamic_pointer_cast<QuantLib::Interpolation>(
        libraryObject_);
    qlSABRInterpolation_ = boost::dynamic_pointer_cast<QuantLib::SABRInterpolation>(
        libraryObject_);
}
