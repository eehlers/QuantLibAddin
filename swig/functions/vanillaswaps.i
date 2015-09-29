
%group(vanillaswaps);

%insert(vanillaswaps_library_hpp) %{
#include <ql/instruments/vanillaswap.hpp>
#include <qlo/obj_instruments.hpp>
%}

%insert(vanillaswaps_serialization_cpp) %{
#include <qlo/obj_schedule.hpp>
#include <qlo/objmanual_indexes.hpp>
%}

%insert(vanillaswaps_addin_cpp) %{
#include <qlo/obj_schedule.hpp>
#include <qlo/objmanual_indexes.hpp>
%}

namespace QuantLib {

    class VanillaSwap : public /*Swap*/Instrument {
      public:
        VanillaSwap(
            VanillaSwap::Type type,
            Real nominal,
            const Schedule& fixedSchedule,
            Rate fixedRate,
            const DayCounter& fixedDayCount,
            const Schedule& floatSchedule,
            const boost::shared_ptr<IborIndex>& iborIndex,
            Spread spread,
            const DayCounter& floatingDayCount/*,
            boost::optional<BusinessDayConvention> paymentConvention =
                                                                 boost::none*/);
        Rate fairRate();                                                                 
    };
}
