
%group(ratehelpers);
%groupCaption(Rate Helpers);
%override;

%insert(ratehelpers_addin_cpp) %{
#include <qlo/objmanual_quotes.hpp>
#include <qlo/objmanual_bonds.hpp>
#include <qlo/obj_termstructures.hpp>
#include <qlo/obj_schedule.hpp>
#include <qlo/indexes/iborindex.hpp>
#include <qlo/indexes/swapindex.hpp>
%}

namespace QuantLib {

    class RateHelper {
      public:
        //! returns the earliest date for the given RateHelper object.
        Date earliestDate();
        //! returns the latest date for the given RateHelper object.
        Date latestDate();
        //! returns the latest relevant date for the given RateHelper object.
        Date latestRelevantDate();
        //! returns the pillar date for the given RateHelper object.
        Date pillarDate();
        //! returns the maturity date for the given RateHelper object.
        Date maturityDate();
        //! returns the curve implied quote of the given RateHelper object.
        Real impliedQuote();
        //! returns the error between the curve implied quote and the value of the Quote wrapped in the given RateHelper object.
        Real quoteError();        
    };
    
    class FuturesRateHelper : public RateHelper {
      public:
        //! returns the convexity adjustment for the given FuturesRateHelper object.
        Real convexityAdjustment() const;
    };
    
    class SwapRateHelper : public /*RelativeDateRateHelper*/RateHelper {
      public:
        //!< returns the spread for the given SwapRateHelper object.
        Spread spread() const;
        //!< returns the forward start period for the given SwapRateHelper object.
        const Period& forwardStart() const;
    };

    class FxSwapRateHelper : public RateHelper {
      public:
        //! returns the fx spot quote value for the given FxSwapRateHelper object.
        %rename(spotValue) spot;
        Real spot();
        //! returns the tenor for the given FxSwapRateHelper object.
        Period tenor();
        //! returns the number of fixing days for the given FxSwapRateHelper object.
        Natural fixingDays();
        //! returns the calendar for the given FxSwapRateHelper object.
        Calendar calendar();
        //! returns the business day convention for the given FxSwapRateHelper object.
        %rename(BDC) businessDayConvention;
        BusinessDayConvention businessDayConvention();
        //! returns the end of month flag for the given FxSwapRateHelper object.
        %rename(EOM) endOfMonth;
        bool endOfMonth();
        //! returns TRUE if the base currency of the fx currency pair is the one used as collateral, FALSE otherwise.
        %rename(isBaseCurrencyCollateralCurrency) isFxBaseCurrencyCollateralCurrency;
        bool isFxBaseCurrencyCollateralCurrency();
    };
}

namespace QuantLibAddin {

    class RateHelper {
      public:
        //! returns the objectID of the Quote wrapped in the given RateHelper object.
        std::string quoteName();
        //! returns the value of the Quote wrapped in the given RateHelper object.
        QuantLib::Real quoteValue();
        //! returns the isValid boolean of the Quote wrapped in the given RateHelper object.
        bool quoteIsValid();
    };

    class FuturesRateHelper : public RateHelper {
      public:
        FuturesRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Price,                                                                             //!< price quote.
            QuantLib::Futures::Type FuturesType/*=QuantLib::Futures::Type(QuantLib::Futures::IMM)*/,                                    //!< Futures type.
            const QuantLib::Date& FuturesDate,                                                                                          //!< Futures date (IborIndex start date).
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex/*=Euribor3M*/,                                                      //!< IborIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& ConvexityAdjQuote                                                                  //!< convexity adjustment quote (i.e. Forward rate = Futures rate - convexity adjustment).
        );
        // Overloaded ctors; the directive below causes the second to be called qlFuturesRateHelper2().
        %rename(FuturesRateHelper2) FuturesRateHelper;
        FuturesRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Price,                                                                             //!< price quote.
            QuantLib::Futures::Type FuturesType/*=QuantLib::Futures::Type(QuantLib::Futures::IMM)*/,                                    //!< Futures type.
            const QuantLib::Date& FuturesDate,                                                                                          //!< Futures date (IborIndex start date).
            QuantLib::Natural LengthInMonths/*=3*/,                                                                                     //!< future contract length in months.
            const QuantLib::Calendar& Calendar,                                                                                         //!< holiday calendar (e.g. TARGET).
            QuantLib::BusinessDayConvention Convention/*=QuantLib::BusinessDayConvention(QuantLib::ModifiedFollowing)*/,                //!< business day convention (e.g. Modified Following).
            bool EndOfMonth/*=true*/,                                                                                                   //!< End of Month rule (TRUE for end of month to end of month termination date, FALSE otherwise).
            const QuantLib::DayCounter& DayCounter/*=QuantLib::Actual360()*/,                                                           //!< DayCounter ID.
            const QuantLib::Handle<QuantLib::Quote>& ConvexityAdjQuote                                                                  //!< convexity adjustment quote (i.e. Forward rate = Futures rate - convexity adjustment).
        );
        // Overloaded ctors; the directive below causes the second to be called qlFuturesRateHelper3().
        %rename(FuturesRateHelper3) FuturesRateHelper;
        FuturesRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Price,                                                                             //!< price quote.
            QuantLib::Futures::Type FuturesType/*=QuantLib::Futures::Type(QuantLib::Futures::IMM)*/,                                    //!< Futures type.
            const QuantLib::Date& FuturesDate,                                                                                          //!< Futures date (IborIndex start date).
            const QuantLib::Date& EndDate/*=QuantLib::Date()*/,                                                                         //!< end date.
            const QuantLib::DayCounter& DayCounter/*=QuantLib::Actual360()*/,                                                           //!< DayCounter ID.
            const QuantLib::Handle<QuantLib::Quote>& ConvexityAdjQuote                                                                  //!< convexity adjustment quote (i.e. Forward rate = Futures rate - convexity adjustment).
        );
    };

    class DepositRateHelper : public RateHelper {
      public:
        DepositRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Rate,                                                                              //!< deposit quote.
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex                                                                     //!< IborIndex object ID.
        );
        // Overloaded ctors; the directive below causes the second to be called qlDepositRateHelper2().
        %rename(DepositRateHelper2) DepositRateHelper;
        DepositRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Rate,                                                                              //!< deposit quote.
            const QuantLib::Period& Tenor,                                                                                              //!< deposit length (e.g. 3M for three months).
            QuantLib::Natural FixingDays,                                                                                               //!< fixing days (e.g. 2).
            const QuantLib::Calendar& Calendar,                                                                                         //!< holiday calendar (e.g. TARGET).
            QuantLib::BusinessDayConvention Convention,                                                                                 //!< business day convention (e.g. Modified Following).
            bool EndOfMonth,                                                                                                            //!< End of Month rule (TRUE for end of month to end of month termination date, FALSE otherwise).
            const QuantLib::DayCounter& DayCounter                                                                                      //!< DayCounter ID.
        );
    };

    class SwapRateHelper : public RateHelper {
      public:
        SwapRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Rate,                                                                              //!< quote.
            const boost::shared_ptr<QuantLib::SwapIndex>& SwapIndex,                                                                    //!< SwapIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& Spread,                                                                            //!< floating leg spread.
            const QuantLib::Period& ForwardStart,                                                                                       //!< forward start period.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscountingCurve=QuantLib::Handle<QuantLib::YieldTermStructure>(),    //!< discounting YieldTermStructure object ID.
            QuantLib::Pillar::Choice PillarDate=QuantLib::Pillar::Choice(QuantLib::Pillar::MaturityDate),                               //!< Pillar date can be: MaturityDate, LastRelevantDate or CustomDate.
            QuantLib::Date CustomPillarDate=QuantLib::Date()                                                                            //!< Custom Pillar Date.
        );
        // Overloaded ctors; the directive below causes the second to be called qlSwapRateHelper2().
        %rename(SwapRateHelper2) SwapRateHelper;
        SwapRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Rate,                                                                              //!< quote.
            QuantLib::Natural SettlementDays,                                                                                           //!< Number of days to spot date.
            const QuantLib::Period& Tenor,                                                                                              //!< swap length (e.g. 5Y for five years).
            const QuantLib::Calendar& Calendar,                                                                                         //!< holiday calendar (e.g. TARGET).
            const QuantLib::Frequency& FixedLegFrequency,                                                                               //!< fixed leg frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            QuantLib::BusinessDayConvention FixedLegConvention,                                                                         //!< fixed leg convention (e.g. Unadjusted).
            const QuantLib::DayCounter& FixedLegDayCounter,                                                                             //!< day counter (e.g. Actual/360).
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                                                    //!< floating leg IborIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& Spread,                                                                            //!< floating leg spread.
            const QuantLib::Period& ForwardStart,                                                                                       //!< forward start period.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscountingCurve=QuantLib::Handle<QuantLib::YieldTermStructure>(),    //!< discounting YieldTermStructure object ID.
            QuantLib::Pillar::Choice PillarDate=QuantLib::Pillar::Choice(QuantLib::Pillar::MaturityDate),                               //!< Pillar date can be: MaturityDate, LastRelevantDate or CustomDate.
            QuantLib::Date CustomPillarDate=QuantLib::Date()                                                                            //!< Custom Pillar Date.
        );
     };

    class FraRateHelper : public RateHelper {
      public:
        FraRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Rate,                                                                              //!< quote.
            QuantLib::Period PeriodToStart,                                                                                             //!< Period to start date.
            const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                                                    //!< IborIndex object ID.
            QuantLib::Pillar::Choice PillarDate=QuantLib::Pillar::Choice(QuantLib::Pillar::MaturityDate),                               //!< Pillar date can be: MaturityDate, LastRelevantDate or CustomDate.
            QuantLib::Date CustomPillarDate=QuantLib::Date()                                                                            //!< Custom Pillar Date.
        );
        // Overloaded ctors; the directive below causes the second to be called qlSwapRateHelper2().
        %rename(FraRateHelper2) FraRateHelper;
        FraRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& Rate,                                                                              //!< quote.
            QuantLib::Period PeriodToStart,                                                                                             //!< Period to start date.
            QuantLib::Natural LengthInMonths,                                                                                           //!< months to end.
            QuantLib::Natural FixingDays,                                                                                               //!< fixing days (e.g. 2).
            const QuantLib::Calendar& Calendar,                                                                                         //!< holiday calendar (e.g. TARGET).
            QuantLib::BusinessDayConvention Convention,                                                                                 //!< business day convention (e.g. Modified Following).
            bool EndOfMonth,                                                                                                            //!< End of Month rule (TRUE for end of month to end of month termination date, FALSE otherwise).
            const QuantLib::DayCounter& DayCounter,                                                                                     //!< DayCounter ID.
            QuantLib::Pillar::Choice PillarDate=QuantLib::Pillar::Choice(QuantLib::Pillar::MaturityDate),                               //!< Pillar date can be: MaturityDate, LastRelevantDate or CustomDate.
            QuantLib::Date CustomPillarDate=QuantLib::Date()                                                                            //!< Custom Pillar Date.
        );
    };

    class OISRateHelper : public RateHelper {
      public:
        OISRateHelper(
            QuantLib::Natural SettlementDays,                                                                                           //!< swap settlement days.
            const QuantLib::Period& Tenor,                                                                                              //!< swap length (e.g. 5Y for five years).
            const QuantLib::Handle<QuantLib::Quote>& FixedRate,                                                                         //!< quote.
            const boost::shared_ptr<QuantLib::OvernightIndex>& ONIndex,                                                                 //!< floating leg OvernightIndex object ID.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscountingCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()     //!< discounting YieldTermStructure object ID.
        );
    };

    class DatedOISRateHelper : public RateHelper {
      public:
        DatedOISRateHelper(
            const QuantLib::Date& StartDate,                                                                                            //!< swap start date.
            const QuantLib::Date& EndDate,                                                                                              //!< swap end date.
            const QuantLib::Handle<QuantLib::Quote>& FixedRate,                                                                         //!< quote.
            const boost::shared_ptr<QuantLib::OvernightIndex>& ONIndex,                                                                 //!< floating leg OvernightIndex object ID.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscountingCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()     //!< discounting YieldTermStructure object ID.
        );
    };

    class BondHelper : public RateHelper {
      public:
        BondHelper(
            const QuantLib::Handle<QuantLib::Quote>& Price,                                                                             //!< price.
            const boost::shared_ptr<QuantLib::Bond>& Bond,                                                                              //!< Bond object ID.
            const bool UseCleanPrice=true                                                                                               //!< Type of price specified (TRUE clean price, FALSE for dirty price).
        );
    };

    class FixedRateBondHelper : public BondHelper {
      public:
        FixedRateBondHelper(
            const QuantLib::Handle<QuantLib::Quote>& Price,                                                                             //!< Price - either clean or dirty.
            QuantLib::Natural SettlementDays,                                                                                           //!< settlement days.
            QuantLib::Real FaceAmount/*=100.0*/,                                                                                        //!< Face nominal amount.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                                                                    //!< Schedule object ID.
            const std::vector<QuantLib::Rate>& Coupons,                                                                                 //!< coupon fixed rates.
            const QuantLib::DayCounter& DayCounter,                                                                                     //!< Payment DayCounter ID.
            QuantLib::BusinessDayConvention PaymentBDC/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,                        //!< payment business day convention
            QuantLib::Real Redemption/*=100.0*/,                                                                                        //!< redemption value.
            const QuantLib::Date& IssueDate/*=QuantLib::Date()*/,                                                                       //!< issue date: the bond can't be traded until then.
            const QuantLib::Calendar& PaymentCalendar,                                                                                  //!< holiday calendar (e.g. TARGET).
            const QuantLib::Period& ExCouponPeriod,                                                                                     //!< Ex-coupon period.
            const QuantLib::Calendar& ExCouponCalendar,                                                                                 //!< Ex-coupon calendar (e.g. TARGET).
            const QuantLib::BusinessDayConvention ExCouponBDC,                                                                          //!< Ex-coupon business day convention (e.g. Modified Following).
            bool ExCouponEndOfMonth,                                                                                                    //!< Ex-coupon end of month rule (TRUE for end of month to end of month termination date, FALSE otherwise).
            const bool UseCleanPrice=true                                                                                               //!< Type of price specified (TRUE clean price, FALSE for dirty price).
        );
    };

    class FxSwapRateHelper : public RateHelper {
      public:
        FxSwapRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& FwdPoint,                                                                          //!< forward point quote.
            const QuantLib::Handle<QuantLib::Quote>& SpotFx,                                                                            //!< fx spot quote.
            const QuantLib::Period& Tenor,                                                                                              //!< fx swap length (e.g. 3M for three months).
            QuantLib::Natural FixingDays,                                                                                               //!< fixing days (e.g. 2).
            const QuantLib::Calendar& Calendar,                                                                                         //!< holiday calendar (e.g. TARGET).
            QuantLib::BusinessDayConvention Convention/*=QuantLib::BusinessDayConvention(QuantLib::Following)*/,                        //!< payment business day convention
            bool EndOfMonth,                                                                                                            //!< End of Month rule (TRUE for end of month to end of month termination date, FALSE otherwise).
            bool IsFxBaseCurrencyCollateralCurrency,                                                                                    //!< TRUE if the base currency of the fx currency pair is the one used as collateral, FALSE otherwise.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& CollateralCurve                                                       //!< collateral YieldTermStructure object ID.
        );
    };
                 
    std::vector<std::string> rateHelperSelection(
        const std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> >& RateHelpers,                                                  //!< vector of RateHelper IDs.
        const std::vector<QuantLib::Natural>& Priority,                                                                                 //!< vector of priority integers (higher number for higher priority).
        QuantLib::Natural NImmFutures,                                                                                                  //!< max number of IMM (March, June, September, December) Futures to be included.
        QuantLib::Natural NSerialFutures,                                                                                               //!< max number of Serial (January, February, April, May, July, August, October, November) Futures to be included.
        QuantLib::Natural FutureRollDays/*=2*/,                                                                                         //!< discard the front Futures the given number of (positive) days before its expiry (e.g zero implies the use of the front Futures during its expiry day).
        RateHelper::DepoInclusionCriteria DepoInclusion/*=RateHelper::DepoInclusionCriteria(RateHelper::AllDepos)*/,                    //!< Depo inclusion criteria.
        const std::vector<QuantLib::Natural>& MinDistance/*=1?*/                                                                        //!< minimum distance in (positive) days from near instruments.
    );

    QuantLib::Real rateHelperRate(
        //! returns the rate (if any) associated to a rate helper.
        const boost::shared_ptr<QuantLibAddin::RateHelper>& RateHelper                                                                  //!< RateHelper ID.
    );
}

