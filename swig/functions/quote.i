
%feature("rp:group", "quote");
%feature("rp:obj_include") %{
#include <ql/quotes/simplequote.hpp>
#include <ql/quotes/lastfixingquote.hpp>
#include <ql/quotes/futuresconvadjustmentquote.hpp>
#include <ql/math/comparison.hpp>
%}

namespace QuantLib {

    bool close(double x, double y);
    
    class Quote {};
    
    class SimpleQuote : public Quote {
      public:
        SimpleQuote(double value = QuantLib::Null<double>());
        double value() const;
        double setValue(double value = QuantLib::Null<double>());
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
}

%feature("rp:group", "");

