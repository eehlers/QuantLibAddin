
%group(Swap);

%insert(obj_hpp) %{
#include <qlo/objects/obj_couponvectors.hpp>

namespace QuantLib {
    class CmsCouponPricer;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_swap.hpp>
#include <qlo/objects/obj_indexes.hpp>
#include <qlo/objects/obj_termstructures.hpp>
#include <qlo/objects/obj_couponvectors.hpp>
#include <ql/instruments/swap.hpp>
#include <ql/indexes/iborindex.hpp>
#include <ql/indexes/swapindex.hpp>
#include <ql/termstructures/yieldtermstructure.hpp>
%}

namespace QuantLib {

    //class Instrument{};

    class Swap /*: public Instrument*/ {
      public:

        Swap(
             const std::vector<QuantLib::Leg>& legs,                            //!< Leg object IDs.
             const std::vector<bool>& payer                                     //!< TRUE for payed leg.
        );

        %rename(MakeCms) Swap;
        Swap(
             const QuantLib::Period& SwapTenor,                                 //!< Swap tenor period.
             const boost::shared_ptr<QuantLib::SwapIndex>& SwapIndex,           //!< SwapIndex object ID.
             const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,           //!< IborIndex object ID.
             QuantLib::Spread IborSpread/*QuantLib::Null<QuantLib::Spread>()*/, //!< Spread over the ibor leg.
             const QuantLib::Period& ForwardStart,                              //!< Forward start period.
             const boost::shared_ptr<QuantLib::CmsCouponPricer>& Pricer         //!< CmsCouponPricer object ID.
        );

        //! Returns the BPS of the i-th leg for the given Swap object.
        Real legBPS(
            Size LegNumber                                                  //!< Zero based leg number (e.g. use 0 for the first leg, 1 for the second leg, etc.).
        ) const;

        //! returns the NPV of the i-th leg for the given Swap object.
        Real legNPV(
            Size LegNumber                                                  //!< Zero based leg number (e.g. use 0 for the first leg, 1 for the second leg, etc.).
        ) const;

        //! Returns the start (i.e. first accrual) date for the given Swap object.
        Date startDate() const;

        //! Returns the maturity (i.e. last payment) date for the given Swap object.
        Date maturityDate() const;

%insert(rp_class) %{
        std::vector<std::vector<reposit::property_t> > legAnalysis(
            QuantLib::Size LegNumber,
            const QuantLib::Date& AfterDate=QuantLib::Date()
        );

      //protected:
      //  RP_OBJ_CTOR(Swap, Instrument);
%}
    };
}
    
namespace QuantLibAddin {

    %noctor(Swap);
    %noexport(Swap);
    class Swap /*: public Instrument*/ {
      public:

        //! Returns the cash flow analysis of the i-th leg for the given Swap object.
        std::vector<std::vector<reposit::property_t> > legAnalysis(
            QuantLib::Size LegNumber,                                           //!< Zero based leg number (e.g. use 0 for the first leg, 1 for the second leg, etc.).
            const QuantLib::Date& AfterDate=QuantLib::Date()                    //!< Shows only cashflows after given date
        );
    };
}
