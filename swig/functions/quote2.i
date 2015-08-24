
%feature("rp:group", "quote2");

%feature("rp:override_obj");

namespace QuantLibAddin {

     class CompositeQuote : public Quote {
      public:
        CompositeQuote(
                    const QuantLib::Handle<QuantLib::Quote>& element1,
                    const QuantLib::Handle<QuantLib::Quote>& element2,
                    const std::string& op);
    };

}

%feature("rp:override_obj", "");
%feature("rp:group", "");

