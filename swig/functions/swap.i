
%group(swap);
%groupCaption(Swap);

%override;

%insert(swap_library_hpp) %{
//#include <ql/instruments/vanillaoption.hpp>
//#include <ql/cashflow.hpp>
//#include <ql/instruments/swap.hpp>
//#include <ql/instruments/swaption.hpp>
//#include <ql/instruments/forwardrateagreement.hpp>
#include <qlo/obj_instruments.hpp>
%}

%insert(swap_addin_cpp) %{
#include <qlo/objmanual_leg.hpp>
#include <qlo/indexes/swapindex.hpp>
#include <qlo/indexes/iborindex.hpp>
#include <qlo/conundrumpricer.hpp>
//#include <qlo/obj_pricingengines.hpp>
//#include <qlo/obj_payoffs.hpp>
//#include <qlo/obj_exercise.hpp>
//#include <qlo/obj_vanillaswaps.hpp>
//#include <qlo/objmanual_termstructures.hpp>
%}

namespace QuantLib {

    class Swap /*: public Instrument*/ {
        public:
            %rename(SwapLegBPS) legBPS;
            //! returns the BPS of the i-th leg for the given Swap object.
            Real legBPS(
                Size LegNumber                                                  //!< Zero based leg number (e.g. use 0 for the first leg, 1 for the second leg, etc.).
            ) const;
            %rename(SwapLegNPV) legBPS;
            //! returns the NPV of the i-th leg for the given Swap object.
            Real legNPV(
                Size LegNumber                                                  //!< Zero based leg number (e.g. use 0 for the first leg, 1 for the second leg, etc.).
            ) const;
            //! Returns the start (i.e. first accrual) date for the given Swap object.
            Date startDate() const;
            //! Returns the maturity (i.e. last payment) date for the given Swap object.
            Date maturityDate() const;
    };
}
    
namespace QuantLibAddin {

    class Swap : public Instrument {
      public:
        Swap(
             const std::vector<QuantLib::Leg>& legs,                            //!< leg object IDs.
             const std::vector<bool>& payer                                     //!< TRUE for payed leg.
        );
        %rename(MakeCms) Swap;
        Swap(
             const QuantLib::Period& swapTenor,                                 //!< swap tenor period.
             const boost::shared_ptr<QuantLib::SwapIndex>& swapIndex,           //!< SwapIndex object ID.
             const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,           //!< IborIndex object ID.
             QuantLib::Spread iborSpread,                                       //!< spread over the ibor leg.
             const QuantLib::Period& forwardStart,                              //!< forward start period.
             const boost::shared_ptr<QuantLib::CmsCouponPricer>& pricer         //!< CmsCouponPricer object ID.
        );

        //! Returns the cash flow analysis of the i-th leg for the given Swap object.
        std::vector<std::vector<reposit::property_t> > legAnalysis(
            QuantLib::Size LegNumber,                                           //!< Zero based leg number (e.g. use 0 for the first leg, 1 for the second leg, etc.).
            const QuantLib::Date& AfterDate=QuantLib::Date()                    //!< Shows only cashflows after given date
        );

      protected:
        RP_OBJ_CTOR(Swap, Instrument);
    };
}
