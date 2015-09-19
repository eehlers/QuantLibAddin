
%group(vanillaswaps);

%insert(vanillaswaps_library_hpp) %{
#include <ql/instruments/vanillaswap.hpp>
#include <qlo/obj_instruments.hpp>
%}

%insert(vanillaswaps_serialization_cpp) %{
#include <qlo/obj_schedule.hpp>
#include <qlo/objmanual_indexes.hpp>
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
