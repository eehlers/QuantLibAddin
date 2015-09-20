
%group(exercise);

%insert(exercise_library_hpp) %{
#include <ql/exercise.hpp>
%}

namespace QuantLib {

    class Exercise {};

    class EuropeanExercise : public Exercise {
      public:
        %generate(cpp, EuropeanExercise);
        %generate(countify, EuropeanExercise);
        EuropeanExercise(const Date& date);
    };

    class BermudanExercise : public Exercise {
      public:
        BermudanExercise(const std::vector<Date>& dates/*,
                         bool payoffAtExpiry = false*/);
    };    
}

