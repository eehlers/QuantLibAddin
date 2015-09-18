
%pragma(reposit) group="leg";
%override

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

