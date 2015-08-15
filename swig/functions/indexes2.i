
%feature("rp:group", "indexes2");

//%feature("rp:obj_include") %{
//#include <ql/indexes/ibor/euribor.hpp>
//#include <ql/indexes/ibor/eonia.hpp>
//%}

%feature("rp:override_obj");

namespace QuantLibAddin {

    class Index {
      public:
        void addFixings(const std::vector<QuantLib::Date>& dates,
                        const std::vector<QuantLib::Real>& values,
                        bool forceOverwrite);
    };
}

%feature("rp:override_obj", "");

%feature("rp:group", "");
