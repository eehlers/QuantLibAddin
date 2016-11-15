
namespace QuantLib {

    typedef unsigned int Natural;
    typedef int Integer;
    typedef int Day;
    typedef int Year;
    typedef std::size_t Size;
    typedef long BigInteger;
    typedef long BigNatural;
    typedef double Real;
    typedef double Rate;
    typedef double Spread;
    typedef double Volatility;
    typedef double DiscountFactor;
    typedef double Time;
    typedef double Probability;
    
    class Date;
    class Period;
    class Quote;
    class Currency;
    class InterestRate;
    class Matrix;
    // DELETEME - temp fix for bonds which depend on instruments which is not yet implemented.
    class Instrument;
    class Array;
    class YieldTermStructure;

    template <class T> class TimeSeries;
    template <class T> class Handle;
    template <class T> class Disposable;
}

namespace QuantLibAddin {
    class Bond;
}
