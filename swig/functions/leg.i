
%group(leg);
%groupCaption(Leg);
%override;

namespace QuantLibAddin {

    class Leg {
      public:
        %generate(countify, Leg);
        Leg(
            const std::vector<QuantLib::Real>& amounts,         //!< list of cash to be received/paid.
            const std::vector<QuantLib::Date>& dates,           //!< payment dates corresponding to amounts.
            bool toBeSorted                                     //!< TRUE if the CashFlows must be sorted by ascending dates.
        );
    };

    class MultiPhaseLeg : public Leg {
      public:
        %generate(countify, MultiPhaseLeg);
        MultiPhaseLeg(
            const std::vector<boost::shared_ptr<Leg> >& legs,   //!< leg object IDs, one for each phase.
            bool toBeSorted                                     //!< TRUE if the CashFlows must be sorted by ascending dates.
        );
    };
}

