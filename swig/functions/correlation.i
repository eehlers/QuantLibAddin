
%group(correlation);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class LmCorrelationModel;
    class PiecewiseConstantCorrelation;
    class Matrix;
    class CurveState;
    class EvolutionDescription;
    class Date;
    class Period;
    class InterestRateIndex;
    class IborIndex;
    class SwapIndex;
    class DayCounter;
    class HistoricalForwardRatesAnalysis;
    class HistoricalRatesAnalysis;

    class GeneralStatistics;

    template<class Stat>
    class GenericGaussianStatistics;

    typedef GenericGaussianStatistics<GeneralStatistics> GaussianStatistics;

    template <class S>
    class GenericRiskStatistics;

    typedef GenericRiskStatistics<GaussianStatistics> RiskStatistics;

    typedef RiskStatistics Statistics;

    template <class StatisticsType>
    class GenericSequenceStatistics;

    typedef GenericSequenceStatistics<Statistics> SequenceStatistics;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_sequencestatistics.hpp>
#include <qlo/objects/obj_curvestate.hpp>
#include <qlo/objects/obj_indexes.hpp>

#include <ql/legacy/libormarketmodels/lmlinexpcorrmodel.hpp>
#include <ql/models/marketmodels/correlations/cotswapfromfwdcorrelation.hpp>
#include <ql/models/marketmodels/correlations/timehomogeneousforwardcorrelation.hpp>
#include <ql/models/marketmodels/correlations/expcorrelations.hpp>
#include <ql/models/marketmodels/historicalforwardratesanalysis.hpp>
#include <ql/models/marketmodels/historicalratesanalysis.hpp>
#include <qlo/enumerations/factories/historicalforwardratesanalysisfactory.hpp>
%}

namespace QuantLib {

    class LmCorrelationModel{};

    class LmLinearExponentialCorrelationModel : public LmCorrelationModel {
        public:
            %rename(MarketModelLmLinearExponentialCorrelationModel) LmLinearExponentialCorrelationModel;
            LmLinearExponentialCorrelationModel(
                Size Size,                      //!< Size.
                Real Rho,                       //!< Rho.
                Real Beta,                      //!< Beta.
                Size Factors = Null<Size>()     //!< Factors.
            );
    };

    class HistoricalForwardRatesAnalysis {
        public:
            %noimpl(HistoricalForwardRatesAnalysis);
            HistoricalForwardRatesAnalysis(
                const boost::shared_ptr<SequenceStatistics>& SequenceStats,                     //!< Sequence Statistics object ID.
                const Date& StartDate,                                                          //!< Beginning of the time series.
                const Date& EndDate,                                                            //!< End of the time series.
                const Period& Step,                                                             //!< Time series' time step.
                const boost::shared_ptr<IborIndex>& IborIndex,                                  //!< Floating rate index.
                const Period& InitialGap,                                                       //!< InitialGap.
                const Period& Horizon,                                                          //!< Bootstrap horizon.
                const std::vector<boost::shared_ptr<IborIndex> >& IborIndexes,                  //!< Ibor indexes.
                const std::vector<boost::shared_ptr<SwapIndex> >& SwapIndexes,                  //!< Swap indexes.
                const DayCounter& DayCounter=QuantLib::Actual365Fixed(),                        //!< Yield curve DayCounter ID.
                const std::string& TraitsID="Discount",                                         //!< Discount, ZeroRate, or ForwardRate.
                const std::string& InterpolatorID="CubicSpline",                                //!< Linear, LogLinear, or CubicSpline.
                Real BootstrapAccuracy=1.0e-12                                                  //!< Boostrap accuracy.
            );

            //! Returns vector of historic dates for which some fixing is missing.
            const std::vector<Date>& skippedDates() const;

            //! Returns vector of error messages for historic dates with missing fixing.
            const std::vector<std::string>& skippedDatesErrorMessage() const;

            //! Returns vector of dates for which forward rates could not be calculated.
            const std::vector<Date>& failedDates() const;

            //! Returns vector of error messages for dates on which forward rates could not be calculated.
            const std::vector<std::string>& failedDatesErrorMessage() const;

            //! Returns the forward rates time grid.
            const std::vector<Period>& fixingPeriods() const;
    };

    class HistoricalRatesAnalysis {
        public:
            HistoricalRatesAnalysis(
                const boost::shared_ptr<SequenceStatistics>& SequenceStats,                     //!< Sequence Statistics object ID.
                const Date& StartDate,                                                          //!< Beginning of the time series.
                const Date& EndDate,                                                            //!< End of the time series.
                const Period& Step,                                                             //!< Time series' time step.
                const std::vector<boost::shared_ptr<InterestRateIndex> >& InterestRateIndexes   //!< Interest rate indexes object IDs.
            );

            //! Returns vector of historic dates for which some fixing is missing.
            const std::vector<Date>& skippedDates() const;

            //! Returns vector of error messages for historic dates with missing fixing.
            const std::vector<std::string>& skippedDatesErrorMessage() const;
    };

    class PiecewiseConstantCorrelation{
        public:

            //! Returns the pseudo-root of the equivalent covariance swap rates matrix.
            virtual const Matrix& correlation(
                Size TimeIndex                                                                  //!< Time index.
            ) const;

            //! Piecewise Constant Correlation Times.
            virtual const std::vector<Time>& times();

            //! Piecewise Constant Correlation Number of Rates.
            virtual Size numberOfRates();
    };

    class TimeHomogeneousForwardCorrelation : public PiecewiseConstantCorrelation {
        public:
            %noimpl(TimeHomogeneousForwardCorrelation);
            TimeHomogeneousForwardCorrelation(
                const Matrix& FwdCorrMatrix,                                                    //!< Forward correlation matrix.
                const std::vector<Time>& RateTimes                                              //!< Rate times.
            );
    };

    class ExponentialForwardCorrelation : public PiecewiseConstantCorrelation {
        public:
            ExponentialForwardCorrelation(
                const std::vector<Time>& RateTimes,                                             //!< Rate times.
                Real LongTermCorr,                                                              //!< Long term correlation.
                Real Beta,                                                                      //!< Exponential decay factor.
                Real Gamma,                                                                     //!< Exponent for time to go.
                const std::vector<Time>& Times                                                  //!< Times.
            );
    };

    class CotSwapFromFwdCorrelation : public PiecewiseConstantCorrelation {
        public:
            CotSwapFromFwdCorrelation(
                const boost::shared_ptr<PiecewiseConstantCorrelation>& FwdCorr,                 //!< Forward rates correlation (i.e. PiecewiseConstantCorrelation object ID).
                const CurveState& CurveState,                                                   //!< CurveState.
                Spread Displacement=0.0                                                         //!< Displacement.
            );
    };
}

