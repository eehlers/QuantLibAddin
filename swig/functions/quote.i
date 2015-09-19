
%group(quote);
%override

%insert(quote_library_hpp) %{
#include <ql/quotes/simplequote.hpp>
#include <ql/quotes/lastfixingquote.hpp>
#include <ql/quotes/futuresconvadjustmentquote.hpp>
#include <ql/math/comparison.hpp>
%}

%insert(quote_serialization_cpp) %{
#include <qlo/objmanual_indexes.hpp>
%}

%feature("rp:generate_countify") QuantLibAddin::SimpleQuote::SimpleQuote;
%feature("rp:generate_cpp") QuantLibAddin::SimpleQuote::SimpleQuote;

namespace QuantLibAddin {

    bool close(double x, double y);

    class Quote {
      public:
        double value();
        bool isValid();
    };

    class SimpleQuote : public Quote {
      public:
        // NB: The parameter below must be called "Value" because there
        // is code which updates a property with that name in the value object.
        SimpleQuote(double Value);
        QuantLib::Real setValue(QuantLib::Real Value);
    };

    class ForwardSwapQuote : public Quote {
      public:
        ForwardSwapQuote(const boost::shared_ptr<QuantLib::SwapIndex>& swapIndex,
                         const QuantLib::Handle<QuantLib::Quote>& spread,
                         const QuantLib::Period& fwdStart);
    };

    class LastFixingQuote : public Quote {
      public:
        LastFixingQuote(const boost::shared_ptr<QuantLib::Index>& index);
    };

    class FuturesConvAdjustmentQuote : public Quote {
      public:
        FuturesConvAdjustmentQuote(const boost::shared_ptr<QuantLib::IborIndex>& index,
                                   const std::string& immCode,
                                   const QuantLib::Handle<QuantLib::Quote>& futuresQuote,
                                   const QuantLib::Handle<QuantLib::Quote>& volatility,
                                   const QuantLib::Handle<QuantLib::Quote>& meanReversion);
    };

     class CompositeQuote : public Quote {
      public:
        CompositeQuote(
                    const QuantLib::Handle<QuantLib::Quote>& element1,
                    const QuantLib::Handle<QuantLib::Quote>& element2,
                    const std::string& op);
    };
}

