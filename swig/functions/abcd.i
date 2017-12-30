
%group(abcd);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class AbcdFunction;
    class AbcdCalibration;
    class Quote;
    class EndCriteria;
    class OptimizationMethod;
}
%}

%insert(obj_cpp) %{
#include <ql/termstructures/volatility/abcd.hpp>
#include <ql/termstructures/volatility/abcdcalibration.hpp>
#include <qlo/objects/obj_optimization.hpp>
%}

namespace QuantLib {

    class AbcdFunction {
        public:
            AbcdFunction(
                QuantLib::Real A=-0.06, //!< The a coefficient in the abcd vol parametrization. Used as guess if the object is later calibrated.
                QuantLib::Real B=0.17,  //!< The b coefficient in the abcd vol parametrization. Used as guess if the object is later calibrated.
                QuantLib::Real C=0.54,  //!< The c coefficient in the abcd vol parametrization. Used as guess if the object is later calibrated.
                QuantLib::Real D=0.17); //!< The d coefficient in the abcd vol parametrization. Used as guess if the object is later calibrated.

            //! Returns the instantaneous volatility as function of residual time to maturity u=T-t: [a + b*u] * e^{-c*u} + d.
            %rename(instantaneousValue) operator();
            %loop(instantaneousValue, U);
            Real operator()(
                Time U                  //!< Residual time(s) to maturity.
            ) const;
    
            //! Returns covariance at calendar time u between T and S rates fixing times.
            %loop(instantaneousCovariance, U);
            Real instantaneousCovariance(
                Time U,                 //!< Calendar time(s).
                Time T,                 //!< Fixing time of first rate.
                Time S                  //!< Fixing time of second rate.
            ) const;

            //! Returns variance at calendar time(s) u of T-fixing rate.
            %loop(instantaneousVariance, U);
            Real instantaneousVariance(
                Time U,                 //!< Calendar time(s).
                Time T                  //!< Fixing time of first rate.
            ) const;

            //! Returns volatility/ies at calendar time(s) u of T-fixing rate.
            %loop(instantaneousVolatility, U);
            Real instantaneousVolatility(
                Time U,                 //!< Calendar time(s).
                Time T                  //!< Fixing calendar time of the rate.
            ) const;

            //! Returns covariance(s) in [tMin,tMax] between T and S rate fixing times.
            %loop(covariance, TMax);
            Real covariance(
                Time TMin,              //!< Lower bound of the covariance integral.
                Time TMax,              //!< Upper bound(s) of the covariance integral(s).
                Time T,                 //!< Fixing calendar time of first rate.
                Time S                  //!< Fixing calendar time of second rate.
            ) const;

            //! Returns variance(s) in [tMin,tMax] of T rate fixing time.
            %loop(variance, TMax);
            Real variance(
                Time TMin,              //!< Lower bound of the covariance integral.
                Time TMax,              //!< Upper bound of the covariance integral.
                Time T                  //!< Fixing calendar time of the rate.
            ) const;

            //! Returns volatility/ies in [tMin,tMax] of T rate fixing time.
            %loop(volatility, TMax);
            Real volatility(
                Time TMin,              //!< Lower bound of the covariance integral.
                Time TMax,              //!< Upper bound(s) of the covariance integral(s).
                Time T                  //!< Fixing calendar time of the rate.
            ) const;

            //! Returns the short term volatility implied by Abcd volatility.
            Real shortTermVolatility() const;

            //! Returns the long term volatility implied by Abcd volatility.
            Real longTermVolatility() const;

            //! Returns, if b is positive, the location of the Abcd volatility maximum.
            Time maximumLocation() const;

            //! Returns, if b is positive, the maximum of the Abcd volatility.
            Real maximumVolatility() const;

            //! Returns the a coefficient in the abcd vol parametrization.
            Real a() const;

            //! Returns the b coefficient in the abcd vol parametrization.
            Real b() const;

            //! Returns the c coefficient in the abcd vol parametrization.
            Real c() const;

            //! Returns the d coefficient in the abcd vol parametrization.
            %alias(d, AbcdDFunction);
            Real d() const;
    };

    class AbcdCalibration {
        public:
            AbcdCalibration(
                const std::vector<QuantLib::Time>& Times,                       //!< Times.
                const std::vector<QuantLib::Volatility>& BlackVols,             //!< Black Volatilities.
                QuantLib::Real A=-0.06,                                         //!< The a coefficient in the abcd vol parametrization. Used as guess if the object is later calibrated.
                QuantLib::Real B=0.17,                                          //!< The b coefficient in the abcd vol parametrization. Used as guess if the object is later calibrated.
                QuantLib::Real C=0.54,                                          //!< The c coefficient in the abcd vol parametrization. Used as guess if the object is later calibrated.
                QuantLib::Real D=0.17,                                          //!< The d coefficient in the abcd vol parametrization. Used as guess if the object is later calibrated.
                bool AIsFixed=false,                                            //!< TRUE if the a coefficient must be kept fixed in later calibrations.
                bool BIsFixed=false,                                            //!< TRUE if the b coefficient must be kept fixed in later calibrations.
                bool CIsFixed=false,                                            //!< TRUE if the c coefficient must be kept fixed in later calibrations.
                bool DIsFixed=false,                                            //!< TRUE if the d coefficient must be kept fixed in later calibrations.
                bool VegaWeighted=false,                                        //!< TRUE if the interpolation is weighted using options Vega.
                const boost::shared_ptr<EndCriteria>& EndCriteria=boost::shared_ptr<EndCriteria>(),//!< EndCriteria object ID.
                const boost::shared_ptr<OptimizationMethod>& Method=boost::shared_ptr<OptimizationMethod>());//!< OptimizationMethod object ID.

            //! Returns the d coefficient in the abcd vol parametrization.
            void compute();

            //! Returns the 'k' adjustment factors needed to match Black vols.
            std::vector<Real> k(
                std::vector<Real>& t,                                           //!< Times.
                const std::vector<Real>& blackVols                              //!< Black Volatilities.
            ) const;

            //! Returns the root mean squared error between the abdc implied Black vols and a given Black vol vector.
            Real error() const;

            //! Returs the max error between the abdc implied Black vols and a given Black vol vector.
            Real maxError() const;

            //! Calibrates the a, b, c, d parameters of the vol parametrization.
            EndCriteria::Type endCriteria() const;

            //! Returns the a coefficient in the abcd vol parametrization.
            Real a() const;

            //! Returns the b coefficient in the abcd vol parametrization.
            Real b() const;

            //! Returns the c coefficient in the abcd vol parametrization.
            Real c() const;

            //! Returns the d coefficient in the abcd vol parametrization.
            Real d() const;
    };
}

