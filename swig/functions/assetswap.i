
%group(Asset Swap);

%insert(obj_hpp) %{
#include <qlo/objects/obj_swap.hpp>

#include <ql/types.hpp>

namespace QuantLib {
    class Bond;
    class Swap;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_bonds.hpp>
#include <ql/instruments/assetswap.hpp>
%}

namespace QuantLib {

    class AssetSwap : public Swap {
      public:

        AssetSwap(
            bool PayBondCoupon/*=false*/,                           //!< TRUE to pay the bond's coupons and receive floating.
            const boost::shared_ptr<Bond>& Bond,                    //!< Underlying bond object ID.
            Real CleanPrice,                                        //!< Market price of the underlying bond.
            const boost::shared_ptr<IborIndex>& IborIndex,          //!< Floating leg IborIndex object ID.
            Spread Spread/*=0.0*/,                                  //!< Floating leg spread.
            const boost::shared_ptr<Schedule>& FloatingLegSchedule/*=Schedule()*/,//!< Floating leg schedule object ID.
            const DayCounter& FloatingLegDayCounter,                //!< Floating day counter (e.g. Actual/360).
            bool ParAssetSwap = true                                //!< TRUE for par asset swap, FALSE for market asset swap.
        );

        %rename(AssetSwap2) AssetSwap;
        AssetSwap(
            bool parAssetSwap/*=true*/,                             //!< TRUE for par asset swap, FALSE for market asset swap.
            const boost::shared_ptr<Bond>& Bond,                    //!< Underlying bond object ID.
            Real CleanPrice,                                        //!< Market price of the underlying bond.
            Real NonParRepayment,                                   //!< Non par repayment on deal maturity date.
            Real Gearing/*=1.0*/,                                   //!< Gearing.
            const boost::shared_ptr<IborIndex>& IborIndex,          //!< Floating leg IborIndex object ID.
            Spread Spread = 0.0,                                    //!< Floating leg spread.
            const DayCounter& FloatingLegDayCounter = DayCounter(), //!< Floating day counter (e.g. Actual/360).
            const Date& DealMaturity = Date(),                      //!< Deal maturity (bond maturity if missing).
            bool PayBondCoupon = false                              //!< TRUE to pay the bond's coupons and receive floating.
        );

        //! The bond leg cash flow analysis.
        %wrap(bondLegAnalysis);
        std::vector<std::vector<reposit::property_t> > bondLegAnalysis(
            const Date& AfterDate=Date()                            //!< Shows only cashflows after given date.
        );

        //! The floating leg cash flow analysis.
        %wrap(floatingLegAnalysis);
        std::vector<std::vector<reposit::property_t> > floatingLegAnalysis(
            const Date& AfterDate=Date()                            //!< Shows only cashflows after given date.
        );

        //! The fair rate of the asset swap, i.e. the asset swap spread.
        Spread fairSpread() const;

        //! The BPS of the floating leg.
        Real floatingLegBPS() const;

        //! The fair price of the bond in the asset swap.
        Real fairCleanPrice() const;

        //! The fair non par repayment of the bond in the asset swap.
        Real fairNonParRepayment() const;

        //! Returns TRUE if par swap
        bool parSwap() const;

        //! Returns TRUE if it is a bond coupon payer swap
        bool payBondCoupon() const;
    };
}

