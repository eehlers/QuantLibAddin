/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2007 Chiara Fornarola
 Copyright (C) 2006, 2007, 2008, 2009, 2010, 2011 Ferdinando Ametrano
 Copyright (C) 2005, 2006 Eric Ehlers
 Copyright (C) 2005 Plamen Neykov
 Copyright (C) 2005 Walter Penschke
 Copyright (C) 2009 Piter Dias

 This file is part of QuantLib, a free-software/open-source library
 for financial quantitative analysts and developers - http://quantlib.org/

 QuantLib is free software: you can redistribute it and/or modify it
 under the terms of the QuantLib license.  You should have received a
 copy of the license along with this program; if not, please email
 <quantlib-dev@lists.sf.net>. The license is also available online at
 <http://quantlib.org/license.shtml>.

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
*/

#if defined(HAVE_CONFIG_H)
    #include <qlo/config.hpp>
#endif

#include <qlo/objects/obj_bonds.hpp>
#include <qlo/objects/cashflows/flowanalysis.hpp>

#include <ql/instruments/bonds/fixedratebond.hpp>
#include <ql/instruments/bonds/zerocouponbond.hpp>
#include <ql/instruments/bonds/cmsratebond.hpp>
#include <ql/instruments/bonds/floatingratebond.hpp>
#include <ql/cashflows/couponpricer.hpp>
#include <ql/pricingengines/bond/discountingbondengine.hpp>
#include <ql/indexes/swapindex.hpp>
#include <ql/interestrate.hpp>
#include <ql/utilities/dataformatters.hpp>

#include <rp/repository.hpp>

#include <ostream>

std::vector<std::vector<reposit::property_t> > QuantLibAddin::Bond::flowAnalysis(const QuantLib::Date& d)
{
    boost::shared_ptr<QuantLib::Bond> temp;
    getLibraryObject(temp);
    const QuantLib::Leg& cashflows = temp->cashflows();

    return QuantLibAddin::flowAnalysis(cashflows, d);
}

QuantLib::Real QuantLibAddin::Bond::redemptionAmount() {
    boost::shared_ptr<QuantLib::Bond> temp;
    getLibraryObject(temp);
    return temp->redemption()->amount();
}

QuantLib::Date QuantLibAddin::Bond::redemptionDate() {
    boost::shared_ptr<QuantLib::Bond> temp;
    getLibraryObject(temp);
    return temp->redemption()->date();
}

void QuantLibAddin::Bond::setCouponPricer(
            const boost::shared_ptr<QuantLib::FloatingRateCouponPricer>& pricer) {
    boost::shared_ptr<QuantLib::Bond> temp;
    getLibraryObject(temp);
    const QuantLib::Leg& cashflows = temp->cashflows();
    QuantLib::setCouponPricer(cashflows, pricer);
}

void QuantLibAddin::Bond::setCouponPricers(
        const std::vector<boost::shared_ptr<QuantLib::FloatingRateCouponPricer> >& p) {
    boost::shared_ptr<QuantLib::Bond> temp;
    getLibraryObject(temp);
    const QuantLib::Leg& cashflows = temp->cashflows();
    QuantLib::setCouponPricers(cashflows, p);
}

QuantLibAddin::Bond::Bond(const boost::shared_ptr<reposit::ValueObject>& properties,
           const std::string& des,
           const QuantLib::Currency& cur,
           QuantLib::Natural settlementDays,
           const QuantLib::Calendar& calendar,
           QuantLib::Real faceAmount,
           const QuantLib::Date& maturityDate,
           const QuantLib::Date& issueDate,
           const QuantLib::Leg& leg,
           bool permanent)
: Instrument(properties, permanent), description_(des), currency_(cur)
{
    qlBondObject_ = boost::shared_ptr<QuantLib::Bond>(new
        QuantLib::Bond(settlementDays,
                       calendar,
                       faceAmount,
                       maturityDate,
                       issueDate,
                       leg));
    libraryObject_ = qlBondObject_;
    if (description_.empty()) {
        std::ostringstream temp;
        temp << "Bond ";
        temp << QuantLib::io::iso_date(qlBondObject_->maturityDate());
        description_ = temp.str();
    }
}

QuantLibAddin::Bond::Bond(const boost::shared_ptr<reposit::ValueObject>& properties,
           const std::string& des,
           const QuantLib::Currency& cur,
           bool permanent)
: Instrument(properties, permanent), description_(des), currency_(cur) {}


const std::string& QuantLibAddin::Bond::description() {
    // if derived classes didn't take care of description
    if (description_.empty()) {
        std::ostringstream temp;
        temp << "Bond ";
        qlBondObject_ = boost::dynamic_pointer_cast<QuantLib::Bond>(
                                                        libraryObject_);
        temp << QuantLib::io::iso_date(qlBondObject_->maturityDate());
        description_ = temp.str();
    }

    return description_;
}

std::string QuantLibAddin::Bond::currency() {
    return currency_.code();
}

QuantLibAddin::ZeroCouponBond::ZeroCouponBond(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::string& des,
        const QuantLib::Currency& cur,
        QuantLib::Natural settlementDays,
        const QuantLib::Calendar& calendar,
        QuantLib::Real faceAmount,
        const QuantLib::Date& maturityDate,
        QuantLib::BusinessDayConvention paymentConvention,
        QuantLib::Real redemption,
        const QuantLib::Date& issueDate,
        bool permanent)
: Bond(properties, des, cur, permanent)
{
    qlBondObject_ = boost::shared_ptr<QuantLib::ZeroCouponBond>(new
        QuantLib::ZeroCouponBond(settlementDays,
                                 calendar,
                                 faceAmount,
                                 maturityDate,
                                 paymentConvention,
                                 redemption, issueDate));
    libraryObject_ = qlBondObject_;
    if (description_.empty()) {
        std::ostringstream temp;
        temp << "ZeroCouponBond ";
        temp << QuantLib::io::iso_date(qlBondObject_->maturityDate());
        description_ = temp.str();
    }
}

QuantLibAddin::FixedRateBond::FixedRateBond(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::string& des,
        const QuantLib::Currency& cur,
        QuantLib::Natural settlementDays,
        QuantLib::Real faceAmount,
        const boost::shared_ptr<QuantLib::Schedule>& schedule,
        const std::vector<QuantLib::Rate>& coupons,
        const QuantLib::DayCounter& accrualDayCounter,
        QuantLib::BusinessDayConvention paymentConvention,
        QuantLib::Real redemption,
        const QuantLib::Date& issueDate,
        const QuantLib::Calendar& paymentCalendar,
        bool permanent)
: Bond(properties, des, cur, permanent)
{
    qlBondObject_ = boost::shared_ptr<QuantLib::FixedRateBond>(new
        QuantLib::FixedRateBond(settlementDays, faceAmount,
                                *schedule,
                                coupons, accrualDayCounter,
                                paymentConvention,
                                redemption, issueDate,
                                paymentCalendar));
    libraryObject_ = qlBondObject_;
    if (description_.empty()) {
        std::ostringstream temp;
        temp << "FixedRateBond ";
        temp << QuantLib::io::iso_date(qlBondObject_->maturityDate());
        if (coupons.size()==1)
            temp << " " << coupons[0]*100.0 << "%";
        else
            temp << " STEP";
        description_ = temp.str();
    }
}

QuantLibAddin::FixedRateBond::FixedRateBond(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::string& des,
        const QuantLib::Currency& cur,
        QuantLib::Natural settlementDays,
        QuantLib::Real faceAmount,
        const boost::shared_ptr<QuantLib::Schedule>& schedule,
        const std::vector<boost::shared_ptr<QuantLib::InterestRate> >& coupons,
        QuantLib::BusinessDayConvention paymentConvention,
        QuantLib::Real redemption,
        const QuantLib::Date& issueDate,
        const QuantLib::Calendar& paymentCalendar,
        bool permanent)
: Bond(properties, des, cur, permanent)
{
	std::vector<QuantLib::InterestRate> couponRate(coupons.size());

	for (QuantLib::Size i=0; i<coupons.size(); ++i)
		couponRate[i] = *coupons[i];

    qlBondObject_ = boost::shared_ptr<QuantLib::FixedRateBond>(new
        QuantLib::FixedRateBond(settlementDays, faceAmount,
                                *schedule,
                                couponRate,
                                paymentConvention,
								redemption,
                                issueDate,
                                paymentCalendar));
    libraryObject_ = qlBondObject_;
    if (description_.empty()) {
        std::ostringstream temp;
        temp << "FixedRateBond ";
        temp << QuantLib::io::iso_date(qlBondObject_->maturityDate());
        if (couponRate.size()==1)
            temp << " " << coupons[0]->rate()*100.0 << "%";
        else
            temp << " STEP";
        description_ = temp.str();
    }
}

QuantLibAddin::FixedRateBond::FixedRateBond(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::string& des,
        const QuantLib::Currency& cur,
        bool permanent)
: Bond(properties, des, cur, permanent) {}

QuantLibAddin::FloatingRateBond::FloatingRateBond(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::string& des,
        const QuantLib::Currency& cur,
        QuantLib::Natural settlementDays,
        QuantLib::BusinessDayConvention paymentConvention,
        QuantLib::Real faceAmount,
        const boost::shared_ptr<QuantLib::Schedule>& schedule,
        QuantLib::Natural fixingDays,
        bool inArrears,
        const QuantLib::DayCounter& paymentDayCounter,
        const std::vector<QuantLib::Rate>& floors,
        const std::vector<QuantLib::Real>& gearings,
        const boost::shared_ptr<QuantLib::IborIndex>& index,
        const std::vector<QuantLib::Spread>& spreads,
        const std::vector<QuantLib::Rate>& caps,
        QuantLib::Real redemption,
        const QuantLib::Date& issueDate,
        bool permanent)
: Bond(properties, des, cur, permanent)
{
    qlBondObject_ = boost::shared_ptr<QuantLib::FloatingRateBond>(new
        QuantLib::FloatingRateBond(settlementDays, faceAmount, *schedule,
                                   index, paymentDayCounter,
                                   paymentConvention, fixingDays,
                                   gearings, spreads,
                                   caps, floors,
                                   inArrears,
                                   redemption, issueDate));
    libraryObject_ = qlBondObject_;
    if (description_.empty()) {
        std::ostringstream temp;
        temp << "FloatingRateBond ";
        temp << QuantLib::io::iso_date(qlBondObject_->maturityDate());
        temp << " " << index->name();
        if (spreads.size()==1)
            temp << " " << spreads[0]*10000 << "bp";
        else
            temp << " step spread";
        description_ = temp.str();
    }
}

QuantLibAddin::FloatingRateBond::FloatingRateBond(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::string& des,
        const QuantLib::Currency& cur,
        bool permanent)
: Bond(properties, des, cur, permanent) {}

QuantLibAddin::CmsRateBond::CmsRateBond(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const std::string& des,
        const QuantLib::Currency& cur,
        QuantLib::Natural settlementDays,
        QuantLib::BusinessDayConvention paymentConvention,
        QuantLib::Real faceAmount,
        const boost::shared_ptr<QuantLib::Schedule>& schedule,
        QuantLib::Natural fixingDays,
        bool inArrears,
        const QuantLib::DayCounter& paymentDayCounter,
        const std::vector<QuantLib::Rate>& floors,
        const std::vector<QuantLib::Real>& gearings,
        const boost::shared_ptr<QuantLib::SwapIndex>& index,
        const std::vector<QuantLib::Spread>& spreads,
        const std::vector<QuantLib::Rate>& caps,
        QuantLib::Real redemption,
        const QuantLib::Date& issueDate,
        bool permanent)
: Bond(properties, des, cur, permanent)
{
    qlBondObject_ = boost::shared_ptr<QuantLib::CmsRateBond>(new
        QuantLib::CmsRateBond(settlementDays, faceAmount, *schedule,
                              index, paymentDayCounter,
                              paymentConvention, fixingDays,
                              gearings, spreads,
                              caps, floors,
                              inArrears,
                              redemption, issueDate));
    libraryObject_ = qlBondObject_;
    if (description_.empty()) {
        std::ostringstream temp;
        temp << "CmsRateBond ";
        temp << QuantLib::io::iso_date(qlBondObject_->maturityDate());
        temp << " " << index->name();
        if (spreads.size()==1)
            temp << " " << spreads[0]*10000 << "bp";
        else
            temp << " step spread";
        description_ = temp.str();
    }
}

std::vector<std::string> QuantLibAddin::bondAlive(const std::vector<boost::shared_ptr<Bond> >& bonds,
                           QuantLib::Date& refDate)
{
    if (bonds.empty())
        return std::vector<std::string>();

    if (refDate==QuantLib::Date())
        refDate = QuantLib::Settings::instance().evaluationDate();

    std::vector<std::string> result;
    QuantLib::Size n = bonds.size();
    result.reserve(n);

    boost::shared_ptr<QuantLib::Bond> qlBond;
    QuantLib::Date settlement, maturity;
    std::string id;
    for (QuantLib::Size i=0; i<n; ++i) {
        bonds[i]->getLibraryObject(qlBond);
        settlement = qlBond->settlementDate(refDate);
        maturity = qlBond->maturityDate();
        if (settlement<maturity) {
            id = reposit::convert<std::string>(bonds[i]->propertyValue("OBJECTID"));
            result.push_back(id);
        }
    }
    return result;
}

std::string QuantLibAddin::bondMaturityLookup(const std::vector<boost::shared_ptr<Bond> >& bonds,
                            const QuantLib::Date& maturity)
{
    boost::shared_ptr<QuantLib::Bond> qlBond;
    for (QuantLib::Size i=0; i<bonds.size(); ++i) {
        bonds[i]->getLibraryObject(qlBond);
        if (maturity==qlBond->maturityDate())
            return reposit::convert<std::string>(bonds[i]->propertyValue("OBJECTID"));
    }
    // how to return NA() ?
    return std::string();
}

namespace {

    struct BondItem {
        std::string objectID;
        QuantLib::Date maturityDate;
        BondItem(const std::string& _objectID,
                 const QuantLib::Date& _maturityDate)
        : objectID(_objectID),
          maturityDate(_maturityDate) {}
        BondItem() {}
    };

    class BondItemSorter {
      public:
        bool operator()(const BondItem& item1,
                        const BondItem& item2) const
        {
            if (item1.maturityDate>item2.maturityDate)
                return false;
            return true;
        }
    };
}

std::vector<std::string> QuantLibAddin::bondMaturitySort(const std::vector<boost::shared_ptr<Bond> >& bonds)
{
    if (bonds.empty())
        return std::vector<std::string>();
    QuantLib::Size n = bonds.size();

    // create BondItems
    std::vector<BondItem> bondItems(n);
    std::string id;
    QuantLib::Date maturity;
    boost::shared_ptr<QuantLib::Bond> qlBond;
    for (QuantLib::Size i=0; i<n; ++i) {
        bonds[i]->getLibraryObject(qlBond);
        maturity = qlBond->maturityDate() ;
        id = reposit::convert<std::string>(bonds[i]->propertyValue("OBJECTID"));
        bondItems[i] = BondItem(id, maturity);
    }

    // sort BondItems
    std::sort(bondItems.begin(), bondItems.end(), BondItemSorter());

    // fill result
    std::vector<std::string> result(n);
    for (QuantLib::Size i=0; i<n; ++i)
        result[i] = bondItems[i].objectID;
    return result;
}
