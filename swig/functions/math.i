
%pragma(reposit) group="math";

%insert(math_lib_inc) %{
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
        EndCriteria(QuantLib::Size maxIterations,
                    QuantLib::Size maxStationaryStateIterations,
                    QuantLib::Real rootEpsilon,
                    QuantLib::Real functionEpsilon,
                    QuantLib::Real gradientNormEpsilon);    
    };
}
