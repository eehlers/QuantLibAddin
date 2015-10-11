
%group(exercise);

%insert(exercise_library_hpp) %{
#include <ql/exercise.hpp>
%}

namespace QuantLib {

    class Exercise {};

    class EuropeanExercise : public Exercise {
      public:
        %generate(c++, EuropeanExercise);
        %generate(c#, EuropeanExercise);
        %generate(countify, EuropeanExercise);
        EuropeanExercise(const Date& date);
    };

    class BermudanExercise : public Exercise {
      public:
        %generate(c#, BermudanExercise);
        BermudanExercise(const std::vector<Date>& dates/*,
                         bool payoffAtExpiry = false*/);
    };    
}

