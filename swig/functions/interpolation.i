
%group(Interpolation);

%insert(obj_hpp) %{
#include <qlo/objects/obj_termstructures.hpp>

#include <ql/math/interpolations/mixedinterpolation.hpp>
#include <ql/math/interpolations/cubicinterpolation.hpp>
#include <ql/math/interpolations/sabrinterpolation.hpp>
#include <ql/math/interpolations/abcdinterpolation.hpp>

#include <ql/patterns/lazyobject.hpp>
#include <ql/quote.hpp>
#include <ql/types.hpp>

namespace QuantLib {
    class Extrapolator;
    class EndCriteria;
    class OptimizationMethod;

    template<class T>
    class Handle;

    class Quote;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_optimization.hpp>

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
%}

namespace QuantLib {

    %noctor(Interpolation);
    class Interpolation : public Extrapolator, public QuantLib::LazyObject {
      public:

        //! Returns interpolated values using the given Interpolation object.
        %rename(interpolate) operator();
        %wrap(operator());
        %loop(operator(), XValues);
        Real operator()(
            Real XValues,                   //!< X values.
            bool AllowExtrapolation=false   //!< Allow extrapolation flag.
        ) const;

        //! Returns the first derivative function values using the given Interpolation object.
        %wrap(derivative);
        %loop(derivative, XValues);
        Real derivative(
            Real XValues,                   //!< X values.
            bool AllowExtrapolation=false   //!< Allow extrapolation flag.
        ) const;

        //! Returns the second derivative function values using the given Interpolation object.
        %wrap(secondDerivative);
        %loop(secondDerivative, XValues);
        Real secondDerivative(
            Real XValues,                   //!< X values.
            bool AllowExtrapolation=false   //!< Allow extrapolation flag.
        ) const;

        //! Returns the primitive function values using the given Interpolation object.
        %wrap(primitive);
        %loop(primitive, XValues);
        Real primitive(
            Real XValues,                   //!< X values.
            bool AllowExtrapolation=false   //!< Allow extrapolation flag.
        ) const;

        //! Returns TRUE if the input value is in the allowed interpolation range for the given Interpolation object.
        %loop(isInRange, XValues);
        bool isInRange(
            Real XValues                    //!< X values.
        ) const;

        //! Returns the minimum value of the x array for the given Interpolation object.
        Real xMin() const;

        //! Returns the maximum value of the x array for the given Interpolation object.
        Real xMax() const;
%insert(rp_class) %{
      protected:
        Interpolation(
            const boost::shared_ptr<reposit::ValueObject>&,
            const std::vector<QuantLib::Real>& x,
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& yh,
            bool permanent);
        QuantLib::Size n_;
        std::vector<QuantLib::Real> x_;
        std::vector<QuantLib::Handle<QuantLib::Quote> > yh_;
        mutable std::vector<QuantLib::Real> y_;
        boost::shared_ptr<QuantLib::Interpolation> qlInterpolation_;
        void performCalculations() const;
%}
    };

    class GenericInterp : public Interpolation {
    public:
        %rename(Interpolation) GenericInterp;
        GenericInterp(
            const std::string& InterpolationType="MonotonicCubicNaturalSpline",         //!< interpolation type (e.g BackwardFlat, ForwardFlat, MonotonicCubicNaturalSpline, etc.)
            const std::vector<Real>& XArray,                                            //!< X array.
            const std::vector<Handle<Quote> >& YArray                                   //!< Y array.
        );
    };

    class MixedLinearCubicInterpolation : public Interpolation {
      public:
        MixedLinearCubicInterpolation(
            const std::vector<Real>& XArray,                                            //!< X array.
            const std::vector<Handle<Quote> >& YArray,                                  //!< Y array.
            Size SwitchIndex,                                                           //!< Zero based knot index at which interpolation switches from linear to cubic.
            CubicInterpolation::DerivativeApprox DerApprox=Kruger,                      //!< Derivative approximation.
            bool Monotonic=false,                                                       //!< Monotonicity constraint flag.
            CubicInterpolation::BoundaryCondition LeftConditionType=SecondDerivative,   //!< Left boundary condition (NotAKnot, FirstDerivative, SecondDerivative, Periodic, Lagrange).
            Real LeftConditionValue=0.0,                                                //!< Left condition value.
            CubicInterpolation::BoundaryCondition RightConditionType=SecondDerivative,  //!< Right boundary condition (NotAKnot, FirstDerivative, SecondDerivative, Periodic, Lagrange).
            Real RightConditionValue=0.0                                                //!< Right condition value.
        );
%insert(rp_class) %{
      protected:
        boost::shared_ptr<QuantLib::MixedLinearCubicInterpolation> qlMixedLinearCubicInterpolation_;
%}
    };

    class CubicInterpolation : public Interpolation {
      public:
        CubicInterpolation(
            const std::vector<Real>& XArray,                                            //!< X array.
            const std::vector<Handle<Quote> >& YArray,                                  //!< Y array.
            CubicInterpolation::DerivativeApprox DerApprox=Kruger,                      //!< Derivative approximation.
            bool Monotonic=true,                                                        //!< Monotonicity constraint flag.
            CubicInterpolation::BoundaryCondition LeftConditionType=SecondDerivative,   //!< Left boundary condition (NotAKnot, FirstDerivative, SecondDerivative, Periodic, Lagrange).
            Real LeftConditionValue=0.0,                                                //!< Left condition value.
            CubicInterpolation::BoundaryCondition RightConditionType=SecondDerivative,  //!< Right boundary condition (NotAKnot, FirstDerivative, SecondDerivative, Periodic, Lagrange).
            Real RightConditionValue=0.0                                                //!< Right condition value.
        );

        //! Returns the constant terms in the primitive of the cubic interpolants for the given CubicSplineInterpolation object.
        %wrap(primitiveConstants);
        const std::vector<Real>& primitiveConstants() const;

        //! Returns the constant terms in the primitive of the cubic interpolants for the given CubicSplineInterpolation object.
        %wrap(aCoefficients);
        const std::vector<Real>& aCoefficients() const;

        //! Returns the constant terms in the primitive of the cubic interpolants for the given CubicSplineInterpolation object.
        %wrap(bCoefficients);
        const std::vector<Real>& bCoefficients() const;

        //! Returns the constant terms in the primitive of the cubic interpolants for the given CubicSplineInterpolation object.
        %wrap(cCoefficients);
        const std::vector<Real>& cCoefficients() const;

        //! Returns a vector of bool (one per cubic) indicating if there has been a monotonicity adjustment.
        %wrap(monotonicityAdjustments);
        const std::vector<bool>& monotonicityAdjustments() const;
%insert(rp_class) %{
      protected:
        boost::shared_ptr<QuantLib::CubicInterpolation> qlCubicInterpolation_;
%}
    };

    class AbcdInterpolation : public Interpolation {
      public:
        AbcdInterpolation(
            const std::vector<Real>& XArray,                                            //!< X array.
            const std::vector<Handle<Quote> >& YArray,                                  //!< Y array.
            Real A=Null<Real>(),                                                        //!< The a in { y = (a + b*x) e^(-c*x) + d }. It can be a fixed value or just a guess.
            Real B=Null<Real>(),                                                        //!< The b in { y = (a + b*x) e^(-c*x) + d }. It can be a fixed value or just a guess.
            Real C=Null<Real>(),                                                        //!< The c in { y = (a + b*x) e^(-c*x) + d }. It can be a fixed value or just a guess.
            Real D=Null<Real>(),                                                        //!< The d in { y = (a + b*x) e^(-c*x) + d }. It can be a fixed value or just a guess.
            bool AIsFixed=false,                                                        //!< TRUE if the A value provided is to be kept fixed, FALSE if it is just a guess.
            bool BIsFixed=false,                                                        //!< TRUE if the B value provided is to be kept fixed, FALSE if it is just a guess.
            bool CIsFixed=false,                                                        //!< TRUE if the C value provided is to be kept fixed, FALSE if it is just a guess.
            bool DIsFixed=false,                                                        //!< TRUE if the D value provided is to be kept fixed, FALSE if it is just a guess.
            bool VegaWeighted=true,                                                     //!< TRUE if the interpolation is weighted using options Vega.
            const boost::shared_ptr<EndCriteria>& EndCriteria=boost::shared_ptr<EndCriteria>(),//!< EndCriteria object ID.
            const boost::shared_ptr<OptimizationMethod>& OptimizationMeth=boost::shared_ptr<OptimizationMethod>()//!< OptimizationMethod object ID.
        );

        //! Returns the a in the { y = (a + b*x) e^(-c*x) + d } fit for the given AbcdInterpolation object.
        %wrap(a);
        Real a() const;

        //! Returns the b in the { y = (a + b*x) e^(-c*x) + d } fit for the given AbcdInterpolation object.
        %wrap(b);
        Real b() const;

        //! Returns the c in the { y = (a + b*x) e^(-c*x) + d } fit for the given AbcdInterpolation object.
        %wrap(c);
        Real c() const;

        //! Returns the d in the { y = (a + b*x) e^(-c*x) + d } fit for the given AbcdInterpolation object.
        %wrap(d);
        Real d() const;

        //! Returns the error of the fit for the given AbcdInterpolation object.
        %wrap(rmsError);
        Real rmsError() const;

        //! Returns the max error of the fit for the given AbcdInterpolation object.
        %wrap(maxError);
        Real maxError() const;

        //! Returns the optimization end criteria of the fit for the given AbcdInterpolation object.
        %wrap(endCriteria);
        EndCriteria::Type endCriteria() const;
%insert(rp_class) %{
      protected:
        boost::shared_ptr<QuantLib::AbcdInterpolation> qlAbcdInterpolation_;
%}
    };

    class SABRInterpolation : public Interpolation {
      public:

        SABRInterpolation(
            const std::vector<Real>& XArray,                                            //!< X array.
            const std::vector<Handle<Quote> >& YArray,                                  //!< Y array.
            Time Expiry,                                                                //!< Expiry time in years.
            const Handle<Quote>& Forward,                                               //!< At-the-money forward rate.
            Real Alpha=Null<Real>(),                                                    //!< Alpha (fixed value or guess).
            Real Beta=Null<Real>(),                                                     //!< Beta (fixed value or guess).
            Real Nu=Null<Real>(),                                                       //!< Nu (fixed value or guess).
            Real Rho=Null<Real>(),                                                      //!< Rho (fixed value or guess).
            bool AlphaIsFixed=false,                                                    //!< TRUE if the alpha value provided is to be kept fixed, FALSE if it is just a guess.
            bool BetaIsFixed=false,                                                     //!< TRUE if the beta value provided is to be kept fixed, FALSE if it is just a guess.
            bool NuIsFixed=false,                                                       //!< TRUE if the nu value provided is to be kept fixed, FALSE if it is just a guess.
            bool RhoIsFixed=false,                                                      //!< TRUE if the rho value provided is to be kept fixed, FALSE if it is just a guess.
            bool VegaWeighted=true,                                                     //!< TRUE if the interpolation is weighted using options Vega.
            const boost::shared_ptr<EndCriteria>& EndCriteria=boost::shared_ptr<EndCriteria>(),//!< EndCriteria object ID.
            const boost::shared_ptr<OptimizationMethod>& OptimizationMeth=boost::shared_ptr<OptimizationMethod>()//!< OptimizationMethod object ID.
        );

        //! Returns the expiry time in years for the given SABRInterpolation object.
        Real expiry() const;

        //! Returns the forward  for the given SABRInterpolation object.
        Real forward() const;

        //! Returns the alpha of the fit for the given SABRInterpolation object.
        %wrap(alpha);
        Real alpha() const;

        //! Returns the alpha of the fit for the given SABRInterpolation object.
        %wrap(beta);
        Real beta() const;

        //! Returns the nu of the fit for the given SABRInterpolation object.
        %wrap(nu);
        Real nu() const;

        //! Returns the rho of the fit for the given SABRInterpolation object.
        %wrap(rho);
        Real rho() const;

        //! Returns the weights of the fit for the given SABRInterpolation object.
        %wrap(weights);
        const std::vector<Real>& weights() const;

        //! Returns the error of the fit for the given SABRInterpolation object.
        %wrap(rmsError);
        Real rmsError() const;

        //! Returns the max error of the fit for the given SABRInterpolation object.
        %wrap(maxError);
        Real maxError() const;

        //! Returns the optimization end criteria of the fit for the given SABRInterpolation object.
        %wrap(endCriteria);
        EndCriteria::Type endCriteria() const;

%insert(rp_class) %{
      protected:
        QuantLib::Handle<QuantLib::Quote> forwardh_;
        mutable QuantLib::Real forward_;
        boost::shared_ptr<QuantLib::SABRInterpolation> qlSABRInterpolation_;
        void performCalculations() const;
%}
    };

    class Interpolation2D : public Extrapolator {
      public:
        Interpolation2D(
            const std::string &InterpolationType="BiLinear",                            //!< 2D-interpolation type (e.g BiLinear, BiCubic).
            const std::vector<double>& XArray,                                          //!< X array.
            const std::vector<double>& YArray,                                          //!< Y array.
            const Matrix& ZMatrix                                                       //!< Z-matrix values.
        );

        //! Returns the minimum value of the x array for the given Interpolation2D object.
        virtual Real xMin() const;

        //! Returns the maximum value of the x array for the given Interpolation2D object.
        virtual Real xMax() const;

        //! Returns the x array grid for the given Interpolation2D object.
        virtual std::vector<Real> xValues() const;

        //! Returns the minimum value of the y array for the given Interpolation2D object.
        virtual Real yMin() const;

        //! Returns the maximum value of the y array for the given Interpolation2D object.
        virtual Real yMax() const;

        //! Returns the y array grid for the given Interpolation2D object.
        virtual std::vector<Real> yValues() const;

        //! Returns the z data matrix grid for the given Interpolation2D object.
        const Matrix& zData() const;

        //! Returns TRUE if the (x,y) input value is in the allowed interpolation range for the given Interpolation2D object.
        %loop(isInRange, XValues);
        bool isInRange(
            Real XValues,                                                               //!< X values.
            Real YValue                                                                 //!< Y values.
        ) const;

        //! Returns interpolated values for the (x,y) input for the given Interpolation2D object.
        %rename(interpolate) operator();
        %loop(operator(), XValue);
        Real operator()(
            Real XValue,                                                                //!< X value(s).
            Real YValue,                                                                //!< Y value.
            bool AllowExtrapolation = false                                             //!< Allow extrapolation flag.
        ) const;
%insert(rp_class) %{
      protected:
        std::vector<QuantLib::Real> x_, y_;
        QuantLib::Matrix dataMatrix_;
%}
    };
}

