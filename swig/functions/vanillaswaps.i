
%group(vanillaswaps);
%groupCaption(Vanilla Swaps);

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

    class VanillaSwap : public /*Swap*/Instrument {
      public:
        %generate(c#, VanillaSwap);
        VanillaSwap(
            VanillaSwap::Type type,                             //!< PAYER to pay the fixed rate, RECEIVER to receive it.
            Real nominal,                                       //!< Notional Amount.
            const Schedule& fixedSchedule,                      //!< fixed leg Schedule object ID.
            Rate fixedRate,                                     //!< the fixed leg rate.
            const DayCounter& fixedDayCount,                    //!< fixed leg day counter (e.g. Actual/360).
            const Schedule& floatSchedule,                      //!< floating leg Schedule object ID.
            const boost::shared_ptr<IborIndex>& iborIndex,      //!< floating leg IborIndex object ID.
            Spread spread,                                      //!< floating leg spread.
            const DayCounter& floatingDayCount                  //!< floating day counter (e.g. Actual/360).
            /*,boost::optional<BusinessDayConvention> paymentConvention =
                                                                 boost::none*/
        );
        %generate(c#, fairRate);
        //! returns the fair fixed leg rate which would zero the swap NPV for the given VanillaSwap object.
        Rate fairRate();                                                                 
    };
}

