
%group(Optimization);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class EndCriteria;
    class OptimizationMethod;
    class LineSearch;
    class Constraint;
}
%}

%insert(obj_cpp) %{
#include <ql/math/optimization/armijo.hpp>
#include <ql/math/optimization/constraint.hpp>
#include <ql/math/optimization/conjugategradient.hpp>
#include <ql/math/optimization/levenbergmarquardt.hpp>
#include <ql/math/optimization/simplex.hpp>
#include <ql/math/optimization/steepestdescent.hpp>
#include <ql/math/optimization/spherecylinder.hpp>
%}

#include <ql/math/optimization/spherecylinder.hpp>

namespace QuantLib {

    class EndCriteria {
      public:
        EndCriteria(
            Size MaxIterations,                 //!< Max number of iterations.
            Size MaxStationaryStateIterations,  //!< Max number of iterations in a stationary state.
            Real RootEpsilon,                   //!< Tolerance on the root value.
            Real FunctionEpsilon,               //!< Tolerance on the function value.
            Real GradientNormEpsilon            //!< Tolerance on the function gradient norm value.
        );

        //! Returns the number of max interation for the given EndCriteria object.
        Size maxIterations() const;

        //! Returns the number of max interation in a stationary state for the given EndCriteria object.
        Size maxStationaryStateIterations() const;

        //! Returns the function epsilon for the given EndCriteria object.
        Real functionEpsilon() const;

        //! Returns the gradient norm epsilon for the given EndCriteria object.
        Real gradientNormEpsilon() const;
    };

    class Constraint {};

    class NoConstraint : public Constraint {
      public:
        NoConstraint();
    };

    class OptimizationMethod {};

    class Simplex : public OptimizationMethod {
      public:

        Simplex(
            Real Lambda //!< Lambda (typical scale length of the problem).
        );
    };

    class LevenbergMarquardt : public OptimizationMethod {
      public:

        LevenbergMarquardt(
            Real Epsfcn = 1.0e-8,       //!< Epsfcn.
            Real Xtol = 1.0e-8,         //!< Xtol.
            Real Gtol = 1.0e-8          //!< Gtol.
        );
    };

    class LineSearch {};

    class ArmijoLineSearch : public LineSearch {
      public:

        ArmijoLineSearch(
            Real Epsilon = 1e-8,    //!< Epsilon.
            Real Alpha = 0.05,      //!< Alpha.
            Real Beta = 0.65        //!< Beta.
        );
    };

    class LineSearchBasedMethod : public OptimizationMethod {};

    class ConjugateGradient : public LineSearchBasedMethod {
      public:

        ConjugateGradient(
            const boost::shared_ptr<LineSearch>& LineSearch = boost::shared_ptr<LineSearch>()   //!< LineSearch object ID.
        );
    };

    class SteepestDescent : public LineSearchBasedMethod {
      public:
        SteepestDescent(
            const boost::shared_ptr<LineSearch>& LineSearch = boost::shared_ptr<LineSearch>()   //!< LineSearch object ID.
        );
    };

    //! Sphere Cylinder Optimizer Closest.
    std::vector<Real> sphereCylinderOptimizerClosest(
        Real R,                     //!< r.
        Real S,                     //!< s.
        Real Alpha,                 //!< alpha.
        Real Z1,                    //!< z1.
        Real Z2,                    //!< z2.
        Real Z3,                    //!< z3.
        Natural MaxIter,            //!< MaxIter.
        Real Tol                    //!< tolerance.
    );
}

namespace QuantLibAddin {

    //! Returns a hh:mm:ss string from the number of seconds provided as input.
    std::string secondsToString(
        QuantLib::Real Seconds      //!< Number of seconds.
    );
}
