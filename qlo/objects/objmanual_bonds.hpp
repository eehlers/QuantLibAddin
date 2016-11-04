/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2007 Chiara Fornarola
 Copyright (C) 2006, 2007, 2008, 2009, 2010, 2011 Ferdinando Ametrano
 Copyright (C) 2005, 2006 Eric Ehlers
 Copyright (C) 2005 Plamen Neykov
 Copyright (C) 2005 Walter Penschke
 Copyright (C) 2009 Piter Dias
 Copyright (C) 2016 Eric Ehlers

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

#ifndef qla_bonds_hpp
#define qla_bonds_hpp

//#include <qlo/objects/obj_instruments.hpp>
//#include <qlo/leg.hpp>

#include <ql/currency.hpp>
#include <ql/instruments/bond.hpp>
#include <ql/cashflow.hpp>

#include <string>

namespace QuantLib {
    class FloatingRateCouponPricer;
    class SwapIndex;
    class IborIndex;
    class Schedule;
    class Calendar;
    class Date;
    class DayCounter;
    //class YieldTermStructure;
}

namespace QuantLibAddin {

    class Bond : public /*Instrument*/reposit::LibraryObject<QuantLib::Instrument> {
      public:
        const std::string& description();
        std::string currency() { return currency_.code(); }
        //QuantLib::Currency currency();
        QuantLib::Real redemptionAmount();
        QuantLib::Date redemptionDate();
        void setCouponPricer(
            const boost::shared_ptr<QuantLib::FloatingRateCouponPricer>&);
        void setCouponPricers(
            const std::vector<boost::shared_ptr<QuantLib::FloatingRateCouponPricer> >&);
        std::vector<std::vector<reposit::property_t> > flowAnalysis(
                                                    const QuantLib::Date& d);
        Bond(const boost::shared_ptr<reposit::ValueObject>& properties,
             const std::string& description,
             const QuantLib::Currency& currency,
             QuantLib::Natural settlementDays,
             const QuantLib::Calendar& calendar,
             QuantLib::Real faceAmount,
             const QuantLib::Date& maturityDate,
             const QuantLib::Date& issueDate,
             const QuantLib::Leg& leg,
             bool permanent);
      protected:
        Bond(const boost::shared_ptr<reposit::ValueObject>& properties,
             const std::string& description,
             const QuantLib::Currency& currency,
             bool permanent);
        std::string description_;
        QuantLib::Currency currency_;
        boost::shared_ptr<QuantLib::Bond> qlBondObject_;
    };

    class ZeroCouponBond : public Bond {
      public:
        ZeroCouponBond(
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
            bool permanent);
    };

    class FixedRateBond : public Bond {
      public:
        FixedRateBond(
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
            bool permanent);
        FixedRateBond(
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
            bool permanent);
      protected:
        FixedRateBond(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const std::string& description,
            const QuantLib::Currency& currency,
            bool permanent);
    };

    class FloatingRateBond : public Bond {
      public:
        FloatingRateBond(
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
            bool permanent);
        // add constructor without schedule
      protected:
        FloatingRateBond(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const std::string& description,
            const QuantLib::Currency& currency,
            bool permanent);
    };

    class CmsRateBond : public Bond {
      public:
        CmsRateBond(
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
            bool permanent);
        // add constructor without schedule
    };

    std::vector<std::string> bondAlive(
                        const std::vector<boost::shared_ptr<Bond> >& bonds,
                        QuantLib::Date& refDate);

    std::string bondMaturityLookup(
                        const std::vector<boost::shared_ptr<Bond> >& bonds,
                        const QuantLib::Date& maturity);

    std::vector<std::string> bondMaturitySort(
                        const std::vector<boost::shared_ptr<Bond> >& bonds);

}

#endif
