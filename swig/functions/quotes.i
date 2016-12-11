
%group(Quotes);

%insert(obj_hpp) %{
#include <ql/quote.hpp>
#include <ql/option.hpp>
#include <ql/types.hpp>
#include <ql/experimental/risk/sensitivityanalysis.hpp>

#include <rp/libraryobject.hpp>

namespace QuantLib {
    class Index;
    class IborIndex;
    class SwapIndex;
    class Quote;
    class SimpleQuote;
    class FuturesConvAdjustmentQuote;
    class LastFixingQuote;
    class Date;
    class CapsStripper2;
    class Period;

    template <class T>
    class Handle;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_instruments.hpp>
#include <qlo/objects/obj_indexes.hpp>
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
}

namespace QuantLibAddin {

    //bool close(double x, double y);

    class SimpleQuote : public Quote {
      public:

        // NB: The first parameter below must be called "Value" because there
        // is code which updates a property with that name in the value object.
        SimpleQuote(
            QuantLib::Real Value/*=QuantLib::Null<QuantLib::Real>()*/,  //!< Quote.
            QuantLib::Real TickValue                                    //!< Tick value used for sensitivity analysis.
        );

        //! Returns the tick value of the given SimpleQuote object.
        QuantLib::Real tickValue() const;

        //! Sets the tick value of the given SimpleQuote object.
        void setTickValue(
            QuantLib::Real Value                                        //!< The new tick value.
        );

        //! Sets a new value to the given SimpleQuote object and returns the difference with the previous value.
        QuantLib::Real setValue(
            QuantLib::Real Value=QuantLib::Null<QuantLib::Real>()       //!< The new value.
        );

        //! Resets the given SimpleQuote object to an uninitialized state.
        void reset();
%insert(rp_class) %{
      private:
        boost::shared_ptr<QuantLib::SimpleQuote> simpleQuote_;
%}
    };

    class ForwardValueQuote : public Quote {
      public:

        ForwardValueQuote(
            const boost::shared_ptr<QuantLib::IborIndex> &iborIndex,    //!< Floating IborIndex object ID.
            const QuantLib::Date& FixingDate                            //!< Fixing Date.
        );
    };

    class ForwardSwapQuote : public Quote {
      public:

        ForwardSwapQuote(
            const boost::shared_ptr<QuantLib::SwapIndex>& SwapIndex,    //!< Floating SwapIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& Spread,            //!< Floating leg spread.
            const QuantLib::Period& ForwardStart                        //!< Forward start period.
        );
    };

    class ImpliedStdDevQuote : public Quote {
      public:

        ImpliedStdDevQuote(
            QuantLib::Option::Type OptionType,                          //!< Option type (i.e. Call or Put).
            const QuantLib::Handle<QuantLib::Quote>& AtmForwardValue,   //!< Underlying asset at-the-money forward value.
            const QuantLib::Handle<QuantLib::Quote>& OptionPrice,       //!< Option price.
            QuantLib::Real Strike,                                      //!< Option strike.
            QuantLib::Real Guess=QuantLib::Null<QuantLib::Real>(),      //!< Implied volatility guess.
            QuantLib::Real Accuracy=1e-6                                //!< Standard deviation accuracy.
        );
    };

    class EurodollarFuturesImpliedStdDevQuote : public Quote {
      public:

        EurodollarFuturesImpliedStdDevQuote(
            const QuantLib::Handle<QuantLib::Quote>& AtmForwardValue,   //!< Underlying asset at-the-money forward value.
            const QuantLib::Handle<QuantLib::Quote>& CallPrice,         //!< Call option price.
            const QuantLib::Handle<QuantLib::Quote>& PutPrice,          //!< Put option price.
            QuantLib::Real Strike,                                      //!< Option strike.
            QuantLib::Real Guess=QuantLib::Null<QuantLib::Real>(),      //!< Implied volatility guess.
            QuantLib::Real Accuracy=1e-6                                //!< Standard deviation accuracy.
        );
    };

    class CompositeQuote : public Quote {
      public:

        CompositeQuote(
            const QuantLib::Handle<QuantLib::Quote>& Element1,          //!< The first, i.e. x, value in the f(x,y) expression.
            const QuantLib::Handle<QuantLib::Quote>& Element2,          //!< The second, i.e. y, value in the f(x,y) expression.
            const std::string& Operator                                 //!< The operator to be applied, e.g. ""+"" or ""-"".
        );
    };

    class FuturesConvAdjustmentQuote : public Quote {
      public:
        FuturesConvAdjustmentQuote(
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,    //!< Floating IborIndex object ID.
            const std::string& ImmCode,                                 //!< Futures IMM code (e.g. H9).
            const QuantLib::Handle<QuantLib::Quote>& FuturesQuote,      //!< Futures quote.
            const QuantLib::Handle<QuantLib::Quote>& Volatility,        //!< HullWhite volatility.
            const QuantLib::Handle<QuantLib::Quote>& MeanReversion      //!< HullWhite mean reversion.
        );

        //! Return the value of futures underlying.
        QuantLib::Real futuresValue() const;

        //! Return the value of HW volatility.
        QuantLib::Real volatility() const;

        //! Return the value of HW mean reversion.
        QuantLib::Real meanReversion() const;

        //! Return the IMM date of futures.
        QuantLib::Date immDate() const;
%insert(rp_class) %{
      private:
        boost::shared_ptr<QuantLib::FuturesConvAdjustmentQuote> futuresConvAdjustmentQuote_;
%}
    };

    class LastFixingQuote : public Quote {
      public:
        LastFixingQuote(
            const boost::shared_ptr<QuantLib::Index>& Index             //!< Index object ID.
        );

        //! Return the date of the last fixing
        QuantLib::Date referenceDate() const; 
%insert(rp_class) %{
      private:
        boost::shared_ptr<QuantLib::LastFixingQuote> lastFixingQuote_;
%}
    };
    
    //! Delta NPV bucket sensitivity analysis for a (single/vector/matrix) SimpleQuote.
    std::vector<std::vector<QuantLib::Real> >
    bucketAnalysis(
        const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > &SimpleQuote,                   //!< Simple quotes.
        const std::vector<boost::shared_ptr<QuantLib::Instrument> > &Instruments,                           //!< Instruments.
        const std::vector<QuantLib::Real>& Quantities,                                                      //!< Quantities.
        QuantLib::Real Shift=0.0001,                                                                        //!< Shift.
        QuantLib::SensitivityAnalysis SensitivityAnalysis=QuantLib::SensitivityAnalysis(QuantLib::Centered) //!< SensitivityAnalysis type.
    );
    
    //! Parameters' bucket analysis delta for a single SimpleQuote.
    inline std::vector<QuantLib::Real>
    bucketAnalysisDelta(
        const QuantLib::Handle<QuantLib::SimpleQuote>& SimpleQuote,                                         //!< Simple quote.
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& Parameters,                                  //!< Parameters vector.
        QuantLib::Real Shift=0.0001,                                                                        //!< Shift.
        QuantLib::SensitivityAnalysis SensitivityAnalysis=QuantLib::SensitivityAnalysis(QuantLib::Centered) //!< SensitivityAnalysis type.
    );
    
    //! Parameters' bucket analysis delta for a SimpleQuote vector.
    std::vector<std::vector<QuantLib::Real> >
    bucketAnalysisDelta2(
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& SimpleQuote,                                 //!< Simple quote.
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& Parameters,                                  //!< Parameters vector.
        QuantLib::Real Shift=0.0001,                                                                        //!< Shift.
        QuantLib::SensitivityAnalysis SensitivityAnalysis=QuantLib::SensitivityAnalysis(QuantLib::Centered) //!< SensitivityAnalysis type.
    );
}

