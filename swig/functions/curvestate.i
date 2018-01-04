
%group(curvestate);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class CurveState;
}
%}

%insert(obj_cpp) %{
#include <ql/models/marketmodels/curvestates/cmswapcurvestate.hpp>
#include <ql/models/marketmodels/curvestates/coterminalswapcurvestate.hpp>
#include <ql/models/marketmodels/curvestates/lmmcurvestate.hpp>
%}

namespace QuantLib {

    class CurveState {
        public:
            //! Return the rate times of the CurveState object.
            const std::vector<Time>& rateTimes();

            //! Return the rate taus of the CurveState object.
            const std::vector<Time>& rateTaus();

            //! Returns the current forward rates of the CurveState object.
            const std::vector<Rate>& forwardRates();

            //! Returns the current swap rates of the CurveState object.
            const std::vector<Rate>& coterminalSwapRates();

            //! Returns the current swap rates of the CurveState object.
            const std::vector<Rate>& cmSwapRates(
                Size spanningForwards
            );
    };

    class CMSwapCurveState : public CurveState {
        public:
            CMSwapCurveState(
                const std::vector<Time>& RateTimes,         //!< Rate fixing times.
                Size SpanningForwards                       //!< Number of forwards underlying the CMS.
            );

            //! Set the CurveState object on given vector of coterminal swaps.
            void setOnCMSwapRates(
                const std::vector<Rate>& CMSwapRates        //!< Coterminal swap rates.
            );
    };

    class CoterminalSwapCurveState : public CurveState {
        public:
            CoterminalSwapCurveState(
                const std::vector<Time>& RateTimes          //!< Rate fixing times.
            );

            //! Set the CurveState object on given vector of coterminal swaps.
            void setOnCoterminalSwapRates(
                const std::vector<Rate>& CoterminalSwaps    //!< Coterminal swap rates.
            );
    };

    class LMMCurveState : public CurveState {
        public:
            LMMCurveState(
                const std::vector<Time>& RateTimes          //!< Rate fixing times.
            );

            //! Set the CurveState object on given vector of forward rates.
            void setOnForwardRates(
                const std::vector<Rate>& Rates              //!< Forward rates.
            );

            //! Set the CurveState object on given vector of discount ratios.
            void setOnDiscountRatios(
                const std::vector<DiscountFactor>& DiscountRatios   //!< Discount ratios.
            );
    };
}

namespace QuantLibAddin {

    //! Returns the forward rates implied from discount bond ratios.
    %noimpl(forwardsFromDiscountRatios);
    std::vector<QuantLib::Rate> forwardsFromDiscountRatios(
        const QuantLib::Size FirstValidIndex,                         //!< Marks the first non expired discount bond.
        const std::vector<QuantLib::DiscountFactor>& DiscountRatios,  //!< Vector of discount bond ratios.
        const std::vector<QuantLib::Time>& Taus                       //!< Rate time intervals.
    );

    //! Returns the coterminal swap rates implied from discount bond ratios.
    %noimpl(coterminalSwapRatesFromDiscountRatios);
    std::vector<QuantLib::Rate> coterminalSwapRatesFromDiscountRatios(
        const QuantLib::Size FirstValidIndex,                         //!< Marks the first non expired discount bond.
        const std::vector<QuantLib::DiscountFactor>& DiscountRatios,  //!< Vector of discount bond ratios.
        const std::vector<QuantLib::Time>& Taus                       //!< Rate time intervals.
    );

    //! Returns the coterminal swap annuities implied from discount bond ratios.
    %noimpl(coterminalSwapAnnuitiesFromDiscountRatios);
    std::vector<QuantLib::Real> coterminalSwapAnnuitiesFromDiscountRatios(
        const QuantLib::Size FirstValidIndex,                         //!< Marks the first non expired discount bond.
        const std::vector<QuantLib::DiscountFactor>& DiscountRatios,  //!< Vector of discount bond ratios.
        const std::vector<QuantLib::Time>& Taus                       //!< Rate time intervals.
    );

    //! Returns constant maturity swap rates from discount ratios.
    %noimpl(constantMaturitySwapRatesFromDiscountRatios);
    std::vector<QuantLib::Rate> constantMaturitySwapRatesFromDiscountRatios(
        const QuantLib::Size SpanningForwards,                        //!< Number of forward rates spanned by the constant maturity swap.
        const QuantLib::Size FirstValidIndex,                         //!< Marks the first non expired discount bond.
        const std::vector<QuantLib::DiscountFactor>& DiscountRatios,  //!< Vector of discount bond ratios.
        const std::vector<QuantLib::Time>& Taus                       //!< Rate time intervals.
    );

    //! Returns constant maturity swap annuities from discount ratios.
    %noimpl(constantMaturitySwapAnnuitiesFromDiscountRatios);
    std::vector<QuantLib::Real> constantMaturitySwapAnnuitiesFromDiscountRatios(
        const QuantLib::Size SpanningForwards,                        //!< Number of forward rates spanned by the constant maturity swap.
        const QuantLib::Size FirstValidIndex,                         //!< Marks the first non expired discount bond.
        const std::vector<QuantLib::DiscountFactor>& DiscountRatios,  //!< Vector of discount bond ratios.
        const std::vector<QuantLib::Time>& Taus                       //!< Rate time intervals.
    );
}

