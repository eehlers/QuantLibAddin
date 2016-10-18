
namespace QuantLib {

    typedef int Natural;
    typedef int Integer;
    typedef int Day;
    typedef int Year;
    typedef std::size_t Size;
    typedef long BigInteger;
    typedef double Real;
    typedef double Rate;
    typedef double Spread;
    typedef double Volatility;
    typedef double DiscountFactor;
    typedef double Time;

    class Option {
        public:
            enum Type;
    };

    enum BusinessDayConvention;
    enum Compounding;
    enum Frequency;
    enum SensitivityAnalysis;
    enum Month;
    enum Weekday;

    struct DateGeneration {
        enum Rule;
    };
    struct Pillar {
        enum Choice;
    };

    struct Position {
        enum Type;
    };
    
    struct Duration {
        enum Type;
    };

    struct MixedInterpolation {
        enum Behavior;
    };

    class Date;
    class DayCounter;
    class Period;
    class Quote;
    class Calendar;
    class Currency;

    class OneFactorAffineModel;
    class ShortRateModel;
    class G2;
    class PricingEngine;
    class StrikedTypePayoff;
    class VanillaSwap;
    class Leg;
    class YieldTermStructure;
    class GeneralizedBlackScholesProcess;
    class InterestRate;
    class IborIndex;
    class Bond;
    class Schedule;

    template <class T> class TimeSeries;
    template <class T> class Handle;
}

namespace QuantLibAddin {
    class Bond;
}
