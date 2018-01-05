
%group(driftcalculators);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class LMMDriftCalculator;
    class LMMNormalDriftCalculator;
    class CMSMMDriftCalculator;
    class SMMDriftCalculator;
    class Matrix;
    class LMMCurveState;
    class CMSwapCurveState;
    class CoterminalSwapCurveState;
}
%}

%insert(obj_cpp) %{
#include <ql/models/marketmodels/driftcomputation/lmmdriftcalculator.hpp>
#include <ql/models/marketmodels/driftcomputation/cmsmmdriftcalculator.hpp>
#include <ql/models/marketmodels/driftcomputation/lmmnormaldriftcalculator.hpp>
#include <ql/models/marketmodels/driftcomputation/smmdriftcalculator.hpp>

#include <qlo/objects/obj_curvestate.hpp>
#include <ql/models/marketmodels/curvestates/cmswapcurvestate.hpp>
#include <ql/models/marketmodels/curvestates/coterminalswapcurvestate.hpp>
#include <ql/models/marketmodels/curvestates/lmmcurvestate.hpp>
%}

namespace QuantLib {

    class LMMDriftCalculator {
        public:
            %noimpl(LMMDriftCalculator);
            LMMDriftCalculator(
                const Matrix& Pseudo_square_root,               //!< Pseudo square root of the covariance matrix.
                const std::vector<Spread>& Displacements,       //!< Displacements.
                const std::vector<Time>& Taus,                  //!< Taus.
                Size Numeraire,                                 //!< Numeraire.
                Size Alive                                      //!< Index of the first rates still alive.
            );

            %wrap(computePlain);
            //! Full factor drift computation using the LMMDriftCalculator object.
            std::vector<Real> computePlain(
                const LMMCurveState& CurveState                 //!< LMMCurveState object ID.
            ) const;

            %wrap(computeReduced);
            //! Reduced factor (Joshi algorithm) drift computation using the LMMDriftCalculator object.
            std::vector<Real> computeReduced(
                const LMMCurveState& CurveState                 //!< LMMCurveState object ID.
            ) const;

            %wrap(compute);
            //! Reduced factor (Joshi algorithm) drift computation using the LMMDriftCalculator object.
            std::vector<Real> compute(
                const LMMCurveState& CurveState                 //!< LMMCurveState object ID.
            ) const;
%insert(rp_class) %{
      private:
        mutable std::vector<QuantLib::Real> drifts_;
%}
    };

    class LMMNormalDriftCalculator {
        public:
            %noimpl(LMMNormalDriftCalculator);
            LMMNormalDriftCalculator(
                const Matrix& Pseudo_square_root,               //!< Pseudo square root of the covariance matrix.
                const std::vector<Time>& Taus,                  //!< Taus.
                Size Numeraire,                                 //!< Numeraire.
                Size Alive                                      //!< Index of the first rates still alive.
            );

            %wrap(computePlain);
            //! Full factor drift computation using the LMMNormalDriftCalculator object.
            std::vector<Real> computePlain(
                const LMMCurveState& CurveState                 //!< LMMCurveState object ID.
            ) const;

            %wrap(computeReduced);
            //! Reduced factor (Joshi algorithm) drift computation using the LMMNormalDriftCalculator object.
            std::vector<Real> computeReduced(
                const LMMCurveState& CurveState                 //!< LMMCurveState object ID.
            ) const;

            %wrap(compute);
            //! Reduced factor (Joshi algorithm) drift computation using the LMMNormalDriftCalculator object.
            std::vector<Real> compute(
                const LMMCurveState& CurveState                 //!< LMMCurveState object ID.
            ) const;
%insert(rp_class) %{
      private:
        mutable std::vector<QuantLib::Real> drifts_;
%}
    };

    class CMSMMDriftCalculator {
        public:
            %noimpl(CMSMMDriftCalculator);
            CMSMMDriftCalculator(
                const Matrix& Pseudo_square_root,               //!< Pseudo square root of the covariance matrix.
                const std::vector<Spread>& Displacements,       //!< Displacements.
                const std::vector<Time>& Taus,                  //!< Taus.
                Size Numeraire,                                 //!< Numeraire.
                Size Alive,                                     //!< Index of the first rates still alive.
                Size SpanningFwds                               //!< Number of forwards to be spanned.
            );

            %wrap(compute);
            //! Full factor drift computation using the CMSMMDriftCalculator object.
            std::vector<Real> compute(
                const CMSwapCurveState& CurveState              //!< CMSwapCurveState object ID.
            ) const;
%insert(rp_class) %{
      private:
        mutable std::vector<QuantLib::Real> drifts_;
%}
    };

    class SMMDriftCalculator {
        public:
            %noimpl(SMMDriftCalculator);
            SMMDriftCalculator(
                const Matrix& Pseudo_square_root,               //!< Pseudo square root of the covariance matrix.
                const std::vector<Spread>& Displacements,       //!< Displacements.
                const std::vector<Time>& Taus,                  //!< Taus.
                Size Numeraire,                                 //!< Numeraire.
                Size Alive                                      //!< Index of the first rates still alive.
            );

            %wrap(compute);
            //! Full factor drift computation using the SMMDriftCalculator object.
            std::vector<Real> compute(
                const CoterminalSwapCurveState& CurveState      //!< CoterminalSwapCurveState object ID.
            ) const;
%insert(rp_class) %{
      private:
        mutable std::vector<QuantLib::Real> drifts_;
%}
    };
}

