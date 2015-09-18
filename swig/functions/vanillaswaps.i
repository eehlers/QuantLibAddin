
%pragma(reposit) group="vanillaswaps";

%insert(vanillaswaps_lib_inc) %{
#include <ql/instruments/vanillaswap.hpp>
#include <qlo/obj_instruments.hpp>
%}

namespace QuantLib {

    class VanillaSwap : public /*Swap*/Instrument {
      public:
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
        QuantLib::Rate fairRate();                                                                 
    };
}
