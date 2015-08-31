
%feature("rp:group", "leg");

%feature("rp:override_obj");

namespace QuantLibAddin {

    class Leg {
      public:
        Leg(const std::vector<QuantLib::Real>& amounts,
            const std::vector<QuantLib::Date>& dates,
            bool toBeSorted);
    };

    class MultiPhaseLeg : public Leg {
      public:
        MultiPhaseLeg(const std::vector<boost::shared_ptr<Leg> >& legs,
                      bool toBeSorted);
    };    
}

%feature("rp:override_obj", "");
%feature("rp:group", "");

