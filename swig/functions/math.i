
%group(math);

%insert(math_library_hpp) %{
#include <ql/math/optimization/levenbergmarquardt.hpp>
#include <ql/math/optimization/endcriteria.hpp>
%}

namespace QuantLib {

    class OptimizationMethod {};

    class LevenbergMarquardt : public OptimizationMethod {
      public:
        LevenbergMarquardt(/*Real epsfcn = 1.0e-8,
                           Real xtol = 1.0e-8,
                           Real gtol = 1.0e-8,
                           bool useCostFunctionsJacobian = false*/);
    };

    class EndCriteria {
      public:
        EndCriteria(Size maxIterations,
                    Size maxStationaryStateIterations,
                    Real rootEpsilon,
                    Real functionEpsilon,
                    Real gradientNormEpsilon);
    };
}
