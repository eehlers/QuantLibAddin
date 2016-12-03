
#include <qlo/objects/obj_defaultbasket.hpp>

#include <ql/currencies/europe.hpp>
#include <ql/experimental/credit/basket.hpp>
#include <boost/make_shared.hpp>

QuantLibAddin::Basket::Basket(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< std::string > const &IssuerNames,
            std::vector< boost::shared_ptr< QuantLib::Issuer > > const &Issuers,
            std::vector< QuantLib::Real > const &Notionals,
            QuantLib::Date const &ReferenceDate,
            QuantLib::Real AttachmentRatio,
            QuantLib::Real DettachmentRatio,
            bool Amortizing,
            // END   typemap rp_tm_default
    bool permanent) : reposit::LibraryObject<QuantLib::Basket>(properties, permanent) {

        QL_REQUIRE(IssuerNames.size() == Issuers.size(), 
            "Different number of names and issuers.");

        std::vector<QuantLib::DefaultProbKey> contractTriggers(
            IssuerNames.size(), 
            QuantLib::NorthAmericaCorpDefaultKey(QuantLib::EURCurrency(),
                QuantLib::SeniorSec, 
                QuantLib::Period(),
                1. // amount threshold
            ));

        boost::shared_ptr<QuantLib::Pool> pool(new QuantLib::Pool());
        for(QuantLib::Size i=0; i<IssuerNames.size(); i++)
                pool->add(IssuerNames[i], *Issuers[i], contractTriggers[i]);
        libraryObject_ = 
            boost::make_shared<QuantLib::Basket>(
                QuantLib::Basket(ReferenceDate, IssuerNames, Notionals, pool,
                    AttachmentRatio, DettachmentRatio));
}
