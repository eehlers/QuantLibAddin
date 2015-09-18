
%group(exercise);

%insert(exercise_lib_inc) %{
#include <ql/exercise.hpp>
%}

%feature("rp:generate_countify") QuantLib::EuropeanExercise::EuropeanExercise;
%feature("rp:generate_cpp") QuantLib::EuropeanExercise::EuropeanExercise;

namespace QuantLib {

    class Exercise {};

    class EuropeanExercise : public Exercise {
      public:
        EuropeanExercise(const QuantLib::Date& date);
    };

    class BermudanExercise : public Exercise {
      public:
        BermudanExercise(const std::vector<QuantLib::Date>& dates/*,
                         bool payoffAtExpiry = false*/);
    };    
}

