
%feature("rp:group", "quote");
%feature("rp:obj_include") %{
%}

namespace QuantLibAddin {

     class CompositeQuote {
      public:
        CompositeQuote(
                    const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
                    const QuantLib::Handle<QuantLib::Quote>& element1,
                    const QuantLib::Handle<QuantLib::Quote>& element2,
                    const std::string& op,
                    bool permanent);
    };

}

%feature("rp:group", "");

