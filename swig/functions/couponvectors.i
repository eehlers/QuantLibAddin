
%group(couponvectors);
%groupCaption(Coupon Vectors);
%override;

%insert(couponvectors_addin_cpp) %{
#include <qlo/obj_schedule.hpp>
#include <qlo/indexes/iborindex.hpp>
#include <qlo/objmanual_termstructures.hpp>
#include <qlo/conundrumpricer.hpp>
%}

namespace QuantLibAddin {

    class IborLeg : public Leg {
      public:
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
    
    class CmsCouponPricer : public FloatingRateCouponPricer {
      public:
        CmsCouponPricer(
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& vol,
            const std::string& typeOfCmsCouponPricer,
            QuantLib::GFunctionFactory::YieldCurveModel modelOfYieldCurve,
            const QuantLib::Handle<QuantLib::Quote>& meanReversion
        );
    };    
}

