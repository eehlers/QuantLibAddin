
%pragma(reposit) group="vanillaswaps";

%pragma(reposit) obj_include=%{
#include <ql/instruments/vanillaswap.hpp>
%}

namespace QuantLib {

    class VanillaSwap /*: public Swap*/ {
      public:
        //enum Type { Receiver = -1, Payer = 1 };
        VanillaSwap(
            QuantLib::VanillaSwap::Type type,
            QuantLib::Real nominal,
            const QuantLib::Schedule& fixedSchedule,
            QuantLib::Rate fixedRate,
            const QuantLib::DayCounter& fixedDayCount,
            const QuantLib::Schedule& floatSchedule,
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
            QuantLib::Spread spread,
            const QuantLib::DayCounter& floatingDayCount/*,
            boost::optional<QuantLib::BusinessDayConvention> paymentConvention =
                                                                 boost::none*/);
    };
}
