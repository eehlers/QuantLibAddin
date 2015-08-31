
%feature("rp:group", "couponvectors");

%feature("rp:override_obj");

namespace QuantLibAddin {

    class Leg {};
    
    class IborLeg : public Leg {
      public:
        IborLeg(
            QuantLib::BusinessDayConvention paymentConvention,
            const std::vector<QuantLib::Real>& nominals,
            const boost::shared_ptr<QuantLib::Schedule>& schedule,
            const std::vector<QuantLib::Natural>& fixingDays,
            bool isInArrears,
            const QuantLib::DayCounter& paymentDayCounter,
            const std::vector<QuantLib::Rate>& floors,
            const std::vector<QuantLib::Real>& gearings,
            const boost::shared_ptr<QuantLib::IborIndex>& index,
            const std::vector<QuantLib::Spread>& spreads,
            const std::vector<QuantLib::Rate>& caps);
    };
}

%feature("rp:override_obj", "");
%feature("rp:group", "");

