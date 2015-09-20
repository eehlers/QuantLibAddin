
namespace QuantLib {

    typedef int Natural;
    typedef std::size_t Size;
    typedef double Real;
    typedef double Rate;
    typedef double Spread;
    typedef double Volatility;
    typedef double DiscountFactor;

    class Option {
        public:
            enum Type;
    };

    enum BusinessDayConvention;
    enum Frequency;

    struct DateGeneration {
        enum Rule;
    };

    class Date;
    class DayCounter;
    class Period;
    class Quote;

    class OneFactorAffineModel;
    class ShortRateModel;
    class PricingEngine;
    class StrikedTypePayoff;
    class VanillaSwap;
    class Leg;
    class YieldTermStructure;
    class GeneralizedBlackScholesProcess;

    template <class T> class Handle;
}

