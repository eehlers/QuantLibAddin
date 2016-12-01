
%group(Vanilla Swaps);

%insert(obj_hpp) %{
#include <qlo/objects/obj_swap.hpp>
#include <ql/instruments/vanillaswap.hpp>

namespace QuantLib {
    class SwapRateHelper;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_indexes.hpp>
#include <qlo/objects/obj_pricingengines.hpp>
#include <qlo/objects/obj_ratehelpers.hpp>
#include <qlo/objects/obj_schedule.hpp>
%}

//%insert(vanillaswaps_library_hpp) %{
//#include <ql/instruments/vanillaswap.hpp>
//#include <qlo/objects/obj_instruments.hpp>
//%}
//
//%insert(vanillaswaps_addin_cpp) %{
//#include <qlo/objects/obj_schedule.hpp>
//#include <qlo/objects/indexes/iborindex.hpp>
//%}

namespace QuantLib {

    class VanillaSwap : public Swap {
      public:

        VanillaSwap(
            VanillaSwap::Type PayerReceiver/*=Payer*/,                                                      //!< PAYER to pay the fixed rate, RECEIVER to receive it.
            Real Nominal/*=100*/,                                                                           //!< Notional Amount.
            const Schedule& FixSchedule,                                                                    //!< Fixed leg Schedule object ID.
            Rate FixedRate,                                                                                 //!< The fixed leg rate.
            const DayCounter& FixDayCounter,                                                                //!< Fixed leg day counter (e.g. Actual/360).
            const Schedule& FloatingLegSchedule,                                                            //!< Floating leg Schedule object ID.
            const boost::shared_ptr<IborIndex>& IborIndex,                                                  //!< Floating leg IborIndex object ID.
            Spread Spread/*=0.0*/,                                                                          //!< Floating leg spread.
            const DayCounter& FloatingLegDayCounter,                                                        //!< Floating day counter (e.g. Actual/360).
            BusinessDayConvention PaymentConvention=QuantLib::BusinessDayConvention(QuantLib::Following)    //!< Payment dates' business day convention.
        );

        %rename(MakeVanillaSwap) VanillaSwap;
        VanillaSwap(
            QuantLib::Natural SettlDays/*=2*/,                                                              //!< Number of days to spot date.
            const QuantLib::Period& SwapTenor,                                                              //!< Swap tenor period (e.g. 5Y).
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                        //!< Floating IborIndex object ID.
            QuantLib::Rate FixedRate/*QuantLib::Null<QuantLib::Rate>()*/,                                   //!< The fixed leg rate. If missing atm rate is used.
            const QuantLib::Period& ForwardStart,                                                           //!< Forward start period (from spot date).
            const QuantLib::DayCounter& FixDayCounter/*=DayCounter*/,                                       //!< Fixed leg day counter.
            QuantLib::Spread Spread/*=0*/,                                                                  //!< Floating leg spread.
            const boost::shared_ptr<QuantLib::PricingEngine>& PricingEngineID                               //!< DiscountSwapEngine object ID.
        );

        %rename(MakeIMMSwap) VanillaSwap;
        VanillaSwap(
            const QuantLib::Period& SwapTenor,                                                              //!< Swap tenor period (e.g. 2Y).
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                        //!< Floating IborIndex object ID.
            QuantLib::Rate FixedRate/*QuantLib::Null<QuantLib::Rate>()*/,                                   //!< The fixed leg rate. If missing atm rate is used.
            const QuantLib::Date& FirstImmDate/*=QuantLib::Date()*/,                                        //!< First (IMM) date.
            const QuantLib::DayCounter& FixDayCounter/*=30/360 (Bond Basis)*/,                              //!< Fixed leg day counter.
            QuantLib::Spread Spread/*=0*/,                                                                  //!< Floating leg spread.
            const boost::shared_ptr<QuantLib::PricingEngine>& PricingEngineID                               //!< DiscountSwapEngine object ID.
        );

        %rename(VanillaSwapFromSwapIndex) VanillaSwap;
        VanillaSwap(
            const boost::shared_ptr<QuantLib::SwapIndex>& SwapIndex,                                        //!< SwapIndex object ID.
            const QuantLib::Date& FixingDate                                                                //!< Fixing date.
        );

        %rename(VanillaSwapFromSwapRateHelper) VanillaSwap;
        VanillaSwap(
            const boost::shared_ptr<QuantLib::SwapRateHelper>& SwapRateHelper                               //!< SwapRateHelper object ID.
        );

        //! Returns the BPS of the fixed rate leg for the given VanillaSwap object.
        Real fixedLegBPS() const;

        //! Returns the NPV of the fixed rate leg for the given VanillaSwap object.
        Real fixedLegNPV() const;

        //! Returns the fair fixed leg rate which would zero the swap NPV for the given VanillaSwap object.
        Rate fairRate() const;

        //! Returns the BPS of the floating rate leg for the given VanillaSwap object.
        Real floatingLegBPS() const;

        //! Returns the NPV of the floating rate leg for the given VanillaSwap object.
        Real floatingLegNPV() const;

        //! Returns the fair spread over the floating rate which would zero the swap NPV for the given VanillaSwap object.
        Spread fairSpread() const;

        //! Returns the swap type (Payer or Receiver) of the given VanillaSwap object.
        VanillaSwap::Type type() const;

        //! Returns the swap nominal for the given VanillaSwap object.
        Real nominal() const;

        //! Returns the fixed leg rate for the given VanillaSwap object.
        Rate fixedRate() const;

        //! Returns the fixed rate day count convention for the given VanillaSwap object.
        const DayCounter& fixedDayCount() const;

        //! Returns the spread over floating rate for the given VanillaSwap object.
        Spread spread() const;

        //! Returns the floating leg day count convention for the given VanillaSwap object.
        const DayCounter& floatingDayCount() const;

        //! Returns the payment business day convention for the given VanillaSwap object.
        BusinessDayConvention paymentConvention() const;

        //! Returns the fixed rate leg cash flow analysis of the given VanillaSwap object.
        %wrap(fixedLegAnalysis);
        std::vector<std::vector<reposit::property_t> > fixedLegAnalysis(
            const QuantLib::Date& AfterDate=QuantLib::Date()                                                //!< Shows only cashflows after given date.
        );

        //! Returns the floating rate leg cash flow analysis.
        %wrap(floatingLegAnalysis);
        std::vector<std::vector<reposit::property_t> > floatingLegAnalysis(
            const QuantLib::Date& AfterDate=QuantLib::Date()                                                //!< Shows only cashflows after given date.
        );
    };
}

