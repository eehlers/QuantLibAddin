
#ifndef obj_quote2_hpp
#define obj_quote2_hpp

#include <qlo/obj_quote.hpp>
#include <ql/quotes/compositequote.hpp>

namespace QuantLibAddin {

    //class CompositeQuote : 
    //    public Quote {
    //public:
    //    CompositeQuote(
    //        const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
    //        // BEGIN typemap rp_tm_default
    //        boost::shared_ptr< ObjectHandler::ValueObject > const &properties,
    //        QuantLib::Handle< QuantLib::Quote > const &element1,
    //        QuantLib::Handle< QuantLib::Quote > const &element2,
    //        std::string const &op,
    //        bool permanent,
    //        // END   typemap rp_tm_default
    //        bool permanent)
    //    : Quote(properties, permanent) {
    //        libraryObject_ = boost::shared_ptr<QuantLibAddin::Quote>(new QuantLibAddin::CompositeQuote(
    //            // BEGIN typemap rp_tm_default
    //            properties,
    //            element1,
    //            element2,
    //            op,
    //            permanent
    //            // END   typemap rp_tm_default
    //        ));
    //    }
    //};

     class CompositeQuote : public Quote {
      public:
        CompositeQuote(
                    const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
                    const QuantLib::Handle<QuantLib::Quote>& element1,
                    const QuantLib::Handle<QuantLib::Quote>& element2,
                    const std::string& op,
                    bool permanent);
    };


} // namespace QuantLibAddin

#endif

