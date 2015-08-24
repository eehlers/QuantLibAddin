
#include <qlo/objmanual_quote2.hpp>

namespace {

    Real minus(Real x, Real y) { return x-y; }
    Real plus(Real x, Real y) { return x+y; }
}

QuantLibAddin::CompositeQuote::CompositeQuote(
                const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
                const QuantLib::Handle<QuantLib::Quote>& element1,
                const QuantLib::Handle<QuantLib::Quote>& element2,
                const std::string& op,
                bool permanent)
: Quote(properties, permanent)
{

    typedef Real (*binary_f)(Real, Real);
    if (op=="-")
        libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new
            QuantLib::CompositeQuote<binary_f>(element1, element2, minus));
    else if (op=="+")
        libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new
            QuantLib::CompositeQuote<binary_f>(element1, element2, plus));
    else
        QL_FAIL("unknown operator " << op);
}
