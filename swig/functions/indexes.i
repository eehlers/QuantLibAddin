
%group(indexes);
%groupCaption(Indexes);
%override;

%insert(indexes_addin_cpp) %{
#include <qlo/indexes/bmaindex.hpp>
#include <qlo/indexes/ibor/euribor.hpp>
#include <qlo/indexes/ibor/libor.hpp>
#include <qlo/indexes/swap/euriborswap.hpp>
#include <qlo/indexes/swap/isdafixaswap.hpp>
#include <qlo/indexes/swap/liborswap.hpp>
#include <qlo/obj_termstructures.hpp>
#include <ql/indexes/iborindex.hpp>
#include <ql/termstructures/yieldtermstructure.hpp>
#include <ql/experimental/coupons/proxyibor.hpp>
%}

// For most of the QuantLib index classes, we have handwritten code in the
// QuantLibAddin layer to provide custom behavior.

// In the QuantLib namespace we define member functions which are invoked
// directly on the underlying QuantLib objects.

namespace QuantLib {

    class Index {
        public:
            //! Returns the name for the given Index object.
            std::string name();
            //! Returns the calendar (e.g. TARGET) for the given Index object.
            Calendar fixingCalendar();
            //! Returns TRUE if the fixing date is a valid one for the given Index object.
            %loop(isValidFixingDate, FixingDate);
            bool isValidFixingDate(
                const Date& FixingDate                  //!< fixing date(s).
            ) const;
            //! Returns the fixing for the given Index object. The fixing is retrieved from the time series if available, otherways it is forecasted.
            %loop(fixing, FixingDate);
            double fixing(
                const Date& FixingDate,                 //!< fixing date(s).
                bool ForecastToday=false                //!< If set to TRUE it forces the forecasting of today's fixing even if the actual fixing is already available in the time series.
            ) const;
            //! Adds fixings for the given Index object.
            %rename(addFixings2) addFixings;
            %loop(addFixings, TimeSeriesID);
            void addFixings(
                const TimeSeries<Real>& TimeSeriesID,   //!< TimeSeries object ID.
                bool ForceOverwrite=false               //!< Set to TRUE to force overwriting of existing fixings, if any.
            );
            //!< Clear all fixings for the given Index object.
            void clearFixings();
    };

    class InterestRateIndex : public Index {
        public:
            //! Returns the family name (e.g. EURIBOR) for the given InterestRateIndex object.
            std::string familyName();
            //! Returns the tenor (i.e. length, e.g. 6M, 10Y) for the given InterestRateIndex object.
            Period tenor();
            //! Returns the fixing days (e.g. 2) for the given InterestRateIndex object.
            Natural fixingDays();
            //! Returns the currency (e.g. EUR) for the given InterestRateIndex object.
            const Currency& currency();
            //! Returns the DayCounter (e.g. Actual/360) for the given InterestRateIndex object.
            %generate(c#, dayCounter);
            const DayCounter& dayCounter();
            //! Returns the value date for the given fixing date for the given InterestRateIndex object.
            %loop(valueDate, FixingDate);
            Date valueDate(
                const Date& FixingDate                  //!< fixing date(s).
            ) const;
            //! Returns the fixing date for the given value date for the given InterestRateIndex object.
            %loop(fixingDate, ValueDate);
            Date fixingDate(
                const Date& ValueDate                   //!< value date.
            ) const;
            //! Returns the maturity date for the given value date for the given InterestRateIndex object.
            %rename(maturity) maturityDate;
            %loop(maturity, ValueDate);
            Date maturityDate(
                const Date& ValueDate                   //!< value date.
            ) const;
    };

    class IborIndex : public InterestRateIndex {
        public:
            //!< Returns the business day convention (e.g. Modified Following) for the given IborIndex object.
            %rename(IborIndexBusinessDayConv) businessDayConvention;
            BusinessDayConvention businessDayConvention();        
            //! Returns TRUE if the given IborIndex object follows the 'end of month' convention.
            bool endOfMonth();
    };
    
    class SwapIndex : public InterestRateIndex {
        public:
            //! Returns the fixed leg tenor (e.g. 1Y) for the given SwapIndex object.
            Period fixedLegTenor();
            //! Returns the business day convention (e.g. Modified Following) for the given SwapIndex object.
            %rename(fixedLegBDC) fixedLegConvention;
            BusinessDayConvention fixedLegConvention();
    };
}

// In the QuantLibAddin namespace we define all of the constructors and 
// member functions of the QuantLibAddin wrapper classes.

namespace QuantLibAddin {

    class Index {
        public:
            //! Adds fixings for the given Index object.
            void addFixings(
                const std::vector<QuantLib::Date>& FixingDates,                                                                     //!< fixing dates.
                const std::vector<QuantLib::Real>& FixingValues,                                                                    //!< fixing values.
                bool ForceOverwrite=false                                                                                           //!< Set to TRUE to force overwriting of existing fixings, if any.
            );
    };

    class InterestRateIndex : public Index {};

    class IborIndex : public InterestRateIndex {
        public:
            %processor(IborIndex, IndexProcessor);
            IborIndex(
                const std::string& FamilyName,                                                                                      //!< index family name.
                const QuantLib::Period& Tenor,                                                                                      //!< index tenor (e.g. 2D for two days , 3W for three weeks, 6M for six months, 1Y for one year).
                const QuantLib::Natural FixingDays,                                                                                 //!< fixing days (e.g. 2).
                const QuantLib::Currency& Currency,                                                                                 //!< Index Currency.
                const QuantLib::Calendar& Calendar,                                                                                 //!< holiday calendar (e.g. TARGET).
                QuantLib::BusinessDayConvention BDayConvention,                                                                     //!< business day convention (e.g. Modified Following).
                bool EndOfMonth,                                                                                                    //!< TRUE if the index follow the 'end of month' convention.
                const QuantLib::DayCounter& DayCounter,                                                                             //!< DayCounter ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& FwdCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()     //!< forwarding YieldTermStructure object ID.
            );
    };

    class OvernightIndex : public IborIndex {
        public:
            %processor(OvernightIndex, IndexProcessor);
            OvernightIndex(
                const std::string& FamilyName,                                                                                      //!< index family name.
                const QuantLib::Natural FixingDays,                                                                                 //!< fixing days (e.g. 0).
                const QuantLib::Currency& Currency,                                                                                 //!< Index Currency.
                const QuantLib::Calendar& Calendar,                                                                                 //!< holiday calendar (e.g. TARGET).
                const QuantLib::DayCounter& DayCounter,                                                                             //!< DayCounter ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()   //!< forecasting YieldTermStructure object ID.
            );
    };

    class Euribor : public IborIndex {
        public:
            %processor(Euribor, IndexProcessor);
            %generate(c#, Euribor);
            Euribor(
                const std::string& Tenor,                                                                                           //!< index tenor: SW (1W), 2W, 3W, 1M, 2M, 3M, 4M, 5M, 6M, 7M, 8M, 9M, 10M, 11M, 12M (1Y).
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()   //!< forecasting YieldTermStructure object ID.
            );
    };

    class Euribor365 : public IborIndex {
        public:
            %processor(Euribor365, IndexProcessor);
            Euribor365(
                const std::string& Tenor,                                                                                           //!< index tenor: SW (1W), 2W, 3W, 1M, 2M, 3M, 4M, 5M, 6M, 7M, 8M, 9M, 10M, 11M, 12M (1Y).
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()   //!< forecasting YieldTermStructure object ID.
            );
    };

    class Eonia : public OvernightIndex {
        public:
            Eonia(
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()   //!< forecasting YieldTermStructure object ID.
            );
    };

    class Libor : public IborIndex {
        public:
            %processor(Libor, IndexProcessor);
            Libor(
                const QuantLib::Currency& Currency,                                                                                 //!< Libor index currency.
                const std::string& Tenor,                                                                                           //!< index tenor: SW (1W), 2W, 3W, 1M, 2M, 3M, 4M, 5M, 6M, 7M, 8M, 9M, 10M, 11M, 12M (1Y).
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()   //!< forecasting YieldTermStructure object ID.
            );
    };

    class Sonia : public OvernightIndex {
        public:
            Sonia(
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()   //!< forecasting YieldTermStructure object ID.
            );
    };    

    class SwapIndex : public InterestRateIndex {
        public:
            %processor(SwapIndex, IndexProcessor);
            SwapIndex(
                const std::string& FamilyName,                                                                                      //!< index name.
                const QuantLib::Period& Tenor,                                                                                      //!< index tenor (e.g. 2D for two days, 3W for three weeks, 6M for six months, 1Y for one year).
                QuantLib::Natural FixingDays,                                                                                       //!< swap rate fixing days (e.g. 2).
                QuantLib::Currency& Currency,                                                                                       //!< Index Currency.
                const QuantLib::Calendar& Calendar,                                                                                 //!< holiday calendar (e.g. TARGET).
                const QuantLib::Period& FixedLegTenor,                                                                              //!< tenor of the underlying swap's fixed leg (e.g. 6M, 1Y, 3M).
                QuantLib::BusinessDayConvention FixedLegBDC,                                                                        //!< business day convention of the underlying swap's fixed leg (e.g. ModifiedFollowing).
                const QuantLib::DayCounter& FixedLegDayCounter,                                                                     //!< day counter of the underlying swap's fixed leg (e.g. 30/360::BondBasis).
                const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                                            //!< swap's floating ibor index object ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()    //!< discounting YieldTermStructure object ID.
            );
    };

    class EuriborSwap : public SwapIndex {
        public:
            %processor(EuriborSwap, IndexProcessor);
            EuriborSwap(
                SwapIndex::FixingType FixingType/*=Default?*/,                                                                      //!< Swap index fixing type (e.g. IsdaFixA, IsdaFixB, IfrFix, IsdaFixAm, IsdaFixPm).
                const QuantLib::Period& Tenor,                                                                                      //!< index tenor (e.g. 1Y for one year).
                const QuantLib::Handle<QuantLib::YieldTermStructure>& FwdCurve=QuantLib::Handle<QuantLib::YieldTermStructure>(),    //!< forwarding YieldTermStructure object ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()    //!< discounting YieldTermStructure object ID.
            );
    };    

    class LiborSwap : public SwapIndex {
        public:
            %processor(LiborSwap, IndexProcessor);
            LiborSwap(
                const QuantLib::Currency& currency,                                                                                 //!< Libor swap index currency.
                SwapIndex::FixingType FixingType/*=Default?*/,                                                                      //!< Swap index fixing type (e.g. IsdaFixA, IsdaFixB, IfrFix, IsdaFixAm, IsdaFixPm).
                const QuantLib::Period& Tenor,                                                                                      //!< index tenor (e.g. 1Y for one year).
                const QuantLib::Handle<QuantLib::YieldTermStructure>& FwdCurve=QuantLib::Handle<QuantLib::YieldTermStructure>(),    //!< forwarding YieldTermStructure object ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()    //!< discounting YieldTermStructure object ID.
            );
    };

    class EuriborSwapIsdaFixA : public SwapIndex {
      public:
            EuriborSwapIsdaFixA(
                const QuantLib::Period& Tenor,                                                                                      //!< index tenor (e.g. 1Y for one year)
                const QuantLib::Handle<QuantLib::YieldTermStructure>& FwdCurve=QuantLib::Handle<QuantLib::YieldTermStructure>(),    //!< forwarding YieldTermStructure object ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& DiscCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()    //!< discounting YieldTermStructure object ID.
            );
    };

    class BMAIndex : public InterestRateIndex {
        public:
            BMAIndex(
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve=QuantLib::Handle<QuantLib::YieldTermStructure>()   //!< forecasting YieldTermStructure object ID.
            );
    };

    class ProxyIbor : public IborIndex {
        public:
            %processor(ProxyIbor, IndexProcessor);
            ProxyIbor(
                const std::string& FamilyName,                                                                                      //!< index family name.
                const QuantLib::Period& Tenor,                                                                                      //!< index tenor (e.g. 2D for two days , 3W for three weeks, 6M for six months, 1Y for one year).
                QuantLib::Natural FixingDays,                                                                                       //!< fixing days (e.g. 2).
                const QuantLib::Currency& Currency,                                                                                 //!< Index Currency.
                const QuantLib::Calendar& Calendar,                                                                                 //!< holiday calendar (e.g. TARGET).
                QuantLib::BusinessDayConvention BDayConvention,                                                                     //!< business day convention (e.g. Modified Following).
                bool EndOfMonth,                                                                                                    //!< TRUE if the index follow the 'end of month' convention.
                const QuantLib::DayCounter& DayCounter,                                                                             //!< DayCounter ID.
                const QuantLib::Handle<QuantLib::Quote>& Gearing,                                                                   //!< gearing.
                const boost::shared_ptr<QuantLib::IborIndex>& IborIndex,                                                            //!< floating rate index.
                const QuantLib::Handle<QuantLib::Quote>& Spread                                                                     //!< floating rate spread.
            );
    };    
}
