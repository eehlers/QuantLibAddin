
%feature("rp:group", "exercise");
%feature("rp:obj_include") %{
#include <ql/exercise.hpp>
%}

namespace QuantLib {

    class Exercise {};
    
    class EuropeanExercise : public Exercise {
      public:
        EuropeanExercise(const QuantLib::Date& date);
    };
}

%feature("rp:group", "");

