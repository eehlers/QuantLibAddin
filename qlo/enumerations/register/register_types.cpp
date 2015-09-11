
/*  
 Copyright (C) 2006, 2007, 2008, 2014, 2015 Ferdinando Ametrano
 Copyright (C) 2007 Marco Bianchetti
 Copyright (C) 2005, 2006, 2007 Eric Ehlers
 Copyright (C) 2006 Giorgio Facchinetti
 Copyright (C) 2006 Chiara Fornarola
 Copyright (C) 2006 Katiuscia Manzoni
 Copyright (C) 2005 Plamen Neykov
 Copyright (C) 2015 Maddalena Zanzi
 
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

// This file was generated automatically by gensrc.py.  If you edit this file
// manually then your changes will be lost the next time gensrc runs.

// This source code file was generated from the following stub:
//      c:/Users/erik/Documents/repos/reposit/quantlib/QuantLibAddin/gensrc/stubs/stub.enum.types

//#if defined(HAVE_CONFIG_H)     // Dynamically created by configure
//    #include <qlo/config.hpp>
//#endif

#include <qlo/qladdindefines.hpp>
//#include <qlo/interpolation.hpp>
//#include <qlo/interpolation2D.hpp>
//#include <qlo/ratehelpers.hpp>
#include <qlo/objmanual_ratehelpers.hpp>
//#include <qlo/piecewiseyieldcurve.hpp>
#include <qlo/yieldtermstructures.hpp>
#include <qlo/indexes/swapindex.hpp>

#include <ql/cashflows/cashflows.hpp>
#include <ql/cashflows/conundrumpricer.hpp>
#include <ql/cashflows/digitalcoupon.hpp>
#include <ql/currencies/all.hpp>
#include <ql/experimental/risk/sensitivityanalysis.hpp>
#include <ql/instruments/asianoption.hpp>
#include <ql/instruments/barrieroption.hpp>
#include <ql/instruments/capfloor.hpp>
#include <ql/instruments/forward.hpp>
#include <ql/instruments/overnightindexedswap.hpp>
#include <ql/instruments/swaption.hpp>
#include <ql/math/interpolations/cubicinterpolation.hpp>
#include <ql/math/matrixutilities/pseudosqrt.hpp>
#include <ql/math/optimization/endcriteria.hpp>
#include <ql/termstructures/volatility/swaption/cmsmarketcalibration.hpp>
#include <ql/time/calendars/all.hpp>
#include <ql/time/daycounters/all.hpp>
#include <ql/prices.hpp>
#include <ql/default.hpp> // RL ADD 2010-07-15
#include <ql/experimental/credit/defaulttype.hpp>

#include <rp/enumerations/typefactory.hpp>

namespace QuantLibAddin {

    void registerEnumeratedTypes() {
    
        {
            reposit::Create<QuantLib::Average::Type> create;
            create.registerType("Arithmetic", new QuantLib::Average::Type(QuantLib::Average::Arithmetic));
            create.registerType("Geometric", new QuantLib::Average::Type(QuantLib::Average::Geometric));
        }

        {
            reposit::Create<QuantLib::Barrier::Type> create;
            create.registerType("DownIn", new QuantLib::Barrier::Type(QuantLib::Barrier::DownIn));
            create.registerType("DownOut", new QuantLib::Barrier::Type(QuantLib::Barrier::DownOut));
            create.registerType("UpIn", new QuantLib::Barrier::Type(QuantLib::Barrier::UpIn));
            create.registerType("UpOut", new QuantLib::Barrier::Type(QuantLib::Barrier::UpOut));
        }

        {
            reposit::Create<QuantLib::BusinessDayConvention> create;
            create.registerType("F", new QuantLib::BusinessDayConvention(QuantLib::Following));
            create.registerType("Following", new QuantLib::BusinessDayConvention(QuantLib::Following));
            create.registerType("HMMF", new QuantLib::BusinessDayConvention(QuantLib::HalfMonthModifiedFollowing));
            create.registerType("Half-Month Modified Following", new QuantLib::BusinessDayConvention(QuantLib::HalfMonthModifiedFollowing));
            create.registerType("Indifferent", new QuantLib::BusinessDayConvention(QuantLib::Unadjusted));
            create.registerType("MF", new QuantLib::BusinessDayConvention(QuantLib::ModifiedFollowing));
            create.registerType("MP", new QuantLib::BusinessDayConvention(QuantLib::ModifiedPreceding));
            create.registerType("Modified Following", new QuantLib::BusinessDayConvention(QuantLib::ModifiedFollowing));
            create.registerType("Modified Preceding", new QuantLib::BusinessDayConvention(QuantLib::ModifiedPreceding));
            create.registerType("N", new QuantLib::BusinessDayConvention(QuantLib::Nearest));
            create.registerType("Nearest", new QuantLib::BusinessDayConvention(QuantLib::Nearest));
            create.registerType("P", new QuantLib::BusinessDayConvention(QuantLib::Preceding));
            create.registerType("Preceding", new QuantLib::BusinessDayConvention(QuantLib::Preceding));
            create.registerType("Unadjusted", new QuantLib::BusinessDayConvention(QuantLib::Unadjusted));
        }

        {
            reposit::Create<QuantLib::Calendar> create;
            create.registerType("Argentina::Merval", new QuantLib::Argentina(QuantLib::Argentina::Merval));
            create.registerType("Australia", new QuantLib::Australia());
            create.registerType("BOVESPA", new QuantLib::Brazil(QuantLib::Brazil::Exchange));
            create.registerType("Bratislava stock exchange", new QuantLib::Slovakia(QuantLib::Slovakia::BSSE));
            create.registerType("Brazil", new QuantLib::Brazil(QuantLib::Brazil::Settlement));
            create.registerType("Brazil::Exchange", new QuantLib::Brazil(QuantLib::Brazil::Exchange));
            create.registerType("Brazil::Settlement", new QuantLib::Brazil(QuantLib::Brazil::Settlement));
            create.registerType("Buenos Aires stock exchange", new QuantLib::Argentina(QuantLib::Argentina::Merval));
            create.registerType("Calendar", new QuantLib::Calendar());
            create.registerType("Canada", new QuantLib::Canada(QuantLib::Canada::Settlement));
            create.registerType("Canada::Settlement", new QuantLib::Canada(QuantLib::Canada::Settlement));
            create.registerType("Canada::TSX", new QuantLib::Canada(QuantLib::Canada::TSX));
            create.registerType("China", new QuantLib::China());
            create.registerType("CzechRepublic::PSE", new QuantLib::CzechRepublic(QuantLib::CzechRepublic::PSE));
            create.registerType("Denmark", new QuantLib::Denmark());
            create.registerType("EUR", new QuantLib::TARGET());
            create.registerType("Eurex", new QuantLib::Germany(QuantLib::Germany::Eurex));
            create.registerType("Finland", new QuantLib::Finland());
            create.registerType("Frankfurt stock exchange", new QuantLib::Germany(QuantLib::Germany::FrankfurtStockExchange));
            create.registerType("GBP", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Exchange));
            create.registerType("German settlement", new QuantLib::Germany(QuantLib::Germany::Settlement));
            create.registerType("Germany::Eurex", new QuantLib::Germany(QuantLib::Germany::Eurex));
            create.registerType("Germany::FrankfurtStockExchange", new QuantLib::Germany(QuantLib::Germany::FrankfurtStockExchange));
            create.registerType("Germany::Settlement", new QuantLib::Germany(QuantLib::Germany::Settlement));
            create.registerType("Germany::Xetra", new QuantLib::Germany(QuantLib::Germany::Xetra));
            create.registerType("Hong Kong stock exchange", new QuantLib::HongKong(QuantLib::HongKong::HKEx));
            create.registerType("HongKong::HKEx", new QuantLib::HongKong(QuantLib::HongKong::HKEx));
            create.registerType("Hungary", new QuantLib::Hungary());
            create.registerType("Iceland stock exchange", new QuantLib::Iceland(QuantLib::Iceland::ICEX));
            create.registerType("Iceland::ICEX", new QuantLib::Iceland(QuantLib::Iceland::ICEX));
            create.registerType("India::NSE", new QuantLib::India(QuantLib::India::NSE));
            create.registerType("Indonesia::BEJ", new QuantLib::Indonesia(QuantLib::Indonesia::BEJ));
            create.registerType("Indonesia::JSX", new QuantLib::Indonesia(QuantLib::Indonesia::JSX));
            create.registerType("Italian settlement", new QuantLib::Italy(QuantLib::Italy::Settlement));
            create.registerType("Italy::Exchange", new QuantLib::Italy(QuantLib::Italy::Exchange));
            create.registerType("Italy::Settlement", new QuantLib::Italy(QuantLib::Italy::Settlement));
            create.registerType("Jakarta stock exchange", new QuantLib::Indonesia(QuantLib::Indonesia::JSX));
            create.registerType("Japan", new QuantLib::Japan());
            create.registerType("LONDON", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Exchange));
            create.registerType("London metals exchange", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Metals));
            create.registerType("London stock exchange", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Exchange));
            create.registerType("Mexican stock exchange", new QuantLib::Mexico(QuantLib::Mexico::BMV));
            create.registerType("Mexico::BMV", new QuantLib::Mexico(QuantLib::Mexico::BMV));
            create.registerType("Milan stock exchange", new QuantLib::Italy(QuantLib::Italy::Exchange));
            create.registerType("National Stock Exchange of India", new QuantLib::India(QuantLib::India::NSE));
            create.registerType("New York stock exchange", new QuantLib::UnitedStates(QuantLib::UnitedStates::NYSE));
            create.registerType("New Zealand", new QuantLib::NewZealand());
            create.registerType("NewZealand", new QuantLib::NewZealand());
            create.registerType("NoCalendar", new QuantLib::Calendar());
            create.registerType("North American Energy Reliability Council", new QuantLib::UnitedStates(QuantLib::UnitedStates::NERC));
            create.registerType("Norway", new QuantLib::Norway());
            create.registerType("Null", new QuantLib::NullCalendar());
            create.registerType("NullCalendar", new QuantLib::NullCalendar());
            create.registerType("Poland", new QuantLib::Poland());
            create.registerType("Prague stock exchange", new QuantLib::CzechRepublic(QuantLib::CzechRepublic::PSE));
            create.registerType("Russia", new QuantLib::Russia());
            create.registerType("Russian settlement", new QuantLib::Russia());
            create.registerType("SaudiArabia::Tadawul", new QuantLib::SaudiArabia(QuantLib::SaudiArabia::Tadawul));
            create.registerType("Shanghai stock exchange", new QuantLib::China());
            create.registerType("Singapore exchange", new QuantLib::Singapore(QuantLib::Singapore::SGX));
            create.registerType("Singapore::SGX", new QuantLib::Singapore(QuantLib::Singapore::SGX));
            create.registerType("Slovakia::BSSE", new QuantLib::Slovakia(QuantLib::Slovakia::BSSE));
            create.registerType("South Africa", new QuantLib::SouthAfrica());
            create.registerType("South-Korea exchange", new QuantLib::SouthKorea(QuantLib::SouthKorea::KRX));
            create.registerType("SouthAfrica", new QuantLib::SouthAfrica());
            create.registerType("SouthKorea::KRX", new QuantLib::SouthKorea(QuantLib::SouthKorea::KRX));
            create.registerType("Sweden", new QuantLib::Sweden());
            create.registerType("Switzerland", new QuantLib::Switzerland());
            create.registerType("TARGET", new QuantLib::TARGET());
            create.registerType("TSX", new QuantLib::Canada(QuantLib::Canada::TSX));
            create.registerType("Tadawul", new QuantLib::SaudiArabia(QuantLib::SaudiArabia::Tadawul));
            create.registerType("Taiwan stock exchange", new QuantLib::Taiwan(QuantLib::Taiwan::TSEC));
            create.registerType("Taiwan::TSEC", new QuantLib::Taiwan(QuantLib::Taiwan::TSEC));
            create.registerType("Turkey", new QuantLib::Turkey());
            create.registerType("UK settlement", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Settlement));
            create.registerType("US government bond market", new QuantLib::UnitedStates(QuantLib::UnitedStates::GovernmentBond));
            create.registerType("US settlement", new QuantLib::UnitedStates(QuantLib::UnitedStates::Settlement));
            create.registerType("Ukraine::USE", new QuantLib::Ukraine(QuantLib::Ukraine::USE));
            create.registerType("Ukrainian stock exchange", new QuantLib::Ukraine(QuantLib::Ukraine::USE));
            create.registerType("UnitedKingdom::Exchange", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Exchange));
            create.registerType("UnitedKingdom::Metals", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Metals));
            create.registerType("UnitedKingdom::Settlement", new QuantLib::UnitedKingdom(QuantLib::UnitedKingdom::Settlement));
            create.registerType("UnitedStates::GovernmentBond", new QuantLib::UnitedStates(QuantLib::UnitedStates::GovernmentBond));
            create.registerType("UnitedStates::NERC", new QuantLib::UnitedStates(QuantLib::UnitedStates::NERC));
            create.registerType("UnitedStates::NYSE", new QuantLib::UnitedStates(QuantLib::UnitedStates::NYSE));
            create.registerType("UnitedStates::Settlement", new QuantLib::UnitedStates(QuantLib::UnitedStates::Settlement));
            create.registerType("WeekendsOnly", new QuantLib::WeekendsOnly());
            create.registerType("Xetra", new QuantLib::Germany(QuantLib::Germany::Xetra));
        }

        {
            reposit::Create<QuantLib::CapFloor::Type> create;
            create.registerType("Cap", new QuantLib::CapFloor::Type(QuantLib::CapFloor::Cap));
            create.registerType("Collar", new QuantLib::CapFloor::Type(QuantLib::CapFloor::Collar));
            create.registerType("Floor", new QuantLib::CapFloor::Type(QuantLib::CapFloor::Floor));
        }

        {
            reposit::Create<QuantLib::CmsMarketCalibration::CalibrationType> create;
            create.registerType("OnForwardPrice", new QuantLib::CmsMarketCalibration::CalibrationType(QuantLib::CmsMarketCalibration::OnForwardCmsPrice));
            create.registerType("OnPrice", new QuantLib::CmsMarketCalibration::CalibrationType(QuantLib::CmsMarketCalibration::OnPrice));
            create.registerType("OnSpread", new QuantLib::CmsMarketCalibration::CalibrationType(QuantLib::CmsMarketCalibration::OnSpread));
        }

        {
            reposit::Create<QuantLib::Compounding> create;
            create.registerType("Compounded", new QuantLib::Compounding(QuantLib::Compounded));
            create.registerType("Continuous", new QuantLib::Compounding(QuantLib::Continuous));
            create.registerType("Simple", new QuantLib::Compounding(QuantLib::Simple));
            create.registerType("SimpleThenCompounded", new QuantLib::Compounding(QuantLib::SimpleThenCompounded));
        }

        {
            reposit::Create<QuantLib::CubicInterpolation::BoundaryCondition> create;
            create.registerType("FirstDerivative", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::FirstDerivative));
            create.registerType("Lagrange", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::Lagrange));
            create.registerType("NotAKnot", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::NotAKnot));
            create.registerType("Periodic", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::Periodic));
            create.registerType("SecondDerivative", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::SecondDerivative));
        }

        {
            reposit::Create<QuantLib::CubicInterpolation::DerivativeApprox> create;
            create.registerType("Akima", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::Akima));
            create.registerType("FourthOrder", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::FourthOrder));
            create.registerType("FritschButland", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::FritschButland));
            create.registerType("Kruger", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::Kruger));
            create.registerType("Parabolic", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::Parabolic));
            create.registerType("Spline", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::Spline));
        }

        {
            reposit::Create<QuantLib::Currency> create;
            create.registerType("ARS", new QuantLib::ARSCurrency());
            create.registerType("ATS", new QuantLib::ATSCurrency());
            create.registerType("AUD", new QuantLib::AUDCurrency());
            create.registerType("BDT", new QuantLib::BDTCurrency());
            create.registerType("BEF", new QuantLib::BEFCurrency());
            create.registerType("BGL", new QuantLib::BGLCurrency());
            create.registerType("BRL", new QuantLib::BRLCurrency());
            create.registerType("BYR", new QuantLib::BYRCurrency());
            create.registerType("CAD", new QuantLib::CADCurrency());
            create.registerType("CHF", new QuantLib::CHFCurrency());
            create.registerType("CLP", new QuantLib::CLPCurrency());
            create.registerType("CNY", new QuantLib::CNYCurrency());
            create.registerType("COP", new QuantLib::COPCurrency());
            create.registerType("CYP", new QuantLib::CYPCurrency());
            create.registerType("CZK", new QuantLib::CZKCurrency());
            create.registerType("Currency", new QuantLib::Currency());
            create.registerType("DEM", new QuantLib::DEMCurrency());
            create.registerType("DKK", new QuantLib::DKKCurrency());
            create.registerType("EEK", new QuantLib::EEKCurrency());
            create.registerType("ESP", new QuantLib::ESPCurrency());
            create.registerType("EUR", new QuantLib::EURCurrency());
            create.registerType("FIM", new QuantLib::FIMCurrency());
            create.registerType("FRF", new QuantLib::FRFCurrency());
            create.registerType("GBP", new QuantLib::GBPCurrency());
            create.registerType("GRD", new QuantLib::GRDCurrency());
            create.registerType("HKD", new QuantLib::HKDCurrency());
            create.registerType("HUF", new QuantLib::HUFCurrency());
            create.registerType("IDR", new QuantLib::IDRCurrency());
            create.registerType("IEP", new QuantLib::IEPCurrency());
            create.registerType("ILS", new QuantLib::ILSCurrency());
            create.registerType("INR", new QuantLib::INRCurrency());
            create.registerType("IQD", new QuantLib::IQDCurrency());
            create.registerType("IRR", new QuantLib::IRRCurrency());
            create.registerType("ISK", new QuantLib::ISKCurrency());
            create.registerType("ITL", new QuantLib::ITLCurrency());
            create.registerType("JPY", new QuantLib::JPYCurrency());
            create.registerType("KRW", new QuantLib::KRWCurrency());
            create.registerType("KWD", new QuantLib::KWDCurrency());
            create.registerType("LTL", new QuantLib::LTLCurrency());
            create.registerType("LUF", new QuantLib::LUFCurrency());
            create.registerType("LVL", new QuantLib::LVLCurrency());
            create.registerType("MTL", new QuantLib::MTLCurrency());
            create.registerType("MXN", new QuantLib::MXNCurrency());
            create.registerType("MYR", new QuantLib::MYRCurrency());
            create.registerType("NLG", new QuantLib::NLGCurrency());
            create.registerType("NOK", new QuantLib::NOKCurrency());
            create.registerType("NPR", new QuantLib::NPRCurrency());
            create.registerType("NZD", new QuantLib::NZDCurrency());
            create.registerType("NoCurrency", new QuantLib::Currency());
            create.registerType("PEH", new QuantLib::PEHCurrency());
            create.registerType("PEI", new QuantLib::PEICurrency());
            create.registerType("PEN", new QuantLib::PENCurrency());
            create.registerType("PKR", new QuantLib::PKRCurrency());
            create.registerType("PLN", new QuantLib::PLNCurrency());
            create.registerType("PTE", new QuantLib::PTECurrency());
            create.registerType("ROL", new QuantLib::ROLCurrency());
            create.registerType("RON", new QuantLib::RONCurrency());
            create.registerType("RUB", new QuantLib::RUBCurrency());
            create.registerType("SAR", new QuantLib::SARCurrency());
            create.registerType("SEK", new QuantLib::SEKCurrency());
            create.registerType("SGD", new QuantLib::SGDCurrency());
            create.registerType("SIT", new QuantLib::SITCurrency());
            create.registerType("SKK", new QuantLib::SKKCurrency());
            create.registerType("THB", new QuantLib::THBCurrency());
            create.registerType("TRL", new QuantLib::TRLCurrency());
            create.registerType("TRY", new QuantLib::TRYCurrency());
            create.registerType("TTD", new QuantLib::TTDCurrency());
            create.registerType("TWD", new QuantLib::TWDCurrency());
            create.registerType("USD", new QuantLib::USDCurrency());
            create.registerType("VEB", new QuantLib::VEBCurrency());
            create.registerType("VND", new QuantLib::VNDCurrency());
            create.registerType("ZAR", new QuantLib::ZARCurrency());
        }

        {
            reposit::Create<QuantLib::DateGeneration::Rule> create;
            create.registerType("Backward", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Backward));
            create.registerType("CDS", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::CDS));
            create.registerType("Forward", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Forward));
            create.registerType("OldCDS", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::OldCDS));
            create.registerType("ThirdWednesday", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::ThirdWednesday));
            create.registerType("Twentieth", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Twentieth));
            create.registerType("TwentiethIMM", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::TwentiethIMM));
            create.registerType("Zero", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Zero));
        }

        {
            reposit::Create<QuantLib::DayCounter> create;
            create.registerType("1/1", new QuantLib::OneDayCounter());
            create.registerType("30/360", new QuantLib::Thirty360(QuantLib::Thirty360::BondBasis));
            create.registerType("30/360 (Bond Basis)", new QuantLib::Thirty360(QuantLib::Thirty360::BondBasis));
            create.registerType("30/360 (Eurobond Basis)", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
            create.registerType("30/360 (Italian)", new QuantLib::Thirty360(QuantLib::Thirty360::Italian));
            create.registerType("30E/360", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
            create.registerType("30E/360 (Eurobond Basis)", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
            create.registerType("360/360", new QuantLib::Thirty360(QuantLib::Thirty360::BondBasis));
            create.registerType("A/360", new QuantLib::Actual360());
            create.registerType("A/365", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
            create.registerType("A/365 (Fixed)", new QuantLib::Actual365Fixed());
            create.registerType("A/365F", new QuantLib::Actual365Fixed());
            create.registerType("Act/360", new QuantLib::Actual360());
            create.registerType("Act/365", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
            create.registerType("Act/365 (Fixed)", new QuantLib::Actual365Fixed());
            create.registerType("Act/365 (NL)", new QuantLib::Actual365NoLeap());
            create.registerType("Act/Act", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
            create.registerType("Actual/360", new QuantLib::Actual360());
            create.registerType("Actual/365", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
            create.registerType("Actual/365 (Fixed)", new QuantLib::Actual365Fixed());
            create.registerType("Actual/365 (JGB)", new QuantLib::Actual365NoLeap());
            create.registerType("Actual/365 (No Leap)", new QuantLib::Actual365NoLeap());
            create.registerType("Actual/Actual", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
            create.registerType("Actual/Actual (AFB)", new QuantLib::ActualActual(QuantLib::ActualActual::AFB));
            create.registerType("Actual/Actual (Bond)", new QuantLib::ActualActual(QuantLib::ActualActual::ISMA));
            create.registerType("Actual/Actual (Euro)", new QuantLib::ActualActual(QuantLib::ActualActual::AFB));
            create.registerType("Actual/Actual (ISDA)", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
            create.registerType("Actual/Actual (ISMA)", new QuantLib::ActualActual(QuantLib::ActualActual::ISMA));
            create.registerType("Bond Basis", new QuantLib::Thirty360(QuantLib::Thirty360::BondBasis));
            create.registerType("Business252", new QuantLib::Business252());
            create.registerType("DayCounter", new QuantLib::DayCounter());
            create.registerType("Eurobond Basis", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
            create.registerType("LIN 30/360", new QuantLib::Thirty360(QuantLib::Thirty360::EurobondBasis));
            create.registerType("LIN ACT/360", new QuantLib::Actual360());
            create.registerType("LIN ACT/365", new QuantLib::Actual365Fixed());
            create.registerType("LIN ACT/ACT", new QuantLib::ActualActual(QuantLib::ActualActual::AFB));
            create.registerType("LIN ACTACT ISDA", new QuantLib::ActualActual(QuantLib::ActualActual::ISDA));
            create.registerType("LIN ACTACT ISMA", new QuantLib::ActualActual(QuantLib::ActualActual::ISMA));
            create.registerType("NL/365", new QuantLib::Actual365NoLeap());
            create.registerType("NoDayCounter", new QuantLib::DayCounter());
            create.registerType("Simple", new QuantLib::SimpleDayCounter());
        }

        {
            reposit::Create<QuantLib::Duration::Type> create;
            create.registerType("Macaulay", new QuantLib::Duration::Type(QuantLib::Duration::Macaulay));
            create.registerType("Modified", new QuantLib::Duration::Type(QuantLib::Duration::Modified));
            create.registerType("Simple", new QuantLib::Duration::Type(QuantLib::Duration::Simple));
        }

        {
            reposit::Create<QuantLib::EndCriteria::Type> create;
            create.registerType("MaxIterations", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::MaxIterations));
            create.registerType("None", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::None));
            create.registerType("StationaryFunctionAccuracy", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::StationaryFunctionAccuracy));
            create.registerType("StationaryFunctionValue", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::StationaryFunctionValue));
            create.registerType("StationaryPoint", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::StationaryPoint));
            create.registerType("Unknown", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::Unknown));
            create.registerType("ZeroGradientNorm", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::ZeroGradientNorm));
        }

        {
            reposit::Create<QuantLib::Frequency> create;
            create.registerType("Annual", new QuantLib::Frequency(QuantLib::Annual));
            create.registerType("Bimonthly", new QuantLib::Frequency(QuantLib::Bimonthly));
            create.registerType("Biweekly", new QuantLib::Frequency(QuantLib::Biweekly));
            create.registerType("Daily", new QuantLib::Frequency(QuantLib::Daily));
            create.registerType("EveryFourthMonth", new QuantLib::Frequency(QuantLib::EveryFourthMonth));
            create.registerType("EveryFourthWeek", new QuantLib::Frequency(QuantLib::EveryFourthWeek));
            create.registerType("Frequency", new QuantLib::Frequency(QuantLib::NoFrequency));
            create.registerType("Monthly", new QuantLib::Frequency(QuantLib::Monthly));
            create.registerType("NoFrequency", new QuantLib::Frequency(QuantLib::NoFrequency));
            create.registerType("Once", new QuantLib::Frequency(QuantLib::Once));
            create.registerType("OtherFrequency", new QuantLib::Frequency(QuantLib::OtherFrequency));
            create.registerType("Quarterly", new QuantLib::Frequency(QuantLib::Quarterly));
            create.registerType("Semiannual", new QuantLib::Frequency(QuantLib::Semiannual));
            create.registerType("Weekly", new QuantLib::Frequency(QuantLib::Weekly));
        }

        {
            reposit::Create<QuantLib::Futures::Type> create;
            create.registerType("ASX", new QuantLib::Futures::Type(QuantLib::Futures::ASX));
            create.registerType("IMM", new QuantLib::Futures::Type(QuantLib::Futures::IMM));
        }

        {
            reposit::Create<QuantLib::GFunctionFactory::YieldCurveModel> create;
            create.registerType("ExactYield", new QuantLib::GFunctionFactory::YieldCurveModel(QuantLib::GFunctionFactory::ExactYield));
            create.registerType("NonParallelShifts", new QuantLib::GFunctionFactory::YieldCurveModel(QuantLib::GFunctionFactory::NonParallelShifts));
            create.registerType("ParallelShifts", new QuantLib::GFunctionFactory::YieldCurveModel(QuantLib::GFunctionFactory::ParallelShifts));
            create.registerType("Standard", new QuantLib::GFunctionFactory::YieldCurveModel(QuantLib::GFunctionFactory::Standard));
        }

        {
            reposit::Create<QuantLib::Month> create;
            create.registerType("1", new QuantLib::Month(QuantLib::January));
            create.registerType("10", new QuantLib::Month(QuantLib::October));
            create.registerType("11", new QuantLib::Month(QuantLib::November));
            create.registerType("12", new QuantLib::Month(QuantLib::December));
            create.registerType("2", new QuantLib::Month(QuantLib::February));
            create.registerType("3", new QuantLib::Month(QuantLib::March));
            create.registerType("4", new QuantLib::Month(QuantLib::April));
            create.registerType("5", new QuantLib::Month(QuantLib::May));
            create.registerType("6", new QuantLib::Month(QuantLib::June));
            create.registerType("7", new QuantLib::Month(QuantLib::July));
            create.registerType("8", new QuantLib::Month(QuantLib::August));
            create.registerType("9", new QuantLib::Month(QuantLib::September));
            create.registerType("Apr", new QuantLib::Month(QuantLib::Apr));
            create.registerType("April", new QuantLib::Month(QuantLib::April));
            create.registerType("Aug", new QuantLib::Month(QuantLib::Aug));
            create.registerType("August", new QuantLib::Month(QuantLib::August));
            create.registerType("Dec", new QuantLib::Month(QuantLib::Dec));
            create.registerType("December", new QuantLib::Month(QuantLib::December));
            create.registerType("Feb", new QuantLib::Month(QuantLib::Feb));
            create.registerType("February", new QuantLib::Month(QuantLib::February));
            create.registerType("Jan", new QuantLib::Month(QuantLib::Jan));
            create.registerType("January", new QuantLib::Month(QuantLib::January));
            create.registerType("Jul", new QuantLib::Month(QuantLib::Jul));
            create.registerType("July", new QuantLib::Month(QuantLib::July));
            create.registerType("Jun", new QuantLib::Month(QuantLib::Jun));
            create.registerType("June", new QuantLib::Month(QuantLib::June));
            create.registerType("Mar", new QuantLib::Month(QuantLib::Mar));
            create.registerType("March", new QuantLib::Month(QuantLib::March));
            create.registerType("May", new QuantLib::Month(QuantLib::May));
            create.registerType("Nov", new QuantLib::Month(QuantLib::Nov));
            create.registerType("November", new QuantLib::Month(QuantLib::November));
            create.registerType("Oct", new QuantLib::Month(QuantLib::Oct));
            create.registerType("October", new QuantLib::Month(QuantLib::October));
            create.registerType("Sep", new QuantLib::Month(QuantLib::Sep));
            create.registerType("September", new QuantLib::Month(QuantLib::September));
        }

        {
            reposit::Create<QuantLib::Option::Type> create;
            create.registerType("Call", new QuantLib::Option::Type(QuantLib::Option::Call));
            create.registerType("Put", new QuantLib::Option::Type(QuantLib::Option::Put));
        }

        {
            reposit::Create<QuantLib::OvernightIndexedSwap::Type> create;
            create.registerType("Payer", new QuantLib::OvernightIndexedSwap::Type(QuantLib::OvernightIndexedSwap::Payer));
            create.registerType("Receiver", new QuantLib::OvernightIndexedSwap::Type(QuantLib::OvernightIndexedSwap::Receiver));
        }

        {
            reposit::Create<QuantLib::Position::Type> create;
            create.registerType("Long", new QuantLib::Position::Type(QuantLib::Position::Long));
            create.registerType("Short", new QuantLib::Position::Type(QuantLib::Position::Short));
        }

        {
            reposit::Create<QuantLib::PriceType> create;
            create.registerType("Ask", new QuantLib::PriceType(QuantLib::Ask));
            create.registerType("Bid", new QuantLib::PriceType(QuantLib::Bid));
            create.registerType("Close", new QuantLib::PriceType(QuantLib::Close));
            create.registerType("Last", new QuantLib::PriceType(QuantLib::Last));
            create.registerType("Mid", new QuantLib::PriceType(QuantLib::Mid));
            create.registerType("Mid Equivalent", new QuantLib::PriceType(QuantLib::MidEquivalent));
            create.registerType("Mid Safe", new QuantLib::PriceType(QuantLib::MidSafe));
        }

        {
            reposit::Create<QuantLib::Protection::Side> create;
            create.registerType("Buyer", new QuantLib::Protection::Side(QuantLib::Protection::Buyer));
            create.registerType("Seller", new QuantLib::Protection::Side(QuantLib::Protection::Seller));
        }

        {
            reposit::Create<QuantLib::Replication::Type> create;
            create.registerType("Central", new QuantLib::Replication::Type(QuantLib::Replication::Central));
            create.registerType("Sub", new QuantLib::Replication::Type(QuantLib::Replication::Sub));
            create.registerType("Super", new QuantLib::Replication::Type(QuantLib::Replication::Super));
        }

        {
            reposit::Create<QuantLib::SalvagingAlgorithm::Type> create;
            create.registerType("Higham", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::Higham));
            create.registerType("Hypersphere", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::Hypersphere));
            create.registerType("LowerDiagonal", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::LowerDiagonal));
            create.registerType("None", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::None));
            create.registerType("Spectral", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::Spectral));
        }

        {
            reposit::Create<QuantLib::Seniority> create;
            create.registerType("NoSeniority", new QuantLib::Seniority(QuantLib::NoSeniority));
            create.registerType("SeniorSec", new QuantLib::Seniority(QuantLib::SeniorSec));
            create.registerType("SeniorUnSec", new QuantLib::Seniority(QuantLib::SeniorUnSec));
            create.registerType("SubLoweTier2", new QuantLib::Seniority(QuantLib::SubLoweTier2));
            create.registerType("SubTier1", new QuantLib::Seniority(QuantLib::SubTier1));
            create.registerType("SubUpperTier2", new QuantLib::Seniority(QuantLib::SubUpperTier2));
        }

        {
            reposit::Create<QuantLib::SensitivityAnalysis> create;
            create.registerType("Centered", new QuantLib::SensitivityAnalysis(QuantLib::Centered));
            create.registerType("OneSide", new QuantLib::SensitivityAnalysis(QuantLib::OneSide));
        }

        {
            reposit::Create<QuantLib::Settlement::Type> create;
            create.registerType("Cash", new QuantLib::Settlement::Type(QuantLib::Settlement::Cash));
            create.registerType("Physical", new QuantLib::Settlement::Type(QuantLib::Settlement::Physical));
        }

        {
            reposit::Create<QuantLib::TimeUnit> create;
            create.registerType("Days", new QuantLib::TimeUnit(QuantLib::Days));
            create.registerType("Months", new QuantLib::TimeUnit(QuantLib::Months));
            create.registerType("Weeks", new QuantLib::TimeUnit(QuantLib::Weeks));
            create.registerType("Years", new QuantLib::TimeUnit(QuantLib::Years));
        }

        {
            reposit::Create<QuantLib::VanillaSwap::Type> create;
            create.registerType("Payer", new QuantLib::VanillaSwap::Type(QuantLib::VanillaSwap::Payer));
            create.registerType("Receiver", new QuantLib::VanillaSwap::Type(QuantLib::VanillaSwap::Receiver));
        }

        {
            reposit::Create<QuantLib::Weekday> create;
            create.registerType("Fri", new QuantLib::Weekday(QuantLib::Fri));
            create.registerType("Friday", new QuantLib::Weekday(QuantLib::Friday));
            create.registerType("Mon", new QuantLib::Weekday(QuantLib::Mon));
            create.registerType("Monday", new QuantLib::Weekday(QuantLib::Monday));
            create.registerType("Sat", new QuantLib::Weekday(QuantLib::Sat));
            create.registerType("Saturday", new QuantLib::Weekday(QuantLib::Saturday));
            create.registerType("Sun", new QuantLib::Weekday(QuantLib::Sun));
            create.registerType("Sunday", new QuantLib::Weekday(QuantLib::Sunday));
            create.registerType("Thu", new QuantLib::Weekday(QuantLib::Thu));
            create.registerType("Thursday", new QuantLib::Weekday(QuantLib::Thursday));
            create.registerType("Tue", new QuantLib::Weekday(QuantLib::Tue));
            create.registerType("Tuesday", new QuantLib::Weekday(QuantLib::Tuesday));
            create.registerType("Wed", new QuantLib::Weekday(QuantLib::Wed));
            create.registerType("Wednesday", new QuantLib::Weekday(QuantLib::Wednesday));
        }

        {
            reposit::Create<QuantLibAddin::InterpolatedYieldCurve::Interpolator> create;
            create.registerType("BackwardFlat", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::BackwardFlat));
            create.registerType("CubicNaturalSpline", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::CubicNaturalSpline));
            create.registerType("ForwardFlat", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::ForwardFlat));
            create.registerType("FritschButlandCubic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::FritschButlandCubic));
            create.registerType("FritschButlandLogCubic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::FritschButlandLogCubic));
            create.registerType("KrugerCubic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::KrugerCubic));
            create.registerType("KrugerLogCubic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::KrugerLogCubic));
            create.registerType("Linear", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::Linear));
            create.registerType("LogCubicNaturalSpline", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::LogCubicNaturalSpline));
            create.registerType("LogLinear", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::LogLinear));
            create.registerType("LogParabolic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::LogParabolic));
            create.registerType("MonotonicCubicNaturalSpline", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::MonotonicCubicNaturalSpline));
            create.registerType("MonotonicLogCubicNaturalSpline", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::MonotonicLogCubicNaturalSpline));
            create.registerType("MonotonicLogParabolic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::MonotonicLogParabolic));
            create.registerType("MonotonicParabolic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::MonotonicParabolic));
            create.registerType("Parabolic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::Parabolic));
        }

        {
            reposit::Create<QuantLibAddin::InterpolatedYieldCurve::Traits> create;
            create.registerType("Discount", new QuantLibAddin::InterpolatedYieldCurve::Traits(QuantLibAddin::InterpolatedYieldCurve::Discount));
            create.registerType("ForwardRate", new QuantLibAddin::InterpolatedYieldCurve::Traits(QuantLibAddin::InterpolatedYieldCurve::ForwardRate));
            create.registerType("ZeroYield", new QuantLibAddin::InterpolatedYieldCurve::Traits(QuantLibAddin::InterpolatedYieldCurve::ZeroYield));
        }

        {
            reposit::Create<QuantLibAddin::RateHelper::DepoInclusionCriteria> create;
            create.registerType("AllDepos", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::AllDepos));
            create.registerType("DeposBeforeFirstFuturesExpiryDate", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesExpiryDate));
            create.registerType("DeposBeforeFirstFuturesStartDate", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesStartDate));
            create.registerType("DeposBeforeFirstFuturesStartDatePlusOne", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesStartDatePlusOne));
        }

        {
            reposit::Create<QuantLibAddin::SwapIndex::FixingType> create;
            create.registerType("IfrFix", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IfrFix));
            create.registerType("Isda", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::Isda));
            create.registerType("IsdaFixA", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IsdaFixA));
            create.registerType("IsdaFixAm", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IsdaFixAm));
            create.registerType("IsdaFixB", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IsdaFixB));
            create.registerType("IsdaFixPm", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IsdaFixPm));
        }

    }

    void unregisterEnumeratedTypes() {
    
        reposit::Create<QuantLib::Average::Type>().unregisterTypes();
        reposit::Create<QuantLib::Barrier::Type>().unregisterTypes();
        reposit::Create<QuantLib::BusinessDayConvention>().unregisterTypes();
        reposit::Create<QuantLib::Calendar>().unregisterTypes();
        reposit::Create<QuantLib::CapFloor::Type>().unregisterTypes();
        reposit::Create<QuantLib::CmsMarketCalibration::CalibrationType>().unregisterTypes();
        reposit::Create<QuantLib::Compounding>().unregisterTypes();
        reposit::Create<QuantLib::CubicInterpolation::BoundaryCondition>().unregisterTypes();
        reposit::Create<QuantLib::CubicInterpolation::DerivativeApprox>().unregisterTypes();
        reposit::Create<QuantLib::Currency>().unregisterTypes();
        reposit::Create<QuantLib::DateGeneration::Rule>().unregisterTypes();
        reposit::Create<QuantLib::DayCounter>().unregisterTypes();
        reposit::Create<QuantLib::Duration::Type>().unregisterTypes();
        reposit::Create<QuantLib::EndCriteria::Type>().unregisterTypes();
        reposit::Create<QuantLib::Frequency>().unregisterTypes();
        reposit::Create<QuantLib::Futures::Type>().unregisterTypes();
        reposit::Create<QuantLib::GFunctionFactory::YieldCurveModel>().unregisterTypes();
        reposit::Create<QuantLib::Month>().unregisterTypes();
        reposit::Create<QuantLib::Option::Type>().unregisterTypes();
        reposit::Create<QuantLib::OvernightIndexedSwap::Type>().unregisterTypes();
        reposit::Create<QuantLib::Position::Type>().unregisterTypes();
        reposit::Create<QuantLib::PriceType>().unregisterTypes();
        reposit::Create<QuantLib::Protection::Side>().unregisterTypes();
        reposit::Create<QuantLib::Replication::Type>().unregisterTypes();
        reposit::Create<QuantLib::SalvagingAlgorithm::Type>().unregisterTypes();
        reposit::Create<QuantLib::Seniority>().unregisterTypes();
        reposit::Create<QuantLib::SensitivityAnalysis>().unregisterTypes();
        reposit::Create<QuantLib::Settlement::Type>().unregisterTypes();
        reposit::Create<QuantLib::TimeUnit>().unregisterTypes();
        reposit::Create<QuantLib::VanillaSwap::Type>().unregisterTypes();
        reposit::Create<QuantLib::Weekday>().unregisterTypes();
        reposit::Create<QuantLibAddin::InterpolatedYieldCurve::Interpolator>().unregisterTypes();
        reposit::Create<QuantLibAddin::InterpolatedYieldCurve::Traits>().unregisterTypes();
        reposit::Create<QuantLibAddin::RateHelper::DepoInclusionCriteria>().unregisterTypes();
        //reposit::Create<QuantLibAddin::SwapIndex::FixingType>().unregisterTypes();
    }

}

