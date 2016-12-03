
%group(Basket Loss Models);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class DefaultLossModel;
    class CorrelationTermStructure;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_credit.hpp>
#include <ql/experimental/credit/correlationstructure.hpp>
%}

namespace QuantLib {

    class DefaultLossModel {};
    
    class GaussianLHPLossModel : public DefaultLossModel {
    public:
        GaussianLHPLossModel(
            Real Correlation,                                   //!< Gaussian model single correlation.
            const std::vector<Real>& RecoveryRates              //!< Recovery rates of each live name in the portfolio.
        );
    };

    class IHGaussPoolLossModel : public DefaultLossModel {
    public:
        IHGaussPoolLossModel(
            const Real Correlation,                             //!< Model single correlation.
            const std::vector<Real>& RecoveryRates,             //!< Recovery rates of each live name in the portfolio.
            const Size NumBuckets                               //!< Number of distribution loss buckets.
        );
    };

    class IHStudentPoolLossModel : public DefaultLossModel {
    public:
        IHStudentPoolLossModel(
            const Real Correlation,                             //!< Model single correlation.
            const std::vector<Real>& RecoveryRates,             //!< Recovery rates of each live name in the portfolio.
            const std::vector<Real>& Ttraits,                   //!< T orders on each factor.
            const Size NumBuckets                               //!< Number of distribution loss buckets.
        );
    };

    class GaussianBinomialLossModel : public DefaultLossModel {
    public:
        %rename(GBinomialLossmodel) GaussianBinomialLossModel;
        GaussianBinomialLossModel(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates              //!< Recovery rates of each live name in the portfolio.
        );
    };

    class TBinomialLossModel : public DefaultLossModel {
    public:
        TBinomialLossModel(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates,             //!< Recovery rates of each live name in the portfolio.
            const std::vector<Real>& Ttraits                    //!< T orders on each factor.
        );
    };

    class BaseCorrelationLossModel : public DefaultLossModel {
    public:
        BaseCorrelationLossModel(
            const std::string& BaseModel,                       //!< The base algorithm on which the EL is to be computed at different correlations.
            const boost::shared_ptr<CorrelationTermStructure>& BaseCorrelationSurface, //!< Base correlation surface.
            const std::vector<Real>& Recoveries,                //!< Quoted recoveries for each name in the model.
            const std::vector<Real>& InitiTraits                //!< Copula initialization traits are defined in terms of this vector.
        );
    };

    class GaussianRandomDefaultLM : public DefaultLossModel {
    public:
        %rename(GMCLossModel) GaussianRandomDefaultLM;
        GaussianRandomDefaultLM(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates,             //!< Recovery rates of each live name in the portfolio.
            const Size NumSimulations                           //!< MC simulations.
        );
    };

    class GaussianRandomLossLM : public DefaultLossModel {
    public:
        %rename(GRandomRRMCLossModel) GaussianRandomLossLM;
        GaussianRandomLossLM(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates,             //!< Recovery rates of each live name in the portfolio.
            const Real ModelA,                                  //!< Recovery deviation parameter.
            const Size NumSimulations                           //!< MC simulations.
        );
    };

    class TRandomDefaultLM : public DefaultLossModel {
    public:
        %rename(TMCLossModel) TRandomDefaultLM;
        TRandomDefaultLM(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates,             //!< Recovery rates of each live name in the portfolio.
            const std::vector<Real>& Ttraits,                   //!< T orders on each factor.
            const Size NumSimulations                           //!< MC simulations.
        );
    };

    class TRandomLossLM : public DefaultLossModel {
    public:
        %rename(TRandomRRMCLossModel) TRandomLossLM;
        TRandomLossLM(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates,             //!< Recovery rates of each live name in the portfolio.
            const std::vector<Real>& Ttraits,                   //!< T orders on each factor.
            const Real ModelA,                                  //!< Recovery deviation parameter.
            const Size NumSimulations                           //!< MC simulations.
        );
    };

    class SaddlePointLossModel : public DefaultLossModel {
    public:
        %rename(GSaddlePointLossModel) SaddlePointLossModel;
        SaddlePointLossModel(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates              //!< Recovery rates of each live name in the portfolio.
        );
    };

    class TSaddlePointLossModel : public DefaultLossModel {
    public:
        TSaddlePointLossModel(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates,             //!< Recovery rates of each live name in the portfolio.
            const std::vector<Real>& Ttraits                    //!< T orders on each factor.
        );
    };

    class RecursiveGaussLossModel : public DefaultLossModel {
    public:
        %rename(GRecursiveLossmodel) RecursiveGaussLossModel;
        RecursiveGaussLossModel(
            const std::vector<std::vector<Real> >& Factors,     //!< Systemic model factors.
            const std::vector<Real>& RecoveryRates              //!< Recovery rates of each live name in the portfolio.
        );
    };
}

