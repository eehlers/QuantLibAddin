
%feature("rp:group", "quote");
%feature("rp:obj_include") %{
#include <ql/quotes/simplequote.hpp>
#include <ql/quotes/lastfixingquote.hpp>
#include <ql/math/comparison.hpp>
%}

namespace QuantLib {

    bool close(double x, double y);
    
    class Quote {};
    
    class SimpleQuote : public Quote {
      public:
        SimpleQuote(double value = QuantLib::Null<double>());
        double value() const;
    };
    
    class LastFixingQuote : public Quote {
      public:
        LastFixingQuote(const boost::shared_ptr<QuantLib::Index>& index);
    };
}

%feature("rp:group", "");

