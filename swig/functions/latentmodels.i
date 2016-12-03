
%group(Latent Models);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    template<class copulaPolicy> class DefaultLatentModel;

    struct GaussianCopulaPolicy;
    class TCopulaPolicy;

    typedef DefaultLatentModel<GaussianCopulaPolicy> GaussianDefProbLM;
    typedef DefaultLatentModel<TCopulaPolicy> TDefProbLM;

    class Basket;
}
%}

%insert(obj_cpp) %{
//#include <ql/experimental/credit/basket.hpp>
#include <qlo/objects/obj_defaultbasket.hpp>
//#include <qlo/objects/credit/credit.hpp>
#include <ql/experimental/credit/defaultprobabilitylatentmodel.hpp>
%}

namespace QuantLib {

    class GaussianDefProbLM {
      public:

        GaussianDefProbLM(
            const boost::shared_ptr<QuantLib::Basket>& Basket,                  //!< Defaultable positions basket.
            const std::vector<std::vector<QuantLib::Real> >& Factors            //!< Systemic model factors.
        );

        //! Default probability correlation.
        %rename2(defaultCorrelation, GaussianLMDefaultCorrel);
        Real defaultCorrelation(
            const Date& CorrelationDate/*=QuantLib::Date()*/,                   //!< Correlation date.
            Size NameindexA,                                                    //!< First name index
            Size NameindexB                                                     //!< Second name index
        );

        //! Default probability correlation.
        %rename2(latentVariableCorrel, GaussianLMAssetCorrel);
        Real latentVariableCorrel(
            Size NameindexA,                                                    //!< First name index
            Size NameindexB                                                     //!< Second name index
        );

        //! Probability of having a given number of defaults or more.
        %rename2(probAtLeastNEvents, GaussianLMProbNHits);
        Probability probAtLeastNEvents(
            Size NumDefaults,                                                   //!< Number of defaults
            const Date& ProbabilityDate=QuantLib::Date()                        //!< Target date.
        );        
    };

    class TDefProbLM {
      public:

        %rename(TDefaultProbLM) TDefProbLM;
        TDefProbLM(
            const std::vector<QuantLib::Integer>& Torders,                      //!< Orders of the StudentT variates.
            const boost::shared_ptr<QuantLib::Basket>& Basket,                  //!< Defaultable positions basket.
            const std::vector<std::vector<QuantLib::Real> >& Factors            //!< Systemic model factors.
        );

        //! Default probability correlation.
        %rename2(defaultCorrelation, TLMDefaultCorrel);
        Real defaultCorrelation(
            const Date& CorrelationDate/*=QuantLib::Date()*/,                   //!< Correlation date.
            Size NameindexA,                                                    //!< First name index
            Size NameindexB                                                     //!< Second name index
        );

        //! Default probability correlation.
        %rename2(latentVariableCorrel, TLMAssetCorrel);
        Real latentVariableCorrel(
            Size NameindexA,                                                    //!< First name index
            Size NameindexB                                                     //!< Second name index
        );

        //! Probability of having a given number of defaults or more.
        %rename2(probAtLeastNEvents, TLMProbNHits);
        Probability probAtLeastNEvents(
            Size NumDefaults,                                                   //!< Number of defaults
            const Date& ProbabilityDate=QuantLib::Date()                        //!< Target date.
        );        
    };
}

