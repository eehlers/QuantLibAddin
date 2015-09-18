
%pragma(reposit) group="couponvectors";
%override

%insert(couponvectors_scr_inc) %{
#include <qlo/obj_schedule.hpp>
#include <qlo/objmanual_indexes.hpp>
%}

namespace QuantLibAddin {

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

