
%group(Coupon Vectors);

%insert(obj_hpp) %{
#include <qlo/objects/obj_leg.hpp>

#include <ql/time/businessdayconvention.hpp>
#include <ql/cashflows/conundrumpricer.hpp>
#include <ql/cashflows/replication.hpp>

namespace QuantLib {
    class Schedule;
    class IborIndex;
    class DayCounter;
    class SwapIndex;
    class OptionletVolatilityStructure;

    template <class T>
    class Handle;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_schedule.hpp>
#include <qlo/objects/obj_indexes.hpp>
#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/obj_capletvolstructure.hpp>
#include <qlo/objects/obj_swaptionvolstructure.hpp>
%}

namespace QuantLib {

    class DigitalReplication {
    public:

        DigitalReplication(
            QuantLib::Replication::Type Replication,                                                            //!< Replication type (Sub, Central or Super).
            QuantLib::Real Gap=0.0001                                                                           //!< Spread in strikes used in call/put replication.
        );
    };
    
    class FixedRateLeg : public Leg {
      public:

        FixedRateLeg(
            BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,          //!< Payment business day convention.
            const std::vector<QuantLib::Real>& Nominals,                                                        //!< Nominal amount vector.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                            //!< Schedule object ID.
            const std::vector<QuantLib::Rate>& Coupons,                                                         //!< Coupon fixed rates.
            const QuantLib::DayCounter& DayCounter                                                              //!< Payment DayCounter ID.
        );

// FIXME this overload does not get generated.
//        FixedRateLeg(
//            BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,        //!< Payment business day convention.
//            const std::vector<QuantLib::Real>& Nominals,                                                      //!< Nominal amount vector.
//            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                          //!< Schedule object ID.
//            const std::vector<boost::shared_ptr<QuantLib::InterestRate> >& Coupons                            //!< Coupon InterestRate IDs.
//        );
    };

    class IborLeg : public Leg {
      public:

        IborLeg(
            BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,          //!< Payment business day convention.
            const std::vector<QuantLib::Real>& Nominals,                                                        //!< Nominal amount vector.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                            //!< Schedule object ID.
            const std::vector<QuantLib::Natural>& FixingDays/*=std::vector<QuantLib::Natural>()*/,              //!< Fixing days (e.g. 2).
            //const std::vector<unsigned int>& FixingDays/*=std::vector<QuantLib::Natural>()*/,              //!< Fixing days (e.g. 2).
            bool isInArrears/*=false*/,                                                                         //!< TRUE if the fixing is in arrears.
            const QuantLib::DayCounter& DayCounter,                                                             //!< Payment DayCounter ID.
            const std::vector<QuantLib::Rate>& Floors/*=std::vector<QuantLib::Rate>()*/,                        //!< Floor strikes.
            const std::vector<QuantLib::Real>& Gearings/*=1.0*/,                                                //!< Floating rate gearings.
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                            //!< Floating rate index.
            const std::vector<QuantLib::Spread>& Spreads,                                                       //!< Floating rate spreads.
            const std::vector<QuantLib::Rate>& Caps=std::vector<QuantLib::Rate>()                               //!< Cap strikes.
        );
    };

    class DigitalIborLeg : public Leg {
      public:

        DigitalIborLeg(
            BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,          //!< Payment business day convention.
            const std::vector<QuantLib::Real>& Nominals,                                                        //!< Nominal amount vector.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                            //!< Schedule object ID.
            const std::vector<QuantLib::Natural>& FixingDays/*=std::vector<QuantLib::Natural>()*/,              //!< Fixing days (e.g. 2).
            bool isInArrears/*=false*/,                                                                         //!< TRUE if the fixing is in arrears.
            const QuantLib::DayCounter& DayCounter,                                                             //!< Payment DayCounter ID.
            const std::vector<QuantLib::Real>& Gearings/*=1.0*/,                                                //!< Floating rate gearings.
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                            //!< Floating rate index.
            const std::vector<QuantLib::Spread>& Spreads,                                                       //!< Floating rate spreads.
            const std::vector<QuantLib::Rate>& CallStrikes/*=std::vector<QuantLib::Rate>()*/,                   //!< Option strikes. If omitted, no call is assumed.
            std::string CallSpecs,                                                                              //!< Call position (Short, Long) and ATM inclusion.
            const std::vector<QuantLib::Rate>& CallPayoff/*=std::vector<QuantLib::Rate>()*/,                    //!< Payoff if the call ends ITM. If omitted, asset-or-nothing option is assumed.
            const std::vector<QuantLib::Rate>& PutStrikes/*=std::vector<QuantLib::Rate>()*/,                    //!< Option strikes. If omitted, no put is assumed.
            std::string PutSpecs,                                                                               //!< Put position (Short, Long) and ATM inclusion.
            const std::vector<QuantLib::Rate>& PutPayoff/*=std::vector<QuantLib::Rate>()*/,                     //!< Payoff if the put ends ITM. If omitted, asset-or-nothing option is assumed.
            const boost::shared_ptr<QuantLib::DigitalReplication>& Replication                                  //!< Replication object ID.
        );
    };

    class CmsLeg : public Leg {
      public:

        CmsLeg(
            BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,          //!< Payment business day convention.
            const std::vector<QuantLib::Real>& Nominals,                                                        //!< Nominal amount vector.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                            //!< Schedule object ID.
            const std::vector<QuantLib::Natural>& FixingDays/*=std::vector<QuantLib::Natural>()*/,              //!< Fixing days (e.g. 2).
            bool isInArrears/*=false*/,                                                                         //!< TRUE if the fixing is in arrears.
            const QuantLib::DayCounter& DayCounter,                                                             //!< Payment DayCounter ID.
            const std::vector<QuantLib::Rate>& Floors/*=std::vector<QuantLib::Rate>()*/,                        //!< Floor strikes.
            const std::vector<QuantLib::Real>& Gearings/*=1.0*/,                                                //!< Floating rate gearings.
            const boost::shared_ptr<QuantLib::SwapIndex>& SwapIndex,                                            //!< Underlying SwapIndex object ID.
            const std::vector<QuantLib::Spread>& Spreads,                                                       //!< Floating rate spreads.
            const std::vector<QuantLib::Rate>& Caps=std::vector<QuantLib::Rate>()                               //!< Cap strikes.
        );
    };

    class DigitalCmsLeg : public Leg {
      public:

        DigitalCmsLeg(
            BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,          //!< Payment business day convention.
            const std::vector<QuantLib::Real>& Nominals,                                                        //!< Nominal amount vector.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                            //!< Schedule object ID.
            const std::vector<QuantLib::Natural>& FixingDays/*=std::vector<QuantLib::Natural>()*/,              //!< Fixing days (e.g. 2).
            bool isInArrears/*=false*/,                                                                         //!< TRUE if the fixing is in arrears.
            const QuantLib::DayCounter& DayCounter,                                                             //!< Payment DayCounter ID.
            const std::vector<QuantLib::Real>& Gearings/*=1.0*/,                                                //!< Floating rate gearings.
            const boost::shared_ptr<QuantLib::SwapIndex>& SwapIndex,                                            //!< Underlying SwapIndex object ID.
            const std::vector<QuantLib::Spread>& Spreads,                                                       //!< Floating rate spreads.
            const std::vector<QuantLib::Rate>& CallStrikes/*=std::vector<QuantLib::Rate>()*/,                   //!< Option strikes. If omitted, no call is assumed.
            std::string CallSpecs,                                                                              //!< Call position (Short, Long) and ATM inclusion.
            const std::vector<QuantLib::Rate>& CallPayoff/*=std::vector<QuantLib::Rate>()*/,                    //!< Payoff if the call ends ITM. If omitted, asset-or-nothing option is assumed.
            const std::vector<QuantLib::Rate>& PutStrikes/*=std::vector<QuantLib::Rate>()*/,                    //!< Option strikes. If omitted, no put is assumed.
            std::string PutSpecs,                                                                               //!< Put position (Short, Long) and ATM inclusion.
            const std::vector<QuantLib::Rate>& PutPayoff/*=std::vector<QuantLib::Rate>()*/,                     //!< Payoff if the put ends ITM. If omitted, asset-or-nothing option is assumed.
            const boost::shared_ptr<QuantLib::DigitalReplication>& Replication                                  //!< Replication object ID.
        );
    };

    class RangeAccrualLeg : public Leg {
      public:

        RangeAccrualLeg(
            BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,          //!< Payment business day convention.
            const std::vector<QuantLib::Real>& Nominals,                                                        //!< Nominal amount vector.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                            //!< Schedule object ID.
            const std::vector<QuantLib::Natural>& FixingDays/*=std::vector<QuantLib::Natural>()*/,              //!< Fixing days (e.g. 2).
            const QuantLib::DayCounter& DayCounter,                                                             //!< Payment DayCounter ID.
            const std::vector<QuantLib::Rate>& LowerStrikes/*=std::vector<QuantLib::Rate>()*/,                  //!< Lower strikes.
            const std::vector<QuantLib::Real>& Gearings/*=1.0*/,                                                //!< Floating rate gearings.
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                            //!< Underlying IborIndex object ID.
            const std::vector<QuantLib::Spread>& Spreads,                                                       //!< Floating rate spreads.
            const std::vector<QuantLib::Rate>& UpperStrikes/*=std::vector<QuantLib::Rate>()*/,                  //!< Upper strikes.
            const QuantLib::Period& ObservationsTenor,                                                          //!< Observations tenor period.
            BusinessDayConvention ObservationsBDC=QuantLib::BusinessDayConvention(QuantLib::ModifiedFollowing)  //!< Observations business day convention.
        );
    };

    class CmsZeroLeg : public Leg {
      public:

        CmsZeroLeg(
            BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,          //!< Payment business day convention.
            const std::vector<QuantLib::Real>& Nominals,                                                        //!< Nominal amount vector.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                            //!< Schedule object ID.
            const std::vector<QuantLib::Natural>& FixingDays/*=std::vector<QuantLib::Natural>()*/,              //!< Fixing days (e.g. 2).
            bool isInArrears/*=false*/,                                                                         //!< TRUE if the fixing is in arrears.
            const QuantLib::DayCounter& DayCounter,                                                             //!< Payment DayCounter ID.
            const std::vector<QuantLib::Rate>& Floors/*=std::vector<QuantLib::Rate>()*/,                        //!< Floor strikes.
            const std::vector<QuantLib::Real>& Gearings/*=1.0*/,                                                //!< Floating rate gearings.
            const boost::shared_ptr<QuantLib::SwapIndex>& SwapIndex,                                            //!< Underlying SwapIndex object ID.
            const std::vector<QuantLib::Spread>& Spreads,                                                       //!< Floating rate spreads.
            const std::vector<QuantLib::Rate>& Caps=std::vector<QuantLib::Rate>()                               //!< Cap strikes.
        );
    };
    
    class FloatingRateCouponPricer {};
    
    class IborCouponPricer : public FloatingRateCouponPricer {
      public:

        IborCouponPricer(
            const QuantLib::Handle<QuantLib::OptionletVolatilityStructure>& Volatility,                         //!< Caplet Volatility Structure object ID.
            const std::string& IborCouponPricerType                                                             //!< Ibor Coupon Pricer Type (e.g IborByBlack, ..).
        );
    };

    class CmsCouponPricer : public FloatingRateCouponPricer {
      public:

        CmsCouponPricer(
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& Volatility,                          //!< Swaption Volatility Structure object ID.
            const std::string& CmsCouponPricerType,                                                             //!< Cms Coupon Pricer Type (e.g ConundrumByBlack, ConundrumByNumericalIntegration, ClassicalAnaliticalFormula).
            QuantLib::GFunctionFactory::YieldCurveModel YieldCurveModel,                                        //!< Model of the yield curve (e.g Standard, ExactYield, ParallelShifts, NonParallelShifts).
            const QuantLib::Handle<QuantLib::Quote>& MeanReversion                                              //!< Mean reversion quote.
        );
%insert(rp_class) %{
      protected:
        RP_OBJ_CTOR(CmsCouponPricer, FloatingRateCouponPricer);
%}
    };

    class NumericHaganPricer: public CmsCouponPricer{
      public:

        %rename(ConundrumPricerByNumericalIntegration) NumericHaganPricer;
        NumericHaganPricer(
            const QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>& SwaptionVol,                         //!< Volatility Cube by Sabr.
            QuantLib::GFunctionFactory::YieldCurveModel YieldCurveModel,                                        //!< Model of the yield curve (e.g Standard, ExactYield, ParallelShifts, NonParallelShifts).
            const QuantLib::Handle<QuantLib::Quote>& MeanReversion,                                             //!< Mean reversion quote.
            QuantLib::Rate LowerLimit=0.0,                                                                      //!< Lower limit.
            QuantLib::Rate UpperLimit=1.0,                                                                      //!< Upper limit.
            QuantLib::Real Precision=1.0e-6                                                                     //!< Precision.
        );

        //!< Returns the upper limit of the integral.
        %rename2(upperLimit, ConundrumPricerByNumericalIntegrationUpperLimit);
        Real upperLimit();
    };
}

