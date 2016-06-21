
namespace QuantLib {

    typedef int Natural;
    typedef long BigInteger;
    typedef std::size_t Size;
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

    class Date;
    class DayCounter;
    class Period;
    class Quote;
    class Calendar;

    class OneFactorAffineModel;
    class ShortRateModel;
    class G2;
    class PricingEngine;
    class StrikedTypePayoff;
    class VanillaSwap;
    class Leg;
    class YieldTermStructure;
    class GeneralizedBlackScholesProcess;

    template <class T> class Handle;
}

namespace QuantLibAddin {
    class Bond;
}
