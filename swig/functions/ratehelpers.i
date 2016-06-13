
%group(ratehelpers);
%groupCaption(Rate Helpers);
%override;

%insert(ratehelpers_addin_cpp) %{
#include <qlo/objmanual_quote.hpp>
#include <qlo/objmanual_indexes.hpp>
#include <qlo/obj_termstructures.hpp>
%}

namespace QuantLib {

    class RateHelper {
      public:
        //! returns the earliest date for the given RateHelper object.
        Date earliestDate();
        //! returns the latest date for the given RateHelper object.
        Date latestDate();
        //! returns the curve implied quote of the given RateHelper object.
        Real impliedQuote();
        //! returns the pillar date for the given RateHelper object.
        Date pillarDate();
    };
}

namespace QuantLibAddin {

    class RateHelper {
      public:
        //! returns the objectID of the Quote wrapped in the given RateHelper object.
        std::string quoteName();
        //! returns the value of the Quote wrapped in the given RateHelper object.
        QuantLib::Real quoteValue();
    };

    class FuturesRateHelper : public RateHelper {
      public:
        FuturesRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& price,                     //!< price quote.
            QuantLib::Futures::Type type,                                       //!< Futures type.
            const QuantLib::Date& immDate,                                      //!< Futures date (IborIndex start date).
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,            //!< IborIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& convAdj                    //!< convexity adjustment quote (i.e. Forward rate = Futures rate - convexity adjustment).
        );
    };

    class DepositRateHelper : public RateHelper {
      public:
        DepositRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& rate,                      //!< deposit quote.
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex             //!< IborIndex object ID.
        );
        // Overloaded ctors; the directive below causes the second to be called qlDepositRateHelper2().
        %rename(DepositRateHelper2) DepositRateHelper;
        DepositRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& rate,                      //!< deposit quote.
            const QuantLib::Period& tenor,                                      //!< deposit length (e.g. 3M for three months).
            QuantLib::Natural fixingDays,                                       //!< fixing days (e.g. 2).
            const QuantLib::Calendar& calendar,                                 //!< holiday calendar (e.g. TARGET).
            QuantLib::BusinessDayConvention convention,                         //!< business day convention (e.g. Modified Following).
            bool endOfMonth,                                                    //!< End of Month rule (TRUE for end of month to end of month termination date, FALSE otherwise).
            const QuantLib::DayCounter& dayCounter                              //!< DayCounter ID.
        );
    };

    class SwapRateHelper : public RateHelper {
      public:
        SwapRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& quote,                     //!< quote.
            const boost::shared_ptr<QuantLib::SwapIndex>& swapIndex,            //!< SwapIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& spread,                    //!< floating leg spread.
            const QuantLib::Period& forwardStart,                               //!< forward start period.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,     //!< discounting YieldTermStructure object ID.
            QuantLib::Pillar::Choice pillarChoice,                              //!< Pillar date can be: MaturityDate, LastRelevantDate or CustomDate.
            QuantLib::Date customPillar                                         //!< Custom Pillar Date.
        );
        // Overloaded ctors; the directive below causes the second to be called qlSwapRateHelper2().
        %rename(SwapRateHelper2) SwapRateHelper;
        SwapRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& rate,                      //!< quote.
            QuantLib::Natural settlementDays,                                   //!< Number of days to spot date.
            const QuantLib::Period& tenor,                                      //!< swap length (e.g. 5Y for five years).
            const QuantLib::Calendar& calendar,                                 //!< holiday calendar (e.g. TARGET).
            const QuantLib::Frequency& fixedFrequency,                          //!< fixed leg frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            QuantLib::BusinessDayConvention fixedConvention,                    //!< fixed leg convention (e.g. Unadjusted).
            const QuantLib::DayCounter& fixedDayCounter,                        //!< day counter (e.g. Actual/360).
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,            //!< floating leg IborIndex object ID.
            const QuantLib::Handle<QuantLib::Quote>& spread,                    //!< floating leg spread.
            const QuantLib::Period& forwardStart,                               //!< forward start period.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,     //!< discounting YieldTermStructure object ID.
            QuantLib::Pillar::Choice pillarChoice,                              //!< Pillar date can be: MaturityDate, LastRelevantDate or CustomDate.
            QuantLib::Date customPillar                                         //!< Custom Pillar Date.
        );
     };

    class FraRateHelper : public RateHelper {
      public:
        FraRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& rate,                      //!< quote.
            QuantLib::Period periodToStart,                                     //!< Period to start date.
            const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,            //!< IborIndex object ID.
            QuantLib::Pillar::Choice pillarChoice,                              //!< Pillar date can be: MaturityDate, LastRelevantDate or CustomDate.
            QuantLib::Date customPillar                                         //!< Custom Pillar Date.
        );
        // Overloaded ctors; the directive below causes the second to be called qlSwapRateHelper2().
        %rename(FraRateHelper2) FraRateHelper;
        FraRateHelper(
            const QuantLib::Handle<QuantLib::Quote>& rate,                      //!< quote.
            QuantLib::Period periodToStart,                                     //!< Period to start date.
            QuantLib::Natural lengthInMonths,                                   //!< months to end.
            QuantLib::Natural fixingDays,                                       //!< fixing days (e.g. 2).
            const QuantLib::Calendar& calendar,                                 //!< holiday calendar (e.g. TARGET).
            QuantLib::BusinessDayConvention convention,                         //!< business day convention (e.g. Modified Following).
            bool endOfMonth,                                                    //!< End of Month rule (TRUE for end of month to end of month termination date, FALSE otherwise).
            const QuantLib::DayCounter& dayCounter                              //!< DayCounter ID.
            /*,QuantLib::Pillar::Choice pillarChoice = Pillar::LastRelevantDate,
            QuantLib::Date customPillar = Date()*/
        );
    };

    class OISRateHelper : public RateHelper {
      public:
        OISRateHelper(
            QuantLib::Natural settlementDays,                                   //!< swap settlement days.
            const QuantLib::Period& tenor,                                      //!< swap length (e.g. 5Y for five years).
            const QuantLib::Handle<QuantLib::Quote>& fixedRate,                 //!< quote.
            const boost::shared_ptr<QuantLib::OvernightIndex>& overnightIndex,  //!< floating leg OvernightIndex object ID.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount      //!< discounting YieldTermStructure object ID.
        );
    };

    class DatedOISRateHelper : public RateHelper {
      public:
        DatedOISRateHelper(
            const QuantLib::Date& startDate,                                    //!< swap start date.
            const QuantLib::Date& endDate,                                      //!< swap end date.
            const QuantLib::Handle<QuantLib::Quote>& fixedRate,                 //!< quote.
            const boost::shared_ptr<QuantLib::OvernightIndex>& overnightIndex,  //!< floating leg OvernightIndex object ID.
            const QuantLib::Handle<QuantLib::YieldTermStructure>& discount      //!< discounting YieldTermStructure object ID.
        );
    };

    std::vector<std::string> rateHelperSelection(
        const std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> >& qlarhs,//!< vector of RateHelper IDs.
        const std::vector<QuantLib::Natural>& priority,                         //!< vector of priority integers (higher number for higher priority).
        QuantLib::Natural nImmFutures,                                          //!< max number of IMM (March, June, September, December) Futures to be included.
        QuantLib::Natural nSerialFutures,                                       //!< max number of Serial (January, February, April, May, July, August, October, November) Futures to be included.
        QuantLib::Natural frontFuturesRollingDays,                              //!< discard the front Futures the given number of (positive) days before its expiry (e.g zero implies the use of the front Futures during its expiry day).
        RateHelper::DepoInclusionCriteria depoInclusionCriteria,                //!< Depo inclusion criteria.
        const std::vector<QuantLib::Natural>& minDistance                       //!< minimum distance in (positive) days from near instruments.
    );

    QuantLib::Real rateHelperRate(
        //! returns the rate (if any) associated to a rate helper.
        const boost::shared_ptr<QuantLibAddin::RateHelper>& qlarh               //!< RateHelper ID.
    );
}

