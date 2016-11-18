
#ifndef obj_handles_hpp
#define obj_handles_hpp

#include <qlo/objects/handleimpl.hpp>
#include <rp/libraryobject.hpp>
#include <qlo/objects/obj_quotes.hpp>
#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/obj_swaptionvolstructure.hpp>
#include <qlo/conversions/coercetermstructure.hpp>

namespace QuantLibAddin {

    class RelinkableHandleQuote : public RelinkableHandleImpl<QuantLibAddin::Quote, QuantLib::Quote>{
    public:
        RelinkableHandleQuote(const boost::shared_ptr<reposit::ValueObject> &properties,
            const std::string &linkTo,
            bool permanent) : RelinkableHandleImpl<QuantLibAddin::Quote, QuantLib::Quote>(properties, linkTo, permanent) {}
    };

    class RelinkableHandleYieldTermStructure : public RelinkableHandleImpl<QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure>{
    public:
        RelinkableHandleYieldTermStructure(const boost::shared_ptr<reposit::ValueObject> &properties,
            const std::string &linkTo,
            bool permanent) : RelinkableHandleImpl<QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure>(properties, linkTo, permanent) {}
    };

    class RelinkableHandleSwaptionVolatilityStructure : public RelinkableHandleImpl<QuantLibAddin::SwaptionVolatilityStructure, QuantLib::SwaptionVolatilityStructure>{
    public:
        RelinkableHandleSwaptionVolatilityStructure(const boost::shared_ptr<reposit::ValueObject> &properties,
            const std::string &linkTo,
            bool permanent) : RelinkableHandleImpl<QuantLibAddin::SwaptionVolatilityStructure, QuantLib::SwaptionVolatilityStructure>(properties, linkTo, permanent) {}
    };
} // namespace QuantLibAddin

#endif

