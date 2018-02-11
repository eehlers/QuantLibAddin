
%group(marketmodels);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class MarketModel;
    class PiecewiseConstantCorrelation;
    class EvolutionDescription;
    class CTSMMCapletCalibration;
    class YieldTermStructure;
    //class MarketModelFactory;
    class FlatVolFactory;
    class Matrix;
    class CurveState;

    template <class T>
    class Handle;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_correlation.hpp>
#include <qlo/objects/obj_evolutiondescription.hpp>
#include <qlo/objects/obj_ctsmmcapletcalibration.hpp>
#include <qlo/objects/obj_curvestate.hpp>

#include <ql/models/marketmodels/models/fwdperiodadapter.hpp>
#include <ql/models/marketmodels/models/fwdtocotswapadapter.hpp>
#include <ql/models/marketmodels/models/pseudorootfacade.hpp>
#include <ql/models/marketmodels/models/cotswaptofwdadapter.hpp>
#include <ql/models/marketmodels/models/flatvol.hpp>
#include <ql/legacy/libormarketmodels/lmextlinexpvolmodel.hpp>
#include <ql/models/marketmodels/models/abcdvol.hpp>
#include <ql/models/marketmodels/marketmodeldifferences.hpp>
%}

namespace QuantLib {

    class MarketModel {
        public:
            //! Initial rates for the MarketModel object.
            virtual const std::vector<Rate>& initialRates() const;

            //! Rates' displacemets for the MarketModel object.
            virtual const std::vector<Spread>& displacements() const;

            //! Number of rates for the MarketModel object.
            virtual Size numberOfRates() const;

            //! Number of factors for the MarketModel object.
            virtual Size numberOfFactors() const;

            //! Number of steps for the MarketModel object.
            virtual Size numberOfSteps() const;

            //! Returns the pseudo root for the i-th step.
            virtual const Matrix& pseudoRoot(Size i) const;

            //! Returns the covariance matrix for the i-th step.
            virtual const Matrix& covariance(Size i) const;

            //! Returns the covariance matrix from start up to the i-th step.
            virtual const Matrix& totalCovariance(Size endIndex) const;

            //! Returns the time dependent vol for rate i.
            std::vector<Volatility> timeDependentVolatility(Size i) const;
    };

    class FlatVol : public MarketModel {
        public:
            FlatVol(
                const std::vector<Volatility>& Volatilities,                            //!< Volatilities.
                const boost::shared_ptr<PiecewiseConstantCorrelation>& Correlations,    //!< PiecewiseConstantCorrelation object ID.
                const EvolutionDescription& EvolutionDescription,                       //!< EvolutionDescription object.
                Size Factors,                                                           //!< Number of factors to be retained in the simulation.
                const std::vector<Rate>& InitialRates,                                  //!< Initial rates.
                const std::vector<Spread>& Displacements                                //!< Displacements.
            );
    };

    class AbcdVol : public MarketModel {
        public:
            AbcdVol(
                Real A,                                                                 //!< The a coefficient in the abcd vol parametrization.
                Real B,                                                                 //!< The b coefficient in the abcd vol parametrization.
                Real C,                                                                 //!< The c coefficient in the abcd vol parametrization.
                Real D,                                                                 //!< The d coefficient in the abcd vol parametrization.
                const std::vector<Real>& Ks,                                            //!< K_i adjustment factors in the abcd vol parametrization.
                const boost::shared_ptr<PiecewiseConstantCorrelation>& Correlations,    //!< PiecewiseConstantCorrelation object ID.
                const EvolutionDescription& EvolutionDescription,                       //!< EvolutionDescription object.
                const Size Factors,                                                     //!< Number of factors to be retained in the simulation.
                const std::vector<Rate>& InitialRates,                                  //!< Initial rates.
                const std::vector<Spread>& Displacements                                //!< Displacements.
            );
    };

    class PseudoRootFacade : public MarketModel {
        public:
            PseudoRootFacade(
                const boost::shared_ptr<CTSMMCapletCalibration>& Calibrator             //!< CTSMMCapletCalibration ID.
            );
    };

    class CotSwapToFwdAdapter : public MarketModel {
        public:
            CotSwapToFwdAdapter(
                const boost::shared_ptr<MarketModel>& CoterminalModel                   //!< CoTerminal Swap Market Model ID.
            );
    };

    class FwdPeriodAdapter : public MarketModel {
        public:
            FwdPeriodAdapter(
                const boost::shared_ptr<MarketModel>& LargeModel,                       //!< Large MarketModel ID.
                Size Period,                                                            //!< Target period (e.g. 2 if going from semiannual LMM to annual LMM).
                Size Offset,                                                            //!< Rate index offset, in order to pin down swaption coterminal to the last rate time.
                const std::vector<Spread>& Displacements                                //!< Displacements.
           );
    };

    class FwdToCotSwapAdapter : public MarketModel {
        public:
            FwdToCotSwapAdapter(
                const boost::shared_ptr<MarketModel>& ForwardModel                      //!< Forward Rate Market Model ID.
            );
    };

    //class MarketModelFactory{};

    class FlatVolFactory /*: public MarketModelFactory, public Observer*/ {
      public:
        FlatVolFactory(
            Real longTermCorrelation,
            Real beta,
            const std::vector<Time>& times,
            const std::vector<Volatility>& vols,
            const Handle<YieldTermStructure>& yieldCurve,
            Spread displacement
        );
    };

    //! Compute the differences between all implied forwards volatilities.
    %noimpl(rateVolDifferences);
    std::vector<QuantLib::Real> rateVolDifferences(
        const QuantLib::MarketModel& MarketModel1,                                      //!< First Market Model.
        const QuantLib::MarketModel& MarketModel2                                       //!< Second Market Model.
    );

    //! Compute the differences between volatilities at each evolution step.
    %noimpl(rateInstVolDifferences);
    std::vector<QuantLib::Real> rateInstVolDifferences(
        const QuantLib::MarketModel& MarketModel1,                                      //!< First Market Model.
        const QuantLib::MarketModel& MarketModel2,                                      //!< Second Market Model.
        QuantLib::Size Index                                                            //!< Forward Rate index.
    );
}

namespace QuantLibAddin {

    //! Returns the jacobian between coterminal swap rates and forward rates.
    QuantLib::Matrix coterminalSwapForwardJacobian(
        const QuantLib::CurveState& CurveState                                          //!< CurveState object ID.
    );

    //! Returns the Z matrix to switch base from forward to coterminal swap rates.
    QuantLib::Matrix coterminalSwapZedMatrix(
        const QuantLib::CurveState& CurveState,                                         //!< CurveState object ID.
        const QuantLib::Spread Displacement                                             //!< Displacement.
    );

    //! Returns the jacobian between coinitial swap rates and forward rates.
    QuantLib::Matrix coinitialSwapForwardJacobian(
        const QuantLib::CurveState& CurveState                                          //!< CurveState object ID.
    );

    //! Returns the Z matrix to switch base from forward to coinitial swap rates.
    QuantLib::Matrix coinitialSwapZedMatrix(
        const QuantLib::CurveState& CurveState,                                         //!< CurveState object ID.
        const QuantLib::Spread Displacement                                             //!< Displacement.
    );

    //! Returns the jacobian between constant maturity swap rates and forward rates.
    QuantLib::Matrix cmSwapForwardJacobian(
        const QuantLib::CurveState& CurveState,                                         //!< CurveState object ID.
        const QuantLib::Size SpanningForwards                                           //!< Number of forwards underlying the CMS.
    );

    //! Returns the Z matrix to switch base from forward to constant maturity swap rates.
    QuantLib::Matrix cmSwapZedMatrix(
        const QuantLib::CurveState& CurveState,                                         //!< CurveState object ID.
        const QuantLib::Size SpanningForwards,                                          //!< Number of forwards underlying the CMS.
        const QuantLib::Spread Displacement                                             //!< Displacement.
    );

    //! Returns annuity of arbitrary swap-rate.
    QuantLib::Real annuity(
        const QuantLib::CurveState& CurveState,                                         //!< CurveState object ID.
        QuantLib::Size StartIndex,                                                      //!< Start index.
        QuantLib::Size EndIndex,                                                        //!< End index.
        QuantLib::Size NumeraireIndex                                                   //!< Numeraire index.
    );

    //! Returns derivative of swap-rate to underlying forward rate.
    QuantLib::Real swapDerivative(
        const QuantLib::CurveState& CurveState,                                         //!< CurveState object ID.
        QuantLib::Size StartIndex,                                                      //!< Start index.
        QuantLib::Size EndIndex,                                                        //!< End index.
        QuantLib::Size FwdRateIndex                                                     //!< Forward rate index.
    );
}

