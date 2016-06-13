
%group(couponvectors);
%groupCaption(Coupon Vectors);
%override;

%insert(couponvectors_addin_cpp) %{
#include <qlo/obj_schedule.hpp>
#include <qlo/objmanual_indexes.hpp>
%}

namespace QuantLibAddin {

    class IborLeg : public Leg {
      public:
        %generate(countify, IborLeg);
        IborLeg(
            QuantLib::BusinessDayConvention paymentConvention,      //!< payment business day convention.
            const std::vector<QuantLib::Real>& nominals,            //!< Nominal amount vector.
            const boost::shared_ptr<QuantLib::Schedule>& schedule,  //!< Schedule object ID.
            const std::vector<QuantLib::Natural>& fixingDays,       //!< fixing days (e.g. 2).
            bool isInArrears,                                       //!< TRUE if the fixing is in arrears.
            const QuantLib::DayCounter& paymentDayCounter,          //!< Payment DayCounter ID.
            const std::vector<QuantLib::Rate>& floors,              //!< floor strikes.
            const std::vector<QuantLib::Real>& gearings,            //!< floating rate gearings.
            const boost::shared_ptr<QuantLib::IborIndex>& index,    //!< floating rate index.
            const std::vector<QuantLib::Spread>& spreads,           //!< floating rate spreads.
            const std::vector<QuantLib::Rate>& caps                 //!< cap strikes.
            );
    };
}

