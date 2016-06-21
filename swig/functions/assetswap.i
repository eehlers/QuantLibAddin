
%group(assetswap);
%groupCaption(Asset Swap);
//%groupFunctionWizard(QuantLib - Financial);
//%override;

%insert(assetswap_library_hpp) %{
#include <ql/instruments/assetswap.hpp>
%}

namespace QuantLib {

    class AssetSwap : public Swap {
      public:
//        class arguments;
//        class results;

        AssetSwap(bool payBondCoupon,
                  const boost::shared_ptr<Bond>& bond,
                  Real bondCleanPrice,
                  const boost::shared_ptr<IborIndex>& iborIndex,
                  Spread spread,
                  const Schedule& floatSchedule = Schedule(),
                  const DayCounter& floatingDayCount = DayCounter(),
                  bool parAssetSwap = true);

        // Overloaded ctors; the directive below causes the second to be called qlAssetSwap2().
        %rename(AssetSwap2) AssetSwap;
        AssetSwap(bool parAssetSwap,
                  const boost::shared_ptr<Bond>& bond,
                  Real bondCleanPrice,
                  Real nonParRepayment,
                  Real gearing,
                  const boost::shared_ptr<IborIndex>& iborIndex,
                  Spread spread = 0.0,
                  const DayCounter& floatingDayCount = DayCounter(),
                  Date dealMaturity = Date(),
                  bool payBondCoupon = false);
        // results
        Spread fairSpread() const;
        Real floatingLegBPS() const;
//        Real floatingLegNPV() const;
        Real fairCleanPrice() const;
        Real fairNonParRepayment() const;
        // inspectors
        bool parSwap() const { return parSwap_; }
//        Spread spread() const { return spread_; }
//        Real cleanPrice() const { return bondCleanPrice_; }
//        Real nonParRepayment() const { return nonParRepayment_; }
//        const boost::shared_ptr<Bond>& bond() const { return bond_; }
        bool payBondCoupon() const { return (payer_[0] == -1.0); }
//        const Leg& bondLeg() const { return legs_[0]; }
//        const Leg& floatingLeg() const { return legs_[1]; }
    };
}

//namespace QuantLibAddin {
//    class AssetSwap : public Swap {
//      public:
//        std::vector<std::vector<ObjectHandler::property_t> > floatingLegAnalysis(
//            const QuantLib::Date& d);
//      };
//}
