
%group(Default Basket);

%insert(obj_hpp) %{
#include <ql/types.hpp>
#include <ql/time/date.hpp>

namespace QuantLib {
    class Basket;
    class Issuer;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_credit.hpp>
#include <qlo/objects/obj_basketlossmodels.hpp>
#include <ql/currencies/europe.hpp>
#include <ql/experimental/credit/basket.hpp>
#include <boost/make_shared.hpp>
%}

namespace QuantLib {

    %rename(CreditBasket) Basket;
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

        //! Assigns a Default Loss Model to a given basket. Subsequent basket computations will use that model.
        void setLossModel(
            const boost::shared_ptr<DefaultLossModel>& DefaultLossModel             //!< Loss Model.
        );

        //! Number of counterparties at inception.
        Size size() const;

        //! Non defaulted portfolio outstanding notional.
        %rename(liveNotional) remainingNotional;
        Real remainingNotional() const;

        //! Losses from default events.
        %rename(loss) cumulatedLoss;
        Real cumulatedLoss() const;

        //! Remaining attach amount.
        %rename(attachLive) remainingAttachmentAmount;
        Real remainingAttachmentAmount() const;

        //! Remaining detach amount.
        %rename(detachLive) remainingDetachmentAmount;
        Real remainingDetachmentAmount() const;

        //! Basket expected tranche according to the basket loss model.
        %rename2(expectedTrancheLoss, expectedTrancheLoss);
        Real expectedTrancheLoss(
            const Date& DateForLoss=QuantLib::Date()                                //!< Computes the expected loss on this date.
        ) const;

        //! Basket loss percentile amount (tranched).
        Real percentile(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the loss percentile on this date.
            Probability PercentileValue                                             //!< Percentile requested.
        );

        //! Basket loss expected shortfall amount (tranched).
        %rename(ESF) expectedShortfall;
        Real expectedShortfall(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the loss percentile on this date.
            Probability PercentileValue                                             //!< Percentile requested.
        );

        //! Probability of each basket name to default in the given order.
        %rename(nthEventP) probsBeingNthEvent;
        std::vector<Probability> probsBeingNthEvent(
            Size EventOrder,                                                        //!< The order of default for which the probability is returned.
            const Date& DateForLoss=QuantLib::Date()                                //!< Computes the probabilities on this date.
        );

        //! Probability of basket losses to be over a value at a given date.
        %rename(probLoss) probOverLoss;
        Probability probOverLoss(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the probabilities on this date.
            Real LossFractionValue                                                  //!< Value of losses as a fraction of initial tanche amount.
        );

        //! Splits a loss amount by counterparty contribution.
        %rename(splitLoss) splitVaRLevel;
        //Disposable<std::vector<Real> > splitVaRLevel(
        std::vector<Real> splitVaRLevel(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the probabilities on this date.
            Real LossValue                                                          //!< Value of losses in absolute amount.
        );

        //! Default correlation between two basket issuers.
        %rename(defaulCorrel) defaultCorrelation;
        Real defaultCorrelation(
            const Date& DateForLoss/*=QuantLib::Date()*/,                           //!< Computes the probabilities on this date.
            Size IndexIssuer1,                                                      //!< First name.
            Size IndexIssuer2                                                       //!< Second name.
        );
    };
}
