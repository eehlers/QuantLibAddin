
%feature("rp:group", "indexes2");

%feature("rp:override_obj");

namespace QuantLibAddin {

    class Index {
      public:
        void addFixings(const std::vector<QuantLib::Date>& dates,
                        const std::vector<QuantLib::Real>& values,
                        bool forceOverwrite);
        double fixing(const QuantLib::Date& fixingDate,
                            bool forecastTodaysFixing);
    };
}

%feature("rp:override_obj", "");
%feature("rp:group", "");

