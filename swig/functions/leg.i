
%group(leg);
%override;

namespace QuantLibAddin {

    class Leg {
      public:
        %generate(countify, Leg);
        Leg(const std::vector<QuantLib::Real>& amounts,
            const std::vector<QuantLib::Date>& dates,
            bool toBeSorted);
    };

    class MultiPhaseLeg : public Leg {
      public:
        %generate(countify, MultiPhaseLeg);
        MultiPhaseLeg(const std::vector<boost::shared_ptr<Leg> >& legs,
                      bool toBeSorted);
    };
}

