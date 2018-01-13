
%group(sequencestatistics);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class Matrix;

    class GeneralStatistics;

    template<class Stat>
    class GenericGaussianStatistics;

    typedef GenericGaussianStatistics<GeneralStatistics> GaussianStatistics;

    template <class S>
    class GenericRiskStatistics;

    typedef GenericRiskStatistics<GaussianStatistics> RiskStatistics;

    typedef RiskStatistics Statistics;
    class IncrementalStatistics;

    template <class StatisticsType>
    class GenericSequenceStatistics;

    typedef GenericSequenceStatistics<Statistics> SequenceStatistics;
    typedef GenericSequenceStatistics<IncrementalStatistics> SequenceStatisticsInc;
}
%}

%insert(obj_cpp) %{
#include <ql/math/statistics/sequencestatistics.hpp>
%}

namespace QuantLib {

    class SequenceStatistics {
        public:
            SequenceStatistics(
                Size Dimension=0                                        //!< Sample dimensionality.
            );

            %noimpl(SequenceStatistics);
            %rename(SequenceStatistics2) SequenceStatistics;
            SequenceStatistics(
                Size Dimension=0,                                       //!< Sample dimensionality.
                Matrix& Values/*=Matrix()*/,                            //!< Sampled values. If omitted, an empty statistics is created.
                std::vector<Real>& Weights=std::vector<Real>()          //!< If omitted, all sampled values have the same weight.
            );

            //! Returns the number of samples collected for the given SequenceStatistics object.
            Size samples();

            //! Returns the sum of data weights for the given SequenceStatistics object.
            Real weightSum();

            //! Returns the mean for the given SequenceStatistics object.
            std::vector<Real> mean();

            //! Returns the variance for the given SequenceStatistics object.
            std::vector<Real> variance();

            //! Returns the the standard deviation for the given SequenceStatistics object.
            std::vector<Real> standardDeviation();

            //! Returns the variance of observations below zero for the given SequenceStatistics object.
            std::vector<Real> downsideVariance();

            //! Returns the square root of the downside variance for the given SequenceStatistics object.
            std::vector<Real> downsideDeviation();

            //! Returns the variance of observations below the mean for the given SequenceStatistics object.
            std::vector<Real> semiVariance();

            //! Returns the square root of the semivariance for the given SequenceStatistics object.
            std::vector<Real> semiDeviation();

            //! Returns the error estimate on the mean value for the given SequenceStatistics object.
            std::vector<Real> errorEstimate();

            //! Returns the skewness for the given SequenceStatistics object.
            std::vector<Real> skewness();

            //! Returns the excess kurtosis for the given SequenceStatistics object.
            std::vector<Real> kurtosis();

            //! Returns the minimum sample value for the given SequenceStatistics object.
            std::vector<Real> min();

            //! Returns the maximum sample value for the given SequenceStatistics object.
            std::vector<Real> max();

            //! Returns the x-th percentile for the given SequenceStatistics object.
            std::vector<Real> gaussianPercentile(Real y);

            //! Returns the x-th percentile for the given SequenceStatistics object.
            std::vector<Real> percentile(Real y);

            //! Returns the reciprocal of VAR at a given percentile for the given SequenceStatistics object.
            std::vector<Real> gaussianPotentialUpside(Real percentile);

            //! Returns the reciprocal of VAR at a given percentile for the given SequenceStatistics object.
            std::vector<Real> potentialUpside(Real percentile);

            //! Returns the value-at-risk at a given percentile for the given SequenceStatistics object.
            std::vector<Real> gaussianValueAtRisk(Real percentile);

            //! Returns the value-at-risk at a given percentile for the given SequenceStatistics object.
            std::vector<Real> valueAtRisk(Real percentile);

            //! Returns the variance of observations below target for the given SequenceStatistics object.
            std::vector<Real> regret(Real target);

            //! Returns the probability of missing the given target for the given SequenceStatistics object.
            std::vector<Real> gaussianShortfall(Real target);

            //! Returns the probability of missing the given target for the given SequenceStatistics object.
            std::vector<Real> shortfall(Real target);

            //! Returns the averaged shortfallness for the given SequenceStatistics object.
            std::vector<Real> gaussianAverageShortfall(Real target);

            //! Returns the averaged shortfallness for the given SequenceStatistics object.
            std::vector<Real> averageShortfall(Real target);

            //! Returns the size (sample dimensionality) for the given SequenceStatistics object.
            Size size();

            //! Returns the covariance Matrix for the given SequenceStatistics object.
            Matrix covariance();

            //! Returns the correlation Matrix for the given SequenceStatistics object.
            Matrix correlation();
    };

    class SequenceStatisticsInc {
        public:
            SequenceStatisticsInc(
                Size Dimension=0                                        //!< Sample dimensionality.
            );

            %noimpl(SequenceStatisticsInc);
            %rename(SequenceStatisticsInc2) SequenceStatisticsInc;
            SequenceStatisticsInc(
                Size Dimension=0,                                       //!< Sample dimensionality.
                Matrix& Values/*=Matrix()*/,                            //!< Sampled values. If omitted, an empty statistics is created.
                std::vector<Real>& Weights=std::vector<Real>()          //!< If omitted, all sampled values have the same weight.
            );
    };
}

