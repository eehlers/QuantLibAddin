
// BEGIN buffer b_lib_grp_cpp


#include <qlo/objects/obj_correlation.hpp>


#include <ql/legacy/libormarketmodels/lmlinexpcorrmodel.hpp>
#include <ql/models/marketmodels/correlations/cotswapfromfwdcorrelation.hpp>
#include <ql/models/marketmodels/correlations/timehomogeneousforwardcorrelation.hpp>
#include <ql/models/marketmodels/correlations/expcorrelations.hpp>
#include <ql/models/marketmodels/historicalforwardratesanalysis.hpp>
#include <ql/models/marketmodels/historicalratesanalysis.hpp>
#include <qlo/enumerations/factories/historicalforwardratesanalysisfactory.hpp>

QuantLibAddin::HistoricalForwardRatesAnalysis::HistoricalForwardRatesAnalysis(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            boost::shared_ptr< QuantLib::SequenceStatistics > const &SequenceStats,
            QuantLib::Date const &StartDate,
            QuantLib::Date const &EndDate,
            QuantLib::Period const &Step,
            boost::shared_ptr< QuantLib::IborIndex > const &IborIndex,
            QuantLib::Period const &InitialGap,
            QuantLib::Period const &Horizon,
            std::vector< boost::shared_ptr< QuantLib::IborIndex > > const &IborIndexes,
            std::vector< boost::shared_ptr< QuantLib::SwapIndex > > const &SwapIndexes,
            QuantLib::DayCounter const &DayCounter,
            std::string const &TraitsID,
            std::string const &InterpolatorID,
            QuantLib::Real BootstrapAccuracy,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::HistoricalForwardRatesAnalysis>(properties, permanent) {

    libraryObject_ = reposit::Create<boost::shared_ptr<
        QuantLib::HistoricalForwardRatesAnalysis> >()(
            TraitsID,
            InterpolatorID,
            SequenceStats,
            StartDate,
            EndDate,
            Step,
            IborIndex,
            InitialGap,
            Horizon,
            IborIndexes,
            SwapIndexes,
            DayCounter,
            BootstrapAccuracy);
}
QuantLibAddin::TimeHomogeneousForwardCorrelation::TimeHomogeneousForwardCorrelation(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Matrix const &FwdCorrMatrix,
            std::vector< QuantLib::Time > const &RateTimes,
            // END   typemap rp_tm_default
    bool permanent)
: PiecewiseConstantCorrelation(properties, permanent) {
    QL_REQUIRE(!RateTimes.empty(), "rate times vector is empty!");
    libraryObject_ = boost::shared_ptr<QuantLib::PiecewiseConstantCorrelation>(new QuantLib::TimeHomogeneousForwardCorrelation(
                // BEGIN typemap rp_tm_default
                FwdCorrMatrix,
                RateTimes
                // END   typemap rp_tm_default
    ));
}

// END buffer b_lib_grp_cpp

