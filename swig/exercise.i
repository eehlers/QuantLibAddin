
%feature("rp:group", "exercise");
%feature("rp:include") %{
#include <ql/exercise.hpp>
%}

namespace QuantLib {
    class EuropeanExercise {
      public:
        EuropeanExercise(const QuantLib::Date& date);
    };
}

