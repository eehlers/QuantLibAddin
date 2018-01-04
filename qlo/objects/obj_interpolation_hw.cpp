
#include <qlo/objects/obj_interpolation.hpp>
//#include <qlo/objects/obj_optimization.hpp>
#include <qlo/enumerations/factories/interpolationsfactory.hpp>

#include <ql/math/interpolations/linearinterpolation.hpp>
#include <ql/math/interpolations/backwardflatinterpolation.hpp>
#include <ql/math/interpolations/forwardflatinterpolation.hpp>
#include <ql/math/interpolations/bilinearinterpolation.hpp>
#include <ql/math/interpolations/bicubicsplineinterpolation.hpp>

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
QuantLib::Real QuantLibAddin::Interpolation::operator()(QuantLib::Real x,
                          bool allowExtrapolation) const {
    calculate();
    return qlInterpolation_->operator()(x, allowExtrapolation);
}
QuantLib::Real QuantLibAddin::Interpolation::primitive(QuantLib::Real x,
                         bool allowExtrapolation) const {
    calculate();
    return qlInterpolation_->primitive(x, allowExtrapolation);
}
QuantLib::Real QuantLibAddin::Interpolation::derivative(QuantLib::Real x,
                          bool allowExtrapolation) const {
    calculate();
    return qlInterpolation_->derivative(x, allowExtrapolation);
}
QuantLib::Real QuantLibAddin::Interpolation::secondDerivative(QuantLib::Real x,
                                bool allowExtrapolation) const {
    calculate();
    return qlInterpolation_->secondDerivative(x, allowExtrapolation);
}

void QuantLibAddin::Interpolation::performCalculations() const {
    for (QuantLib::Size i=0; i<n_; ++i)
        y_[i] = yh_[i]->value();
    qlInterpolation_->update();
}

QuantLibAddin::GenericInterp::GenericInterp(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::string const &InterpolationType,
            std::vector< QuantLib::Real > const &XArray,
            std::vector< QuantLib::Handle< QuantLib::Quote > > const &YArray,
            // END   typemap rp_tm_default
    bool permanent) : Interpolation(properties, XArray, YArray, permanent)
{
    libraryObject_ = reposit::Create<boost::shared_ptr<QuantLib::Interpolation> >()
        (InterpolationType, x_.begin(), x_.end(), y_.begin());
    qlInterpolation_ = boost::dynamic_pointer_cast<QuantLib::Interpolation>(
        libraryObject_);
}

QuantLibAddin::MixedLinearCubicInterpolation::MixedLinearCubicInterpolation(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Real > const &XArray,
            std::vector< QuantLib::Handle< QuantLib::Quote > > const &YArray,
            QuantLib::Size SwitchIndex,
			QuantLib::MixedInterpolation::Behavior behavior,
            QuantLib::CubicInterpolation::DerivativeApprox DerApprox,
            bool Monotonic,
            QuantLib::CubicInterpolation::BoundaryCondition LeftConditionType,
            QuantLib::Real LeftConditionValue,
            QuantLib::CubicInterpolation::BoundaryCondition RightConditionType,
            QuantLib::Real RightConditionValue,
            // END   typemap rp_tm_default
    bool permanent)
: Interpolation(properties, XArray, YArray, permanent)
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
                                            y_.begin(), SwitchIndex, behavior,
                                            DerApprox, Monotonic,
                                            LeftConditionType, LeftConditionValue,
                                            RightConditionType, RightConditionValue));
    qlInterpolation_ =
        boost::dynamic_pointer_cast<QuantLib::Interpolation>(libraryObject_);
    qlMixedLinearCubicInterpolation_ =
        boost::dynamic_pointer_cast<QuantLib::MixedLinearCubicInterpolation>(libraryObject_);
#endif
}

QuantLibAddin::CubicInterpolation::CubicInterpolation(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Real > const &XArray,
            std::vector< QuantLib::Handle< QuantLib::Quote > > const &YArray,
            QuantLib::CubicInterpolation::DerivativeApprox DerApprox,
            bool Monotonic,
            QuantLib::CubicInterpolation::BoundaryCondition LeftConditionType,
            QuantLib::Real LeftConditionValue,
            QuantLib::CubicInterpolation::BoundaryCondition RightConditionType,
            QuantLib::Real RightConditionValue,
            // END   typemap rp_tm_default
    bool permanent)
: Interpolation(properties, XArray, YArray, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
        QuantLib::CubicInterpolation(x_.begin(), x_.end(),
                                     y_.begin(),
                                     DerApprox, Monotonic,
                                     LeftConditionType, LeftConditionValue,
                                     RightConditionType, RightConditionValue));
    qlInterpolation_ = boost::dynamic_pointer_cast<QuantLib::Interpolation>(
        libraryObject_);
    qlCubicInterpolation_ = boost::dynamic_pointer_cast<QuantLib::CubicInterpolation>(
        libraryObject_);
}
const std::vector<QuantLib::Real>& QuantLibAddin::CubicInterpolation::primitiveConstants() const {
    calculate();
    return qlCubicInterpolation_->primitiveConstants();
}
const std::vector<QuantLib::Real>& QuantLibAddin::CubicInterpolation::aCoefficients() const {
    calculate();
    return qlCubicInterpolation_->aCoefficients();
}
const std::vector<QuantLib::Real>& QuantLibAddin::CubicInterpolation::bCoefficients() const {
    calculate();
    return qlCubicInterpolation_->bCoefficients();
}
const std::vector<QuantLib::Real>& QuantLibAddin::CubicInterpolation::cCoefficients() const {
    calculate();
    return qlCubicInterpolation_->cCoefficients();
}
const std::vector<bool>& QuantLibAddin::CubicInterpolation::monotonicityAdjustments() const {
    calculate();
    return qlCubicInterpolation_->monotonicityAdjustments();
}

QuantLibAddin::AbcdInterpolation::AbcdInterpolation(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Real > const &XArray,
            std::vector< QuantLib::Handle< QuantLib::Quote > > const &YArray,
            QuantLib::Real A,
            QuantLib::Real B,
            QuantLib::Real C,
            QuantLib::Real D,
            bool AIsFixed,
            bool BIsFixed,
            bool CIsFixed,
            bool DIsFixed,
            bool VegaWeighted,
            boost::shared_ptr< QuantLib::EndCriteria > const &EndCriteria,
            boost::shared_ptr< QuantLib::OptimizationMethod > const &OptimizationMeth,
            // END   typemap rp_tm_default
    bool permanent)
: Interpolation(properties, XArray, YArray, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
        QuantLib::AbcdInterpolation(x_.begin(), x_.end(), y_.begin(),
                                    A, B, C, D,
                                    AIsFixed, BIsFixed, CIsFixed, DIsFixed,
                                    VegaWeighted,
                                    EndCriteria, OptimizationMeth));
    qlInterpolation_ = boost::dynamic_pointer_cast<QuantLib::Interpolation>(
        libraryObject_);
    qlAbcdInterpolation_ = boost::dynamic_pointer_cast<QuantLib::AbcdInterpolation>(
        libraryObject_);
}

QuantLib::Real QuantLibAddin::AbcdInterpolation::a() const {
    calculate();
    return qlAbcdInterpolation_->a();
}
QuantLib::Real QuantLibAddin::AbcdInterpolation::b() const {
    calculate();
    return qlAbcdInterpolation_->b();
}
QuantLib::Real QuantLibAddin::AbcdInterpolation::c() const {
    calculate();
    return qlAbcdInterpolation_->c();
}
QuantLib::Real QuantLibAddin::AbcdInterpolation::d() const {
    calculate();
    return qlAbcdInterpolation_->d();
}
QuantLib::Real QuantLibAddin::AbcdInterpolation::rmsError() const {
    calculate();
    return qlAbcdInterpolation_->rmsError();
}
QuantLib::Real QuantLibAddin::AbcdInterpolation::maxError() const {
    calculate();
    return qlAbcdInterpolation_->maxError();
}
QuantLib::EndCriteria::Type QuantLibAddin::AbcdInterpolation::endCriteria() const {
    calculate();
    return qlAbcdInterpolation_->endCriteria();
}

QuantLibAddin::SABRInterpolation::SABRInterpolation(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Real > const &XArray,
            std::vector< QuantLib::Handle< QuantLib::Quote > > const &YArray,
            QuantLib::Time Expiry,
            QuantLib::Handle< QuantLib::Quote > const &Forward,
            QuantLib::Real Alpha,
            QuantLib::Real Beta,
            QuantLib::Real Nu,
            QuantLib::Real Rho,
            bool AlphaIsFixed,
            bool BetaIsFixed,
            bool NuIsFixed,
            bool RhoIsFixed,
            bool VegaWeighted,
            boost::shared_ptr< QuantLib::EndCriteria > const &EndCriteria,
            boost::shared_ptr< QuantLib::OptimizationMethod > const &OptimizationMeth,
            // END   typemap rp_tm_default
    bool permanent)
: Interpolation(properties, XArray, YArray, permanent), forwardh_(Forward), forward_(0.01)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Extrapolator>(new
        QuantLib::SABRInterpolation(x_.begin(), x_.end(), y_.begin(),
                                    Expiry, forward_, Alpha, Beta, Nu, Rho,
                                    AlphaIsFixed, BetaIsFixed,
                                    NuIsFixed, RhoIsFixed,
                                    VegaWeighted,
                                    EndCriteria, OptimizationMeth));
    qlInterpolation_ = boost::dynamic_pointer_cast<QuantLib::Interpolation>(
        libraryObject_);
    qlSABRInterpolation_ = boost::dynamic_pointer_cast<QuantLib::SABRInterpolation>(
        libraryObject_);
}

QuantLib::Real QuantLibAddin::SABRInterpolation::alpha() const {
    calculate();
    return qlSABRInterpolation_->alpha();
}

QuantLib::Real QuantLibAddin::SABRInterpolation::beta() const {
    calculate();
    return qlSABRInterpolation_->beta();
}

QuantLib::Real QuantLibAddin::SABRInterpolation::nu() const {
    calculate();
    return qlSABRInterpolation_->nu();
}

QuantLib::Real QuantLibAddin::SABRInterpolation::rho() const {
    calculate();
    return qlSABRInterpolation_->rho();
}

const std::vector<QuantLib::Real>& QuantLibAddin::SABRInterpolation::weights() const {
    calculate();
    return qlSABRInterpolation_->interpolationWeights();
}

QuantLib::Real QuantLibAddin::SABRInterpolation::rmsError() const {
    calculate();
    return qlSABRInterpolation_->rmsError();
}

QuantLib::Real QuantLibAddin::SABRInterpolation::maxError() const {
    calculate();
    return qlSABRInterpolation_->maxError();
}

QuantLib::EndCriteria::Type QuantLibAddin::SABRInterpolation::endCriteria() const {
    calculate();
    return qlSABRInterpolation_->endCriteria();
}

void QuantLibAddin::SABRInterpolation::performCalculations() const {
    forward_ = forwardh_->value();
    Interpolation::performCalculations();
}

QuantLibAddin::Interpolation2D::Interpolation2D(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::string const &InterpolationType,
            std::vector< double > const &XArray,
            std::vector< double > const &YArray,
            QuantLib::Matrix const &ZMatrix,
            // END   typemap rp_tm_default
    bool permanent) : Extrapolator(properties, permanent),
      x_(XArray), y_(YArray), dataMatrix_(ZMatrix) {
    QL_REQUIRE(YArray.size()==ZMatrix.rows(),
        "y size (" << YArray.size() <<
        ") does not match number of rows in the data matrix ("
        << ZMatrix.rows() << ")");
    QL_REQUIRE(XArray.size()==ZMatrix.columns(),
        "x size (" << XArray.size() <<
        ") does not match number of columns in the data matrix ("
        << ZMatrix.columns() << ")");
    //const std::vector<QuantLib::Real>& x_ =
    //    boost::any_cast<std::vector<QuantLib::Real> >(propertyValue("XARRAY"));
    //const std::vector<QuantLib::Real>& y_ =
    //    boost::any_cast<std::vector<QuantLib::Real> >(propertyValue("YARRAY"));
    //const QuantLib::Matrix& dataMatrix_ =
    //    boost::any_cast<QuantLib::Matrix>(propertyValue("ZMATRIX"));
    libraryObject_ = reposit::Create<boost::shared_ptr<QuantLib::Interpolation2D> >()
        (InterpolationType, x_.begin(), x_.end(), y_.begin(), y_.end(), dataMatrix_);

}
