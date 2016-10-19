
%group(quotes);
%groupCaption(Quotes);
%groupFunctionWizard(QuantLib - Financial);
%override;

%insert(quotes_addin_cpp) %{
#include <qlo/objects/obj_instruments.hpp>
#include <qlo/objects/indexes/iborindex.hpp>
#include <qlo/objects/indexes/swapindex.hpp>
#include <qlo/conversions/coercequote.hpp>
#include <ql/quotes/simplequote.hpp>
#include <ql/quotes/derivedquote.hpp>
#include <ql/quotes/eurodollarfuturesquote.hpp>
#include <ql/quotes/forwardvaluequote.hpp>
#include <ql/quotes/futuresconvadjustmentquote.hpp>
#include <ql/quotes/lastfixingquote.hpp>
#include <ql/quotes/impliedstddevquote.hpp>
#include <ql/indexes/swapindex.hpp>
%}
  
namespace QuantLib {

    class Quote {
      public:
        //! Returns the current value of the given Quote object.
        Real value();
        //! Returns TRUE if the given Quote object has a valid value.
        bool isValid();
    };

    class SimpleQuote : public Quote {
      public:
        //! resets the given SimpleQuote object to the uninitialized state.
        void reset();
    };
    
    class FuturesConvAdjustmentQuote : public Quote/*,
                                       public Observer*/ {
      public:
        //! Return the value of futures underlying.
        Real futuresValue() const;
        //! Return the value of HW volatility.
        Real volatility() const;
        //! Return the value of HW mean reversion.
        Real meanReversion() const;
        //! Return the IMM date of futures.
        Date immDate() const;
    };
    

    //! Quote adapter for the last fixing available of a given Index
    class LastFixingQuote : public Quote/*,
                            public Observer*/ {
      public:
        //! Return the date of the last fixing
        Date referenceDate() const; 
    };    
}

namespace QuantLibAddin {

    //bool close(double x, double y);

    class SimpleQuote : public Quote {
      public:
        %generate(c++, SimpleQuote);
        %generate(c#, SimpleQuote);
        %generate(countify, SimpleQuote);
        // NB: The first parameter below must be called "Value" because there
        // is code which updates a property with that name in the value object.
        SimpleQuote(
            QuantLib::Real Value/*=QuantLib::Null<QuantLib::Real>()*/,  //!< quote.
            QuantLib::Real tickValue                                    //!< tick value used for sensitivity analysis.
        );
        //! returns the tick value of the given SimpleQuote object.
        QuantLib::Real tickValue() const;
        //! sets the tick value of the given SimpleQuote object.
        void setTickValue(
            QuantLib::Real tickValue                                    //!< the new tick value.
        );

        //! sets a new value to the given SimpleQuote object and returns the difference with the previous value.
        QuantLib::Real setValue(
            QuantLib::Real Value=QuantLib::Null<QuantLib::Real>()       //!< the new value.
        );
    };

    class ForwardValueQuote : public Quote {
      public:
        ForwardValueQuote(
            const boost::shared_ptr<QuantLib::IborIndex> &iborIndex,    //!< floating IborIndex object ID.
            const QuantLib::Date& FixingDate                            //!< Fixing Date.
        );
    };

    class ForwardSwapQuote : public Quote {
      public:
        ForwardSwapQuote(
            const boost::shared_ptr<QuantLib::SwapIndex>& SwapIndex,    //!< floating SwapIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& Spread,            //!< floating leg spread.
            const QuantLib::Period& ForwardStart                        //!< forward start period.
        );
    };

    class ImpliedStdDevQuote : public Quote {
      public:
        ImpliedStdDevQuote(
            QuantLib::Option::Type OptionType,                          //!< option type (i.e. Call or Put).
            const QuantLib::Handle<QuantLib::Quote>& AtmForwardValue,   //!< underlying asset at-the-money forward value.
            const QuantLib::Handle<QuantLib::Quote>& OptionPrice,       //!< option price.
            QuantLib::Real Strike,                                      //!< option strike.
            QuantLib::Real Guess=QuantLib::Null<QuantLib::Real>(),      //!< implied volatility guess.
            QuantLib::Real Accuracy=1e-6                                //!< standard deviation accuracy.
        );
    };

    class EurodollarFuturesImpliedStdDevQuote : public Quote {
      public:
        EurodollarFuturesImpliedStdDevQuote(
            const QuantLib::Handle<QuantLib::Quote>& AtmForwardValue,   //!< underlying asset at-the-money forward value.
            const QuantLib::Handle<QuantLib::Quote>& CallPrice,         //!< call option price.
            const QuantLib::Handle<QuantLib::Quote>& PutPrice,          //!< put option price.
            QuantLib::Real Strike,                                      //!< option strike.
            QuantLib::Real Guess=QuantLib::Null<QuantLib::Real>(),      //!< implied volatility guess.
            QuantLib::Real Accuracy=1e-6                                //!< standard deviation accuracy.
        );
    };

    class FuturesConvAdjustmentQuote : public Quote {
      public:
        FuturesConvAdjustmentQuote(
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,    //!< floating IborIndex object ID.
            const std::string& ImmCode,                                 //!< futures IMM code (e.g. H9).
            const QuantLib::Handle<QuantLib::Quote>& FuturesQuote,      //!< futures quote.
            const QuantLib::Handle<QuantLib::Quote>& Volatility,        //!< HullWhite volatility.
            const QuantLib::Handle<QuantLib::Quote>& MeanReversion      //!< HullWhite mean reversion.
        );
    };

    class CompositeQuote : public Quote {
      public:
        CompositeQuote(
            const QuantLib::Handle<QuantLib::Quote>& Element1,          //!< the first, i.e. x, value in the f(x,y) expression.
            const QuantLib::Handle<QuantLib::Quote>& Element2,          //!< the second, i.e. y, value in the f(x,y) expression.
            const std::string& Operator                                 //!< the operator to be applied, e.g. ""+"" or ""-"".
        );
    };

    class LastFixingQuote : public Quote {
      public:
        LastFixingQuote(
            const boost::shared_ptr<QuantLib::Index>& index             //!< Index object ID.
        );
    };
    
    //! delta NPV bucket sensitivity analysis for a (single/vector/matrix) SimpleQuote.
    std::vector<std::vector<QuantLib::Real> >
    bucketAnalysis(
        const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > &SimpleQuote,                   //!< simple quotes.
        const std::vector<boost::shared_ptr<QuantLib::Instrument> > &Instruments,                           //!< instruments.
        const std::vector<QuantLib::Real>& Quantities,                                                      //!< quantities.
        QuantLib::Real Shift=0.0001,                                                                        //!< shift.
        QuantLib::SensitivityAnalysis sensitivityAnalysis=QuantLib::SensitivityAnalysis(QuantLib::Centered) //!< SensitivityAnalysis type.
    );
    
    //! Parameters' bucket analysis delta for a single SimpleQuote.
    inline std::vector<QuantLib::Real>
    bucketAnalysisDelta(
        const QuantLib::Handle<QuantLib::SimpleQuote>& SimpleQuote,                                         //!< simple quote.
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& Parameters,                                  //!< parameters vector.
        QuantLib::Real Shift=0.0001,                                                                        //!< shift.
        QuantLib::SensitivityAnalysis sensitivityAnalysis=QuantLib::SensitivityAnalysis(QuantLib::Centered) //!< SensitivityAnalysis type.
    );
    
    //! Parameters' bucket analysis delta for a SimpleQuote vector.
    std::vector<std::vector<QuantLib::Real> >
    bucketAnalysisDelta2(
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& SimpleQuote,                                 //!< simple quote.
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& Parameters,                                  //!< parameters vector.
        QuantLib::Real Shift=0.0001,                                                                        //!< shift.
        QuantLib::SensitivityAnalysis sensitivityAnalysis=QuantLib::SensitivityAnalysis(QuantLib::Centered) //!< SensitivityAnalysis type.
    );
}

