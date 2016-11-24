
%group(Exercise);

%insert(obj_hpp) %{
#include <ql/exercise.hpp>
%}

namespace QuantLib {

    class Exercise {
      public:

        //! Returns all exercise dates.
        const std::vector<Date>& dates() const;

        //! Returns last exercise date.
        Date lastDate() const;
    };

    class AmericanExercise : public /*EarlyExercise*/Exercise {
      public:

        AmericanExercise(
            const Date& EarliestDate,   //!< Earliest exercise date.
            const Date& LatestDate,     //!< Latest exercise date.
            bool PayoffAtExpiry = false //!< Payoff at expiry.
        );
    };

    class EuropeanExercise : public Exercise {
      public:

        EuropeanExercise(
            const Date& ExpiryDate            //!< Expiry date.
        );
    };

    class BermudanExercise : public /*EarlyExercise*/Exercise {
      public:

        BermudanExercise(
            const std::vector<Date>& Dates,     //!< Dates.
            bool PayoffAtExpiry = false         //!< Payoff at expiry.
        );
    };
}

