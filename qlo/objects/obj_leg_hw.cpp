
// BEGIN buffer b_lib_grp_cpp


#include <qlo/objects/obj_leg.hpp>
#include <qlo/objects/obj_couponvectors.hpp>
#include <qlo/objects/cashflows/flowanalysis.hpp>
#include <qlo/enumerations/factories/iborcouponpricersfactory.hpp>
//#include <qlo/couponvectors.hpp>

#include <ql/instruments/capfloor.hpp>
#include <ql/instruments/swap.hpp>
#include <ql/cashflows/cashflowvectors.hpp>
#include <ql/cashflows/simplecashflow.hpp>
#include <ql/cashflows/cmscoupon.hpp>
#include <ql/cashflows/couponpricer.hpp>

QuantLibAddin::Leg::Leg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Real > const &Amounts,
            std::vector< QuantLib::Date > const &Dates,
            bool ToBeSorted,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::Leg>(properties, permanent) {

    QL_REQUIRE(Amounts.size() == Dates.size(),
        "Dates (" << Dates.size() << ") and Amounts (" <<
        Amounts.size() << ") must have the same size");

    libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new QuantLib::Leg());

    for (QuantLib::Size i=0; i<Amounts.size(); ++i) {
        if (Dates[i]!=QuantLib::Date())
            libraryObject_->push_back(boost::shared_ptr<QuantLib::CashFlow>(new
                QuantLib::SimpleCashFlow(Amounts[i], Dates[i])));
        else
            QL_REQUIRE(Amounts[i]==0 || Amounts[i]==QuantLib::Null<QuantLib::Real>(),
                       "non-null amount (" << Amounts[i] << ") on null date");
    }

    if (ToBeSorted)
        std::stable_sort(libraryObject_->begin(), libraryObject_->end(),
        QuantLib::earlier_than<boost::shared_ptr<QuantLib::CashFlow> >());
}

QuantLibAddin::Leg::Leg(const boost::shared_ptr<reposit::ValueObject>& prop,
         const boost::shared_ptr<QuantLib::Swap>& swap,
         QuantLib::Size i,
         bool permanent)
: reposit::LibraryObject<QuantLib::Leg>(prop, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new QuantLib::Leg());
    *libraryObject_ = swap->leg(i);
}

void QuantLibAddin::Leg::setCouponPricers(
            const std::vector<boost::shared_ptr<FloatingRateCouponPricer> >& pricers) {
    std::vector<std::string> ids;
    std::vector<boost::shared_ptr<QuantLib::FloatingRateCouponPricer> > ql_pricers;
    std::vector<boost::shared_ptr<FloatingRateCouponPricer> >::const_iterator i;
    for (i = pricers.begin(); i != pricers.end(); ++i) {
        ids.push_back((*i)->properties()->objectId());
        boost::shared_ptr<QuantLib::FloatingRateCouponPricer> p;
        (*i)->getLibraryObject(p);
        ql_pricers.push_back(p);
    }
    QuantLib::setCouponPricers(*libraryObject_, ql_pricers);

    boost::shared_ptr<reposit::ValueObject> inst_properties = properties();
    inst_properties->setProperty("UserLegIDs", ids);
}

std::vector<std::vector<reposit::property_t> >
QuantLibAddin::Leg::flowAnalysis(const QuantLib::Date& d) const {
    return QuantLibAddin::flowAnalysis(*libraryObject_, d);
}

QuantLibAddin::MultiPhaseLeg::MultiPhaseLeg(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< boost::shared_ptr< QuantLibAddin::Leg > > const &LegIDs,
            bool ToBeSorted,
            // END   typemap rp_tm_default
    bool permanent)
: Leg(properties, permanent) {

    libraryObject_ = boost::shared_ptr<QuantLib::Leg>(new QuantLib::Leg());

    boost::shared_ptr<QuantLib::Leg> leg;
    for (QuantLib::Size i=0; i<LegIDs.size(); ++i) {
        LegIDs[i]->getLibraryObject(leg);
        libraryObject_->insert(libraryObject_->end(),
                               leg->begin(), leg->end());
    }
    if (ToBeSorted)
        std::stable_sort(libraryObject_->begin(), libraryObject_->end(),
            QuantLib::earlier_than<boost::shared_ptr<QuantLib::CashFlow> >());
}


QuantLibAddin::InterestRate::InterestRate(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Rate Rate,
            QuantLib::DayCounter const &DayCounter,
            QuantLib::Compounding Compounding,
            QuantLib::Frequency Frequency,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::InterestRate>(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::InterestRate>(new QuantLib::InterestRate(
                // BEGIN typemap rp_tm_default
                Rate,
                DayCounter,
                Compounding,
                Frequency
                // END   typemap rp_tm_default
    ));
}


// END buffer b_lib_grp_cpp

