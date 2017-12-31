
%group(volatility);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class LmVolatilityModel;
    class PiecewiseConstantVariance;
}
%}

%insert(obj_cpp) %{
#include <ql/legacy/libormarketmodels/lmextlinexpvolmodel.hpp>
#include <ql/models/marketmodels/models/piecewiseconstantabcdvariance.hpp>
%}

namespace QuantLib {

    class LmVolatilityModel{};

    class LmLinearExponentialVolatilityModel : public LmVolatilityModel{};

    class LmExtLinearExponentialVolModel : public LmLinearExponentialVolatilityModel {
        public:
            %rename2(LmExtLinearExponentialVolModel, MarketModelLmExtLinearExponentialVolModel);
            LmExtLinearExponentialVolModel(
                const std::vector<Time>& FixingTimes,   //!< Rate fixing times.
                Real A,                                 //!< A parameter.
                Real B,                                 //!< B parameter.
                Real C,                                 //!< C parameter.
                Real D                                  //!< D parameter.
            );
    };

    class PiecewiseConstantVariance {
        public:
            //! Returns the piecewise constant variances.
            const std::vector<Real>& variances() const;

            //! Returns the piecewise constant volatilities.
            const std::vector<Real>& volatilities() const;

            //! Returns the rate time of the PiecewiseConstantVariance object.
            const std::vector<Time>& rateTimes() const;

            //! Returns the piecewise constant variance at a given time index.
            Real variance(
                Size TimeIndex                          //!< Time index.
            ) const;

            //! Returns the rate time of the PiecewiseConstantVariance object.
            Volatility volatility(
                Size TimeIndex                          //!< Time index.
            ) const;

            //! Returns the total variance at a given time index of the PiecewiseConstantVariance object.
            Real totalVariance(
                Size TimeIndex                          //!< Time index.
            ) const;

            //! Returns the total volatility at a given time index of the PiecewiseConstantVariance object.
            Volatility totalVolatility(
                Size TimeIndex                          //!< Time index.
            ) const;
    };

    class PiecewiseConstantAbcdVariance : public PiecewiseConstantVariance {
        public:
            PiecewiseConstantAbcdVariance(
                Real A=-0.06,                           //!< Coefficient in abcd vol parametrization. Used as guess if the object is later calibrated.
                Real B=0.17,                            //!< Coefficient in abcd vol parametrization. Used as guess if the object is later calibrated.
                Real C=0.54,                            //!< Coefficient in abcd vol parametrization. Used as guess if the object is later calibrated.
                Real D=0.17,                            //!< Coefficient in abcd vol parametrization. Used as guess if the object is later calibrated.
                Size ResetIndex,                        //!< Index that defines the reset time of rate.
                const std::vector<Time>& RateTimes      //!< Rate fixing times.
            );
    };
}

