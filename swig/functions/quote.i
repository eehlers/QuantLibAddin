
%feature("rp:group", "quote");
%feature("rp:obj_include") %{
#include <ql/quotes/simplequote.hpp>
#include <ql/quotes/lastfixingquote.hpp>
#include <ql/quotes/futuresconvadjustmentquote.hpp>
#include <ql/math/comparison.hpp>
%}

%feature("rp:override_obj");

%feature("rp:generate_countify") QuantLibAddin::SimpleQuote::SimpleQuote;

namespace QuantLibAddin {

    bool close(double x, double y);
    
    class Quote {
      public:
        double value();
        bool isValid();
    };
    
    class SimpleQuote : public Quote {
      public:
        SimpleQuote(double Value);
        // NB The parameter below must be called "Value" because of some hard-coding
        // in objmanual_quote.cpp to update a property with that name in the value object.
        QuantLib::Real setValue(QuantLib::Real Value);
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

%feature("rp:obj_include", "");
%feature("rp:override_obj", "");
%feature("rp:group", "");

