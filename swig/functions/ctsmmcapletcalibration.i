
%group(ctsmmcapletcalibration);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class CTSMMCapletCalibration;
    class PiecewiseConstantCorrelation;
    class EvolutionDescription;
    class PiecewiseConstantVariance;
    class CurveState;
    class AlphaForm;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_alphaform.hpp>
#include <qlo/objects/obj_correlation.hpp>
#include <qlo/objects/obj_curvestate.hpp>
#include <qlo/objects/obj_evolutiondescription.hpp>
#include <qlo/objects/obj_volatility.hpp>

#include <ql/models/marketmodels/models/alphaform.hpp>
#include <ql/models/marketmodels/models/capletcoterminalswaptioncalibration.hpp>
#include <ql/models/marketmodels/models/capletcoterminalalphacalibration.hpp>
#include <ql/models/marketmodels/models/capletcoterminalmaxhomogeneity.hpp>
%}

namespace QuantLib {

    class CTSMMCapletCalibration{
        public:
            //! Returns vector of historic dates for which some fixing is missing.
            bool calibrate(
                Natural NumberOfFactors,                                                                            //!< Number of factors.
                Natural MaxIter,                                                                                    //!< Maximum number of iterations.
                Real Tol=0.0001,                                                                                    //!< Caplet vol tolerance.
                Natural InnerMaxIter=100,                                                                           //!< InnerMaxIter.
                Real InnerTol=1e-8                                                                                  //!< Caplet vol tolerance.
            );

            //! Failures.
            Natural failures() const;

            //! DeformationSize.
            Real deformationSize() const;

            %rename(MarketCapletVols) mktCapletVols;
            //! Market caplet volalitilies.
            const std::vector<Volatility>& mktCapletVols() const;

            %rename(ModelCapletVols) mdlCapletVols;
            //! Model caplet volalitilies.
            const std::vector<Volatility>& mdlCapletVols() const;

            //! CapletRmsError.
            Real capletRmsError() const;

            //! CapletMaxError.
            Real capletMaxError() const;

            %rename(MarketSwaptionVols) mktSwaptionVols;
            //! Market swaption volalitilies.
            const std::vector<Volatility>& mktSwaptionVols() const;

            %rename(ModelSwaptionVols) mdlSwaptionVols;
            //! Model swaption volalitilies.
            const std::vector<Volatility>& mdlSwaptionVols() const;

            //! SwaptionRmsError.
            Real swaptionRmsError() const;

            //! SwaptionMaxError.
            Real swaptionMaxError() const;

            //! swapPseudoRoot.
            const Matrix& swapPseudoRoot(Size i) const;

            //! TimeDependentCalibratedSwaptionVols.
            const std::vector<Volatility>& timeDependentCalibratedSwaptionVols(Size i) const;

            //! TimeDependentUnCalibratedSwaptionVols.
            const std::vector<Volatility>& timeDependentUnCalibratedSwaptionVols(Size i) const;
    };

    class CTSMMCapletOriginalCalibration : public CTSMMCapletCalibration {
        public:
            CTSMMCapletOriginalCalibration(
                const EvolutionDescription& EvolutionDescriptionID,                                                 //!< Evolution Description.
                const boost::shared_ptr<PiecewiseConstantCorrelation>& Correlations,                                //!< PiecewiseConstantCorrelation object ID.
                const std::vector<boost::shared_ptr<PiecewiseConstantVariance> >& SwapPiecewiseConstantVariances,   //!< PiecewiseConstantVariance IDs.
                const std::vector<Volatility>& CapletVols,                                                          //!< Caplet volatilities.
                const boost::shared_ptr<CurveState>& CurveState,                                                    //!< CurveState object ID.
                Spread Displacement/*=0.0*/,                                                                        //!< Displacement.
                const std::vector<Real>& Alphas,                                                                    //!< Alphas.
                bool LowestRoot/*=true*/,                                                                           //!< TRUE for lowest root, FALSE for the root nearest to 1.0.
                bool UseFullApprox                                                                                  //!< TRUE for using Full Approximation.
            );
    };

    class CTSMMCapletAlphaFormCalibration : public CTSMMCapletCalibration {
        public:
            CTSMMCapletAlphaFormCalibration(
                const EvolutionDescription& EvolutionDescriptionID,                                                 //!< Evolution Description.
                const boost::shared_ptr<PiecewiseConstantCorrelation>& Correlations,                                //!< PiecewiseConstantCorrelation object ID.
                const std::vector<boost::shared_ptr<PiecewiseConstantVariance> >& SwapPiecewiseConstantVariances,   //!< PiecewiseConstantVariance IDs.
                const std::vector<Volatility>& CapletVols,                                                          //!< Caplet volatilities.
                const boost::shared_ptr<CurveState>& CurveState,                                                    //!< CurveState object ID.
                Spread Displacement/*=0.0*/,                                                                        //!< Displacement.
                const std::vector<Real>& AlphaInitial,                                                              //!< AlphaInitial.
                const std::vector<Real>& AlphaMax/*='1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0,1.0'*/,                    //!< AlphaMax.
                const std::vector<Real>& AlphaMin/*='-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0'*/,          //!< AlphaMin.
                bool MaximizeHomogeneity=true,                                                                      //!< TRUE for maximizing homogeneity.
                // FIXME it's supposed to be without the const& but the necessary typemaps aren't there
                //boost::shared_ptr<AlphaForm> AlphaFormID=boost::shared_ptr<AlphaForm>()                             //!< Alpha form ID..
                const boost::shared_ptr<AlphaForm> &AlphaFormID=boost::shared_ptr<AlphaForm>()                      //!< Alpha form ID..
            );

            //! Alpha.
            const std::vector<Real>& alpha() const;
    };

    class CTSMMCapletMaxHomogeneityCalibration : public CTSMMCapletCalibration {
        public:
            CTSMMCapletMaxHomogeneityCalibration(
                const EvolutionDescription& EvolutionDescriptionID,                                                 //!< Evolution Description.
                const boost::shared_ptr<PiecewiseConstantCorrelation>& Correlations,                                //!< PiecewiseConstantCorrelation object ID.
                const std::vector<boost::shared_ptr<PiecewiseConstantVariance> >& SwapPiecewiseConstantVariances,   //!< PiecewiseConstantVariance IDs.
                const std::vector<Volatility>& CapletVols,                                                          //!< Caplet volatilities.
                const boost::shared_ptr<CurveState>& CurveState,                                                    //!< CurveState object ID.
                Spread Displacement=0.0,                                                                            //!< Displacement.
                Real Caplet0Swaption1Priority = 1.0                                                                 //!< Caplet0Swaption1Priority.
            );
    };
}

