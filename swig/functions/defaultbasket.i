
%group(defaultbasket);
%groupCaption(Default Basket);

%override;

//%insert(defaultbasket_addin_cpp) %{
//#include <ql/experimental/credit/basket.hpp>
//#include <qlo/objects/credit/credit.hpp>
//#include <qlo/objects/credit/defaultbasket.hpp>
//#include <qlo/objects/credit/basketlossmodels.hpp>
//%}

namespace QuantLib {

    class Basket {
    public:
        %rename(CreditBasket) Basket;
        Basket(
            const std::vector<std::string>& IssuerNames,                            //!< Array containing the issuer names in the basket
            const std::vector<boost::shared_ptr<QuantLib::Issuer> >& Issuers,       //!< Array of Issuers.
            const std::vector<QuantLib::Real>& Notionals,                           //!< Notional by which each name enters the basket.
            const QuantLib::Date& ReferenceDate/*=QuantLib::Date()*/,               //!< Basket inception date.
            QuantLib::Real AttachmentRatio,                                         //!< Attachment ratio for losses affecting the basket.
            QuantLib::Real DettachmentRatio,                                        //!< Dettachment ratio for losses affecting the basket.
            bool Amortizing                                                         //!< Whether is Quarterly amortizing.
        );

        // FIXME check if a rename would suffice here instead of a rename2?
        %rename2(setLossModel, CreditBasketSetLossModel);
        //! Assigns a Default Loss Model to a given basket. Subsequent basket computations will use that model.
        void setLossModel(
            const boost::shared_ptr<DefaultLossModel>& DefaultLossModel             //!< Loss Model.
        );
        %rename2(size, CreditBasketSize);
        //! Number of counterparties at inception.
        Size size() const;
        %rename2(remainingNotional, CreditBasketLiveNotional);
        //! Non defaulted portfolio outstanding notional.
        Real remainingNotional() const;
        %rename2(cumulatedLoss, CreditBasketLoss);
        //! Losses from default events.
        Real cumulatedLoss() const;
        %rename2(remainingAttachmentAmount, CrediBasketAttachLive);
        //! Remaining attach amount.
        Real remainingAttachmentAmount() const;
        %rename2(remainingDetachmentAmount, CrediBasketDetachLive);
        //! Remaining detach amount.
        Real remainingDetachmentAmount() const;
        //! Basket expected tranche according to the basket loss model.
        Real expectedTrancheLoss(
            const Date& DateForLoss=QuantLib::Date()                                //!< Computes the expected loss on this date.
        ) const;
        %rename2(percentile, CreditBasketPercentile);
        //! Basket loss percentile amount (tranched).
        Real percentile(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the loss percentile on this date.
            Probability PercentileValue                                             //!< Percentile requested.
        );
        %rename2(expectedShortfall, CreditBasketESF);
        //! Basket loss expected shortfall amount (tranched).
        Real expectedShortfall(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the loss percentile on this date.
            Probability PercentileValue                                             //!< Percentile requested.
        );
        %rename2(probsBeingNthEvent, CreditBasketNthEventP);
        //! Probability of each basket name to default in the given order.
        std::vector<Probability> probsBeingNthEvent(
            Size EventOrder,                                                        //!< The order of default for which the probability is returned.
            const Date& DateForLoss=QuantLib::Date()                                //!< Computes the probabilities on this date.
        );
        %rename2(probOverLoss, CreditBasketProbLoss);
        //! Probability of basket losses to be over a value at a given date.
        Probability probOverLoss(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the probabilities on this date.
            Real LossFractionValue                                                  //!< Value of losses as a fraction of initial tanche amount.
        );
        %rename2(splitVaRLevel, CreditBasketSplitLoss);
        //! Splits a loss amount by counterparty contribution.
        //Disposable<std::vector<Real> > splitVaRLevel(
        std::vector<Real> splitVaRLevel(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the probabilities on this date.
            Real LossValue                                                          //!< Value of losses in absolute amount.
        );
        %rename2(defaultCorrelation, CreditBasketDefaulCorrel);
        //! Default correlation between two basket issuers.
        Real defaultCorrelation(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the probabilities on this date.
            Size IndexIssuer1,                                                      //!< First name.
            Size IndexIssuer2                                                       //!< Second name.
        );
    };
}
