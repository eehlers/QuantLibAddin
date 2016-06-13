
%group(indexes);
%groupCaption(Indexes);
%override;

%insert(indexes_addin_cpp) %{
#include <qlo/obj_termstructures.hpp>
%}

// For most of the QuantLib index classes, we have handwritten code in the
// QuantLibAddin layer to provide custom behavior.  In the QuantLibAddin
// namespace we define all of the constructors and memberfunctions of the
// QuantLibAddin wrapper classes.  See also the QuantLib namespace below.

namespace QuantLibAddin {

    class Index {
        public:
            //! Adds fixings for the given Index object.
            void addFixings(
                const std::vector<QuantLib::Date>& dates,   //!< fixing dates.
                const std::vector<QuantLib::Real>& values,  //!< fixing values.
                bool forceOverwrite                         //!< Set to TRUE to force overwriting of existing fixings, if any.
            );
    };

    class InterestRateIndex : public Index {};

    class IborIndex : public InterestRateIndex {};

    class SwapIndex : public InterestRateIndex {
        public:
            SwapIndex(
                const std::string& familyName,                              //!< index name.
                const QuantLib::Period& p,                                  //!< index tenor (e.g. 2D for two days, 3W for three weeks, 6M for six months, 1Y for one year).
                QuantLib::Natural fixingDays,                               //!< swap rate fixing days (e.g. 2).
                QuantLib::Currency& crr,                                    //!< Index Currency.
                const QuantLib::Calendar& calendar,                         //!< holiday calendar (e.g. TARGET).
                const QuantLib::Period& fixedLegTenor,                      //!< tenor of the underlying swap's fixed leg (e.g. 6M, 1Y, 3M).
                QuantLib::BusinessDayConvention fixedLegBDC,                //!< business day convention of the underlying swap's fixed leg (e.g. ModifiedFollowing).
                const QuantLib::DayCounter& fixedLegDayCounter,             //!< day counter of the underlying swap's fixed leg (e.g. 30/360::BondBasis).
                const boost::shared_ptr<QuantLib::IborIndex>& index,        //!< swap's floating ibor index object ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& disc  //!< discounting YieldTermStructure object ID.
            );
    };

    class LiborSwap : public SwapIndex {
        public:
            LiborSwap(
                const QuantLib::Currency& currency,                         //!< Libor swap index currency.
                SwapIndex::FixingType fixingType,                           //!< Swap index fixing type (e.g. IsdaFixA, IsdaFixB, IfrFix, IsdaFixAm, IsdaFixPm).
                const QuantLib::Period& p,                                  //!< index tenor (e.g. 1Y for one year).
                const QuantLib::Handle<QuantLib::YieldTermStructure>& f,    //!< forwarding YieldTermStructure object ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& d     //!< discounting YieldTermStructure object ID.
            );
    };

    class OvernightIndex : public IborIndex {};

    class Euribor : public IborIndex {
        public:
            %generate(c#, Euribor);
            Euribor(
                const QuantLib::Period& tenor,                              //!< index tenor: SW (1W), 2W, 3W, 1M, 2M, 3M, 4M, 5M, 6M, 7M, 8M, 9M, 10M, 11M, 12M (1Y).
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve    //!< forecasting YieldTermStructure object ID.
            );
    };

    class Eonia : public OvernightIndex {
        public:
            Eonia(
                const QuantLib::Handle<QuantLib::YieldTermStructure>& YieldCurve    //!< forecasting YieldTermStructure object ID.
            );
    };

    class EuriborSwapIsdaFixA : public SwapIndex {
      public:
            EuriborSwapIsdaFixA(
                const QuantLib::Period& tenor,                                      //!< index tenor (e.g. 1Y for one year)
                const QuantLib::Handle<QuantLib::YieldTermStructure>& forwarding,   //!< forwarding YieldTermStructure object ID.
                const QuantLib::Handle<QuantLib::YieldTermStructure>& discounting   //!< discounting YieldTermStructure object ID.
            );
    };
    
    class Libor : public IborIndex {
      public:
        Libor(
            const QuantLib::Currency& currency,                                     //!< Libor index currency.
            const std::string& p,                                                   //!< index tenor: ON (1D), SW (1W), 2W, 3W, 1M, 2M, 3M, 4M, 5M, 6M, 7M, 8M, 9M, 10M, 11M, 12M (1Y).
            const QuantLib::Handle<QuantLib::YieldTermStructure>& hYTS);            //!< forecasting YieldTermStructure object ID.
    };

    class Sonia : public OvernightIndex {
      public:
        Sonia(
            const QuantLib::Handle<QuantLib::YieldTermStructure>& hYTS              //!< forecasting YieldTermStructure object ID.
        );
    };    
}

// In the QuantLib namespace we define member functions which are invoked
// directly on the underlying QuantLib objects.

namespace QuantLib {

    class Index {
        public:
            //! Returns the fixing for the given Index object. The fixing is retrieved from the time series if available, otherways it is forecasted.
            double fixing(
                const Date& fixingDate,     //!< fixing date(s).
                bool forecastTodaysFixing   //!< If set to TRUE it forces the forecasting of today's fixing even if the actual fixing is already available in the time series.
            );
            //! Returns the calendar (e.g. TARGET) for the given Index object.
            Calendar fixingCalendar();
    };

    class InterestRateIndex : public Index {
        public:
            //! Returns the fixing days (e.g. 2) for the given InterestRateIndex object.
            Natural fixingDays();
            %generate(c#, dayCounter);
            //! Returns the DayCounter (e.g. Actual/360) for the given InterestRateIndex object.
            const DayCounter& dayCounter();
            //! Returns the value date for the given fixing date for the given InterestRateIndex object.
            Date valueDate(const Date& fixingDate);
            //! Returns the tenor (i.e. length, e.g. 6M, 10Y) for the given InterestRateIndex object.
            Period tenor();
    };

    class IborIndex : public InterestRateIndex {
        public:
            //! Returns TRUE if the given IborIndex object follows the 'end of month' convention.
            bool endOfMonth();
            // For purposes of backward compatibility we use the %alias directive to export this function twice,
            // once under its old name (qlIborIndexBusinessDayConv) and once under its new name (qlIborIndexBusinessDayConvention)
            %alias(businessDayConvention, IborIndexBusinessDayConv);
            //!< Returns the business day convention (e.g. Modified Following) for the given IborIndex object.
            BusinessDayConvention businessDayConvention();
    };
}

