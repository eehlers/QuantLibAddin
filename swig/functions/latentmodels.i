
%group(latentmodels);
%groupCaption(Latent Models);

%override;

%insert(latentmodels_addin_cpp) %{
#include <ql/experimental/credit/basket.hpp>
    
#include <qlo/objects/credit/defaultbasket.hpp>
#include <qlo/objects/credit/credit.hpp>
%}

namespace QuantLib {

    class GaussianDefProbLM {
    public:
        GaussianDefProbLM(
            const boost::shared_ptr<QuantLib::Basket>& Basket,                  //!< Defaultable positions basket.
            const std::vector<std::vector<QuantLib::Real> >& Factors            //!< Systemic model factors.
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
    };

    class GaussianDefProbLM {
    public:
        //! Default probability correlation.
        Real defaultCorrelation(
            const Date& CorrelationDate/*=QuantLib::Date()*/,                   //!< Correlation date.
            Size NameindexA,                                                    //!< First name index
            Size NameindexB                                                     //!< Second name index
        );
        //! Default probability correlation.
        Real latentVariableCorrel(
            Size NameindexA,                                                    //!< First name index
            Size NameindexB                                                     //!< Second name index
        );
        //! Probability of having a given number of defaults or more.
        Probability probAtLeastNEvents(
            Size NumDefaults,                                                   //!< Number of defaults
            const Date& ProbabilityDate=QuantLib::Date()                        //!< Target date.
        );        
    };

    class TDefProbLM {
    public:
        //! Default probability correlation.
        Real defaultCorrelation(
            const Date& CorrelationDate/*=QuantLib::Date()*/,                   //!< Correlation date.
            Size NameindexA,                                                    //!< First name index
            Size NameindexB                                                     //!< Second name index
        );
        //! Default probability correlation.
        Real latentVariableCorrel(
            Size NameindexA,                                                    //!< First name index
            Size NameindexB                                                     //!< Second name index
        );
        //! Probability of having a given number of defaults or more.
        Probability probAtLeastNEvents(
            Size NumDefaults,                                                   //!< Number of defaults
            const Date& ProbabilityDate=QuantLib::Date()                        //!< Target date.
        );        
    };
}

