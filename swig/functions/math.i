
%group(math);
%groupCaption(Math);

%insert(math_library_hpp) %{
#include <ql/math/optimization/levenbergmarquardt.hpp>
#include <ql/math/optimization/endcriteria.hpp>
%}

namespace QuantLib {

    class OptimizationMethod {};

    class LevenbergMarquardt : public OptimizationMethod {
      public:
        %generate(c#, LevenbergMarquardt);
        LevenbergMarquardt(/*Real epsfcn = 1.0e-8,
                           Real xtol = 1.0e-8,
                           Real gtol = 1.0e-8,
                           bool useCostFunctionsJacobian = false*/);
    };

    class EndCriteria {
      public:
        %generate(c#, EndCriteria);
        EndCriteria(
            Size maxIterations,                     //!< max number of iterations.
            Size maxStationaryStateIterations,      //!< max number of iterations in a stationary state.
            Real rootEpsilon,                       //!< tolerance on the root value.
            Real functionEpsilon,                   //!< tolerance on the function value.
            Real gradientNormEpsilon                //!< tolerance on the function gradient norm value.
        );
    };
}

