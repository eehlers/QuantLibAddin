
%group(quote);
%groupCaption(Quote);
%override;

%insert(quote_addin_cpp) %{
#include <qlo/objmanual_indexes.hpp>
%}

namespace QuantLibAddin {

    bool close(double x, double y);

    class Quote {
      public:
        //! Returns the current value of the given Quote object.
        double value();
        //! Returns TRUE if the given Quote object has a valid value.
        bool isValid();
    };

    class SimpleQuote : public Quote {
      public:
        %generate(c++, SimpleQuote);
        %generate(c#, SimpleQuote);
        %generate(countify, SimpleQuote);
        // NB: The first parameter below must be called "Value" because there
        // is code which updates a property with that name in the value object.
        SimpleQuote(
            QuantLib::Real Value,       //!< quote.
            QuantLib::Real tickValue    //!< tick value used for sensitivity analysis.
        );

        //! sets a new value to the given SimpleQuote object and returns the difference with the previous value.
        QuantLib::Real setValue(
            QuantLib::Real Value        //!< the new value.
        );
    };

    class ForwardSwapQuote : public Quote {
      public:
        ForwardSwapQuote(
            const boost::shared_ptr<QuantLib::SwapIndex>& swapIndex,    //!< floating SwapIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& spread,            //!< floating leg spread.
            const QuantLib::Period& fwdStart                            //!< forward start period.
        );
    };

    class LastFixingQuote : public Quote {
      public:
        LastFixingQuote(
            const boost::shared_ptr<QuantLib::Index>& index             //!< Index object ID.
        );
    };

    class FuturesConvAdjustmentQuote : public Quote {
      public:
        FuturesConvAdjustmentQuote(
            const boost::shared_ptr<QuantLib::IborIndex>& index,        //!< floating IborIndex object ID.
            const std::string& immCode,                                 //!< futures IMM code (e.g. H9).
            const QuantLib::Handle<QuantLib::Quote>& futuresQuote,      //!< futures quote.
            const QuantLib::Handle<QuantLib::Quote>& volatility,        //!< HullWhite volatility.
            const QuantLib::Handle<QuantLib::Quote>& meanReversion      //!< HullWhite mean reversion.
        );
    };

     class CompositeQuote : public Quote {
      public:
        CompositeQuote(
            const QuantLib::Handle<QuantLib::Quote>& element1,          //!< the first, i.e. x, value in the f(x,y) expression.
            const QuantLib::Handle<QuantLib::Quote>& element2,          //!< the second, i.e. y, value in the f(x,y) expression.
            const std::string& op                                       //!< the operator to be applied, e.g. ""+"" or ""-"".
        );
    };
}

