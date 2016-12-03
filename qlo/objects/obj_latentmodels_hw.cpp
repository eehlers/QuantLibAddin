
#include <qlo/objects/obj_latentmodels.hpp>
#include <boost/make_shared.hpp>
#include <ql/experimental/credit/defaultprobabilitylatentmodel.hpp>

QuantLibAddin::GaussianDefProbLM::GaussianDefProbLM(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            boost::shared_ptr< QuantLib::Basket > const &Basket,
            std::vector< std::vector< QuantLib::Real > > const &Factors,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::GaussianDefProbLM>(properties, permanent) {
        libraryObject_ = boost::make_shared<QuantLib::GaussianDefProbLM>(
            //basket,
            Factors,
            QuantLib::LatentModelIntegrationType::GaussianQuadrature);
        libraryObject_->resetBasket(Basket);
}

QuantLibAddin::TDefProbLM::TDefProbLM(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Integer > const &Torders,
            boost::shared_ptr< QuantLib::Basket > const &Basket,
            std::vector< std::vector< QuantLib::Real > > const &Factors,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::TDefProbLM>(properties, permanent) {
        QuantLib::TCopulaPolicy::initTraits initsT;
        initsT.tOrders = Torders;
        libraryObject_ = boost::make_shared<QuantLib::TDefProbLM>(
            //basket,
            Factors,
            QuantLib::LatentModelIntegrationType::GaussianQuadrature,
            initsT);
        libraryObject_->resetBasket(Basket);
}

