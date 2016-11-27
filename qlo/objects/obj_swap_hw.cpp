
#include <qlo/objects/obj_swap.hpp>
#include <qlo/objects/cashflows/flowanalysis.hpp>

#include <ql/instruments/swap.hpp>
#include <ql/instruments/makecms.hpp>
#include <ql/cashflows/couponpricer.hpp>

QuantLibAddin::Swap::Swap(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Leg > const &legs,
            std::vector< bool > const &payer,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::Swap>(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::Swap>(new QuantLib::Swap(
                // BEGIN typemap rp_tm_default
                legs,
                payer
                // END   typemap rp_tm_default
    ));
}


QuantLibAddin::Swap::Swap(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Period const &SwapTenor,
            boost::shared_ptr< QuantLib::SwapIndex > const &SwapIndex,
            boost::shared_ptr< QuantLib::IborIndex > const &IborIndex,
            QuantLib::Spread IborSpread,
            QuantLib::Period const &ForwardStart,
            boost::shared_ptr< QuantLib::CmsCouponPricer > const &Pricer,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::Swap>(properties, permanent) {
        libraryObject_ = QuantLib::MakeCms(SwapTenor, SwapIndex,
                                           IborIndex, IborSpread,
                                           ForwardStart)
                         .withCmsCouponPricer(Pricer)
                         .operator boost::shared_ptr<QuantLib::Swap>();
}

std::vector<std::vector<reposit::property_t> > QuantLibAddin::Swap::legAnalysis(QuantLib::Size i,
                                              const QuantLib::Date& d)
{
    boost::shared_ptr<QuantLib::Swap> temp;
    getLibraryObject(temp);
    return flowAnalysis(temp->leg(i), d);
}

