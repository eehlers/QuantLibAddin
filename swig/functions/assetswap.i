
%group(assetswap);
%groupCaption(Asset Swap);
// The only class that requires a manual override is QuantLibAddin::AssetSwap...
//%override;

%insert(assetswap_library_hpp) %{
#include <ql/instruments/assetswap.hpp>
#include <qlo/obj_instruments.hpp>
%}

%insert(assetswap_addin_cpp) %{
#include <qlo/obj_schedule.hpp>
#include <qlo/objmanual_bonds.hpp>
#include <qlo/indexes/iborindex.hpp>
%}

namespace QuantLib {

    class AssetSwap : public /*Swap*/Instrument {
      public:
        AssetSwap(
            bool payBondCoupon/*=false*/,                           //!< TRUE to pay the bond's coupons and receive floating.
            const boost::shared_ptr<Bond>& bond,                    //!< underlying bond object ID.
            Real bondCleanPrice,                                    //!< market price of the underlying bond.
            const boost::shared_ptr<IborIndex>& iborIndex,          //!< floating leg IborIndex object ID.
            Spread spread/*=0.0*/,                                  //!< Floating leg spread.
            const Schedule& floatSchedule/* = Schedule()*/,         //!< floating leg schedule object ID.
            const DayCounter& floatingDayCount = DayCounter(),      //!< floating day counter (e.g. Actual/360).
            bool parAssetSwap = true                                //!< TRUE for par asset swap, FALSE for market asset swap.
        );

        // Overloaded ctors; the directive below causes the second to be called qlAssetSwap2().
        %alias(AssetSwap2, AssetSwap);
        AssetSwap(
            bool parAssetSwap/*=true*/,                             //!< TRUE for par asset swap, FALSE for market asset swap.
            const boost::shared_ptr<Bond>& bond,                    //!< underlying bond object ID.
            Real bondCleanPrice,                                    //!< market price of the underlying bond.
            Real nonParRepayment,                                   //!< non par repayment on deal maturity date.
            Real gearing/*=1.0*/,                                   //!< gearing.
            const boost::shared_ptr<IborIndex>& iborIndex,          //!< floating leg IborIndex object ID.
            Spread spread = 0.0,                                    //!< Floating leg spread.
            const DayCounter& floatingDayCount = DayCounter(),      //!< floating day counter (e.g. Actual/360).
            Date dealMaturity = Date(),                             //!< deal maturity (bond maturity if missing).
            bool payBondCoupon = false                              //!< TRUE to pay the bond's coupons and receive floating.
        );
        //! the fair rate of the asset swap, i.e. the asset swap spread.
        Spread fairSpread() const;
        //! the BPS of the floating leg.
        Real floatingLegBPS() const;
        //Real floatingLegNPV() const;
        //! the fair price of the bond in the asset swap.
        Real fairCleanPrice() const;
        //! the fair non par repayment of the bond in the asset swap.
        Real fairNonParRepayment() const;
        //! Returns TRUE if par swap
        bool parSwap() const { return parSwap_; }
        //Spread spread() const { return spread_; }
        //Real cleanPrice() const { return bondCleanPrice_; }
        //Real nonParRepayment() const { return nonParRepayment_; }
        //const boost::shared_ptr<Bond>& bond() const { return bond_; }
        //! Returns TRUE if it is a bond coupon payer swap
        bool payBondCoupon() const { return (payer_[0] == -1.0); }
        //const Leg& bondLeg() const { return legs_[0]; }
        //const Leg& floatingLeg() const { return legs_[1]; }
    };
}

//namespace QuantLibAddin {
//    class AssetSwap : public Swap {
//      public:
//        std::vector<std::vector<reposit::property_t> > floatingLegAnalysis(
//            const QuantLib::Date& d);
//        std::vector<std::vector<reposit::property_t> > bondLegAnalysis(
//            const QuantLib::Date& d);
//      };
//}
