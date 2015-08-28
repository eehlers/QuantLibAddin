
%feature("rp:group", "exercise");
%feature("rp:obj_include") %{
#include <ql/exercise.hpp>
%}

%feature("rp:generate_countify") QuantLib::EuropeanExercise::EuropeanExercise;

namespace QuantLib {

    class Exercise {};
    
    class EuropeanExercise : public Exercise {
      public:
        EuropeanExercise(const QuantLib::Date& date);
    };
}

%feature("rp:obj_include", "");
%feature("rp:group", "");

