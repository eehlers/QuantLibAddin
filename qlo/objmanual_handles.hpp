
#ifndef obj_handles_hpp
#define obj_handles_hpp

#include <qlo/handleimpl.hpp>
#include <oh/libraryobject.hpp>
#include <ql/termstructures/yieldtermstructure.hpp>

namespace QuantLib {
    class Extrapolator;
    class YieldTermStructure;
}

namespace QuantLibAddin {

    class Extrapolator : public ObjectHandler::LibraryObject<QuantLib::Extrapolator> {
        public:
        //    void enableExtrapolation(bool b);
        //protected:
            OH_LIB_CTOR(Extrapolator, QuantLib::Extrapolator)
    };
    OH_OBJ_CLASS(TermStructure, Extrapolator);
    OH_OBJ_CLASS(YieldTermStructure, TermStructure);

    class RelinkableHandleYieldTermStructure : public RelinkableHandleImpl<QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure>{
    public:
        RelinkableHandleYieldTermStructure(const boost::shared_ptr<ObjectHandler::ValueObject> &properties,
            const std::string &linkTo,
            bool permanent) : RelinkableHandleImpl<QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure>(properties, linkTo, permanent) {}

    };
} // namespace QuantLibAddin

#endif

