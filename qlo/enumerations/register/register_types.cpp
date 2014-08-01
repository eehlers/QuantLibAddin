//
/*  
 Copyright (C) 2006, 2007, 2008, 2014 Ferdinando Ametrano
 Copyright (C) 2005, 2006, 2007, 2014 Eric Ehlers
 Copyright (C) 2007 Marco Bianchetti
 Copyright (C) 2006 Giorgio Facchinetti
 Copyright (C) 2006 Chiara Fornarola
 Copyright (C) 2006 Katiuscia Manzoni
 Copyright (C) 2005 Plamen Neykov
 
 This file is part of QuantLib, a free-software/open-source library
 for financial quantitative analysts and developers - http://quantlib.org/
//
 QuantLib is free software: you can redistribute it and/or modify it
 under the terms of the QuantLib license.  You should have received a
 copy of the license along with this program; if not, please email
 <quantlib-dev@lists.sf.net>. The license is also available online at
 <http://quantlib.org/license.shtml>.
//
 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
*/
//
//#if defined(HAVE_CONFIG_H)     // Dynamically created by configure
//    #include <qlo/config.hpp>
//#endif
//
//#include <qlo/qladdindefines.hpp>
//#include <qlo/interpolation.hpp>
//#include <qlo/interpolation2D.hpp>
//#include <qlo/ratehelpers.hpp>
//#include <qlo/piecewiseyieldcurve.hpp>
//#include <qlo/indexes/swapindex.hpp>
//
//#include <ql/cashflows/cashflows.hpp>
//#include <ql/cashflows/conundrumpricer.hpp>
//#include <ql/cashflows/digitalcoupon.hpp>
//#include <ql/currencies/all.hpp>
//#include <ql/experimental/risk/sensitivityanalysis.hpp>
//#include <ql/option.hpp>
//#include <ql/instruments/asianoption.hpp>
//#include <ql/instruments/barrieroption.hpp>
//#include <ql/instruments/capfloor.hpp>
//#include <ql/instruments/forward.hpp>
//#include <ql/instruments/overnightindexedswap.hpp>
//#include <ql/instruments/swaption.hpp>
//#include <ql/math/interpolations/cubicinterpolation.hpp>
//#include <ql/math/matrixutilities/pseudosqrt.hpp>
//#include <ql/math/optimization/endcriteria.hpp>
//#include <ql/termstructures/volatility/swaption/cmsmarketcalibration.hpp>
//#include <ql/time/calendars/all.hpp>
//#include <ql/time/daycounters/all.hpp>
//#include <ql/prices.hpp>
//#include <ql/default.hpp> // RL ADD 2010-07-15
//
//#include <oh/enumerations/typefactory.hpp>
//#include <qlo/enumerations/register/register_types.hpp>
//
//namespace QuantLibAddin {
//
//    void registerEnumeratedTypes() {
//
//        {
//            ObjectHandler::Create<QuantLib::Average::Type> create;
//            create.registerType("Arithmetic", new QuantLib::Average::Type(QuantLib::Average::Arithmetic));
//            create.registerType("Geometric", new QuantLib::Average::Type(QuantLib::Average::Geometric));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Barrier::Type> create;
//            create.registerType("DownIn", new QuantLib::Barrier::Type(QuantLib::Barrier::DownIn));
//            create.registerType("DownOut", new QuantLib::Barrier::Type(QuantLib::Barrier::DownOut));
//            create.registerType("UpIn", new QuantLib::Barrier::Type(QuantLib::Barrier::UpIn));
//            create.registerType("UpOut", new QuantLib::Barrier::Type(QuantLib::Barrier::UpOut));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::BusinessDayConvention> create;
//            create.registerType("F", new QuantLib::BusinessDayConvention(QuantLib::Following));
//            create.registerType("Following", new QuantLib::BusinessDayConvention(QuantLib::Following));
//            create.registerType("HMMF", new QuantLib::BusinessDayConvention(QuantLib::HalfMonthModifiedFollowing));
//            create.registerType("Half-Month Modified Following", new QuantLib::BusinessDayConvention(QuantLib::HalfMonthModifiedFollowing));
//            create.registerType("Indifferent", new QuantLib::BusinessDayConvention(QuantLib::Unadjusted));
//            create.registerType("MF", new QuantLib::BusinessDayConvention(QuantLib::ModifiedFollowing));
//            create.registerType("MP", new QuantLib::BusinessDayConvention(QuantLib::ModifiedPreceding));
//            create.registerType("Modified Following", new QuantLib::BusinessDayConvention(QuantLib::ModifiedFollowing));
//            create.registerType("Modified Preceding", new QuantLib::BusinessDayConvention(QuantLib::ModifiedPreceding));
//            create.registerType("P", new QuantLib::BusinessDayConvention(QuantLib::Preceding));
//            create.registerType("Preceding", new QuantLib::BusinessDayConvention(QuantLib::Preceding));
//            create.registerType("Unadjusted", new QuantLib::BusinessDayConvention(QuantLib::Unadjusted));
//        }
//        {
//            ObjectHandler::Create<QuantLib::CapFloor::Type> create;
//            create.registerType("Cap", new QuantLib::CapFloor::Type(QuantLib::CapFloor::Cap));
//            create.registerType("Collar", new QuantLib::CapFloor::Type(QuantLib::CapFloor::Collar));
//            create.registerType("Floor", new QuantLib::CapFloor::Type(QuantLib::CapFloor::Floor));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::CmsMarketCalibration::CalibrationType> create;
//            create.registerType("OnForwardPrice", new QuantLib::CmsMarketCalibration::CalibrationType(QuantLib::CmsMarketCalibration::OnForwardCmsPrice));
//            create.registerType("OnPrice", new QuantLib::CmsMarketCalibration::CalibrationType(QuantLib::CmsMarketCalibration::OnPrice));
//            create.registerType("OnSpread", new QuantLib::CmsMarketCalibration::CalibrationType(QuantLib::CmsMarketCalibration::OnSpread));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Compounding> create;
//            create.registerType("Compounded", new QuantLib::Compounding(QuantLib::Compounded));
//            create.registerType("Continuous", new QuantLib::Compounding(QuantLib::Continuous));
//            create.registerType("Simple", new QuantLib::Compounding(QuantLib::Simple));
//            create.registerType("SimpleThenCompounded", new QuantLib::Compounding(QuantLib::SimpleThenCompounded));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::CubicInterpolation::BoundaryCondition> create;
//            create.registerType("FirstDerivative", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::FirstDerivative));
//            create.registerType("Lagrange", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::Lagrange));
//            create.registerType("NotAKnot", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::NotAKnot));
//            create.registerType("Periodic", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::Periodic));
//            create.registerType("SecondDerivative", new QuantLib::CubicInterpolation::BoundaryCondition(QuantLib::CubicInterpolation::SecondDerivative));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::CubicInterpolation::DerivativeApprox> create;
//            create.registerType("Akima", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::Akima));
//            create.registerType("FourthOrder", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::FourthOrder));
//            create.registerType("FritschButland", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::FritschButland));
//            create.registerType("Kruger", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::Kruger));
//            create.registerType("Parabolic", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::Parabolic));
//            create.registerType("Spline", new QuantLib::CubicInterpolation::DerivativeApprox(QuantLib::CubicInterpolation::Spline));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Currency> create;
//            create.registerType("ARS", new QuantLib::ARSCurrency());
//            create.registerType("ATS", new QuantLib::ATSCurrency());
//            create.registerType("AUD", new QuantLib::AUDCurrency());
//            create.registerType("BDT", new QuantLib::BDTCurrency());
//            create.registerType("BEF", new QuantLib::BEFCurrency());
//            create.registerType("BGL", new QuantLib::BGLCurrency());
//            create.registerType("BRL", new QuantLib::BRLCurrency());
//            create.registerType("BYR", new QuantLib::BYRCurrency());
//            create.registerType("CAD", new QuantLib::CADCurrency());
//            create.registerType("CHF", new QuantLib::CHFCurrency());
//            create.registerType("CLP", new QuantLib::CLPCurrency());
//            create.registerType("CNY", new QuantLib::CNYCurrency());
//            create.registerType("COP", new QuantLib::COPCurrency());
//            create.registerType("CYP", new QuantLib::CYPCurrency());
//            create.registerType("CZK", new QuantLib::CZKCurrency());
//            create.registerType("Currency", new QuantLib::Currency());
//            create.registerType("DEM", new QuantLib::DEMCurrency());
//            create.registerType("DKK", new QuantLib::DKKCurrency());
//            create.registerType("EEK", new QuantLib::EEKCurrency());
//            create.registerType("ESP", new QuantLib::ESPCurrency());
//            create.registerType("EUR", new QuantLib::EURCurrency());
//            create.registerType("FIM", new QuantLib::FIMCurrency());
//            create.registerType("FRF", new QuantLib::FRFCurrency());
//            create.registerType("GBP", new QuantLib::GBPCurrency());
//            create.registerType("GRD", new QuantLib::GRDCurrency());
//            create.registerType("HKD", new QuantLib::HKDCurrency());
//            create.registerType("HUF", new QuantLib::HUFCurrency());
//            create.registerType("IEP", new QuantLib::IEPCurrency());
//            create.registerType("ILS", new QuantLib::ILSCurrency());
//            create.registerType("INR", new QuantLib::INRCurrency());
//            create.registerType("IQD", new QuantLib::IQDCurrency());
//            create.registerType("IRR", new QuantLib::IRRCurrency());
//            create.registerType("ISK", new QuantLib::ISKCurrency());
//            create.registerType("ITL", new QuantLib::ITLCurrency());
//            create.registerType("JPY", new QuantLib::JPYCurrency());
//            create.registerType("KRW", new QuantLib::KRWCurrency());
//            create.registerType("KWD", new QuantLib::KWDCurrency());
//            create.registerType("LTL", new QuantLib::LTLCurrency());
//            create.registerType("LUF", new QuantLib::LUFCurrency());
//            create.registerType("LVL", new QuantLib::LVLCurrency());
//            create.registerType("MTL", new QuantLib::MTLCurrency());
//            create.registerType("MXN", new QuantLib::MXNCurrency());
//            create.registerType("NLG", new QuantLib::NLGCurrency());
//            create.registerType("NOK", new QuantLib::NOKCurrency());
//            create.registerType("NPR", new QuantLib::NPRCurrency());
//            create.registerType("NZD", new QuantLib::NZDCurrency());
//            create.registerType("NoCurrency", new QuantLib::Currency());
//            create.registerType("PKR", new QuantLib::PKRCurrency());
//            create.registerType("PLN", new QuantLib::PLNCurrency());
//            create.registerType("PTE", new QuantLib::PTECurrency());
//            create.registerType("ROL", new QuantLib::ROLCurrency());
//            create.registerType("SAR", new QuantLib::SARCurrency());
//            create.registerType("SEK", new QuantLib::SEKCurrency());
//            create.registerType("SGD", new QuantLib::SGDCurrency());
//            create.registerType("SIT", new QuantLib::SITCurrency());
//            create.registerType("SKK", new QuantLib::SKKCurrency());
//            create.registerType("THB", new QuantLib::THBCurrency());
//            create.registerType("TRL", new QuantLib::TRLCurrency());
//            create.registerType("TRY", new QuantLib::TRYCurrency());
//            create.registerType("TTD", new QuantLib::TTDCurrency());
//            create.registerType("TWD", new QuantLib::TWDCurrency());
//            create.registerType("USD", new QuantLib::USDCurrency());
//            create.registerType("VEB", new QuantLib::VEBCurrency());
//            create.registerType("ZAR", new QuantLib::ZARCurrency());
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::DateGeneration::Rule> create;
//            create.registerType("Backward", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Backward));
//            create.registerType("Forward", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Forward));
//            create.registerType("OldCDS", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::OldCDS));
//            create.registerType("ThirdWednesday", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::ThirdWednesday));
//            create.registerType("Twentieth", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Twentieth));
//            create.registerType("TwentiethIMM", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::TwentiethIMM));
//            create.registerType("Zero", new QuantLib::DateGeneration::Rule(QuantLib::DateGeneration::Zero));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Duration::Type> create;
//            create.registerType("Macaulay", new QuantLib::Duration::Type(QuantLib::Duration::Macaulay));
//            create.registerType("Modified", new QuantLib::Duration::Type(QuantLib::Duration::Modified));
//            create.registerType("Simple", new QuantLib::Duration::Type(QuantLib::Duration::Simple));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::EndCriteria::Type> create;
//            create.registerType("MaxIterations", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::MaxIterations));
//            create.registerType("None", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::None));
//            create.registerType("StationaryFunctionAccuracy", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::StationaryFunctionAccuracy));
//            create.registerType("StationaryFunctionValue", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::StationaryFunctionValue));
//            create.registerType("StationaryPoint", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::StationaryPoint));
//            create.registerType("Unknown", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::Unknown));
//            create.registerType("ZeroGradientNorm", new QuantLib::EndCriteria::Type(QuantLib::EndCriteria::ZeroGradientNorm));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Frequency> create;
//            create.registerType("Annual", new QuantLib::Frequency(QuantLib::Annual));
//            create.registerType("Bimonthly", new QuantLib::Frequency(QuantLib::Bimonthly));
//            create.registerType("Biweekly", new QuantLib::Frequency(QuantLib::Biweekly));
//            create.registerType("Daily", new QuantLib::Frequency(QuantLib::Daily));
//            create.registerType("EveryFourthMonth", new QuantLib::Frequency(QuantLib::EveryFourthMonth));
//            create.registerType("EveryFourthWeek", new QuantLib::Frequency(QuantLib::EveryFourthWeek));
//            create.registerType("Frequency", new QuantLib::Frequency(QuantLib::NoFrequency));
//            create.registerType("Monthly", new QuantLib::Frequency(QuantLib::Monthly));
//            create.registerType("NoFrequency", new QuantLib::Frequency(QuantLib::NoFrequency));
//            create.registerType("Once", new QuantLib::Frequency(QuantLib::Once));
//            create.registerType("OtherFrequency", new QuantLib::Frequency(QuantLib::OtherFrequency));
//            create.registerType("Quarterly", new QuantLib::Frequency(QuantLib::Quarterly));
//            create.registerType("Semiannual", new QuantLib::Frequency(QuantLib::Semiannual));
//            create.registerType("Weekly", new QuantLib::Frequency(QuantLib::Weekly));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::GFunctionFactory::YieldCurveModel> create;
//            create.registerType("ExactYield", new QuantLib::GFunctionFactory::YieldCurveModel(QuantLib::GFunctionFactory::ExactYield));
//            create.registerType("NonParallelShifts", new QuantLib::GFunctionFactory::YieldCurveModel(QuantLib::GFunctionFactory::NonParallelShifts));
//            create.registerType("ParallelShifts", new QuantLib::GFunctionFactory::YieldCurveModel(QuantLib::GFunctionFactory::ParallelShifts));
//            create.registerType("Standard", new QuantLib::GFunctionFactory::YieldCurveModel(QuantLib::GFunctionFactory::Standard));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Month> create;
//            create.registerType("1", new QuantLib::Month(QuantLib::January));
//            create.registerType("10", new QuantLib::Month(QuantLib::October));
//            create.registerType("11", new QuantLib::Month(QuantLib::November));
//            create.registerType("12", new QuantLib::Month(QuantLib::December));
//            create.registerType("2", new QuantLib::Month(QuantLib::February));
//            create.registerType("3", new QuantLib::Month(QuantLib::March));
//            create.registerType("4", new QuantLib::Month(QuantLib::April));
//            create.registerType("5", new QuantLib::Month(QuantLib::May));
//            create.registerType("6", new QuantLib::Month(QuantLib::June));
//            create.registerType("7", new QuantLib::Month(QuantLib::July));
//            create.registerType("8", new QuantLib::Month(QuantLib::August));
//            create.registerType("9", new QuantLib::Month(QuantLib::September));
//            create.registerType("Apr", new QuantLib::Month(QuantLib::Apr));
//            create.registerType("April", new QuantLib::Month(QuantLib::April));
//            create.registerType("Aug", new QuantLib::Month(QuantLib::Aug));
//            create.registerType("August", new QuantLib::Month(QuantLib::August));
//            create.registerType("Dec", new QuantLib::Month(QuantLib::Dec));
//            create.registerType("December", new QuantLib::Month(QuantLib::December));
//            create.registerType("Feb", new QuantLib::Month(QuantLib::Feb));
//            create.registerType("February", new QuantLib::Month(QuantLib::February));
//            create.registerType("Jan", new QuantLib::Month(QuantLib::Jan));
//            create.registerType("January", new QuantLib::Month(QuantLib::January));
//            create.registerType("Jul", new QuantLib::Month(QuantLib::Jul));
//            create.registerType("July", new QuantLib::Month(QuantLib::July));
//            create.registerType("Jun", new QuantLib::Month(QuantLib::Jun));
//            create.registerType("June", new QuantLib::Month(QuantLib::June));
//            create.registerType("Mar", new QuantLib::Month(QuantLib::Mar));
//            create.registerType("March", new QuantLib::Month(QuantLib::March));
//            create.registerType("May", new QuantLib::Month(QuantLib::May));
//            create.registerType("Nov", new QuantLib::Month(QuantLib::Nov));
//            create.registerType("November", new QuantLib::Month(QuantLib::November));
//            create.registerType("Oct", new QuantLib::Month(QuantLib::Oct));
//            create.registerType("October", new QuantLib::Month(QuantLib::October));
//            create.registerType("Sep", new QuantLib::Month(QuantLib::Sep));
//            create.registerType("September", new QuantLib::Month(QuantLib::September));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::OvernightIndexedSwap::Type> create;
//            create.registerType("Payer", new QuantLib::OvernightIndexedSwap::Type(QuantLib::OvernightIndexedSwap::Payer));
//            create.registerType("Receiver", new QuantLib::OvernightIndexedSwap::Type(QuantLib::OvernightIndexedSwap::Receiver));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Position::Type> create;
//            create.registerType("Long", new QuantLib::Position::Type(QuantLib::Position::Long));
//            create.registerType("Short", new QuantLib::Position::Type(QuantLib::Position::Short));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::PriceType> create;
//            create.registerType("Ask", new QuantLib::PriceType(QuantLib::Ask));
//            create.registerType("Bid", new QuantLib::PriceType(QuantLib::Bid));
//            create.registerType("Close", new QuantLib::PriceType(QuantLib::Close));
//            create.registerType("Last", new QuantLib::PriceType(QuantLib::Last));
//            create.registerType("Mid", new QuantLib::PriceType(QuantLib::Mid));
//            create.registerType("Mid Equivalent", new QuantLib::PriceType(QuantLib::MidEquivalent));
//            create.registerType("Mid Safe", new QuantLib::PriceType(QuantLib::MidSafe));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Protection::Side> create;
//            create.registerType("Buyer", new QuantLib::Protection::Side(QuantLib::Protection::Buyer));
//            create.registerType("Seller", new QuantLib::Protection::Side(QuantLib::Protection::Seller));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Replication::Type> create;
//            create.registerType("Central", new QuantLib::Replication::Type(QuantLib::Replication::Central));
//            create.registerType("Sub", new QuantLib::Replication::Type(QuantLib::Replication::Sub));
//            create.registerType("Super", new QuantLib::Replication::Type(QuantLib::Replication::Super));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::SalvagingAlgorithm::Type> create;
//            create.registerType("Higham", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::Higham));
//            create.registerType("Hypersphere", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::Hypersphere));
//            create.registerType("LowerDiagonal", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::LowerDiagonal));
//            create.registerType("None", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::None));
//            create.registerType("Spectral", new QuantLib::SalvagingAlgorithm::Type(QuantLib::SalvagingAlgorithm::Spectral));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::SensitivityAnalysis> create;
//            create.registerType("Centered", new QuantLib::SensitivityAnalysis(QuantLib::Centered));
//            create.registerType("OneSide", new QuantLib::SensitivityAnalysis(QuantLib::OneSide));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Settlement::Type> create;
//            create.registerType("Cash", new QuantLib::Settlement::Type(QuantLib::Settlement::Cash));
//            create.registerType("Physical", new QuantLib::Settlement::Type(QuantLib::Settlement::Physical));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::TimeUnit> create;
//            create.registerType("Days", new QuantLib::TimeUnit(QuantLib::Days));
//            create.registerType("Months", new QuantLib::TimeUnit(QuantLib::Months));
//            create.registerType("Weeks", new QuantLib::TimeUnit(QuantLib::Weeks));
//            create.registerType("Years", new QuantLib::TimeUnit(QuantLib::Years));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::VanillaSwap::Type> create;
//            create.registerType("Payer", new QuantLib::VanillaSwap::Type(QuantLib::VanillaSwap::Payer));
//            create.registerType("Receiver", new QuantLib::VanillaSwap::Type(QuantLib::VanillaSwap::Receiver));
//        }
//
//        {
//            ObjectHandler::Create<QuantLib::Weekday> create;
//            create.registerType("Fri", new QuantLib::Weekday(QuantLib::Fri));
//            create.registerType("Friday", new QuantLib::Weekday(QuantLib::Friday));
//            create.registerType("Mon", new QuantLib::Weekday(QuantLib::Mon));
//            create.registerType("Monday", new QuantLib::Weekday(QuantLib::Monday));
//            create.registerType("Sat", new QuantLib::Weekday(QuantLib::Sat));
//            create.registerType("Saturday", new QuantLib::Weekday(QuantLib::Saturday));
//            create.registerType("Sun", new QuantLib::Weekday(QuantLib::Sun));
//            create.registerType("Sunday", new QuantLib::Weekday(QuantLib::Sunday));
//            create.registerType("Thu", new QuantLib::Weekday(QuantLib::Thu));
//            create.registerType("Thursday", new QuantLib::Weekday(QuantLib::Thursday));
//            create.registerType("Tue", new QuantLib::Weekday(QuantLib::Tue));
//            create.registerType("Tuesday", new QuantLib::Weekday(QuantLib::Tuesday));
//            create.registerType("Wed", new QuantLib::Weekday(QuantLib::Wed));
//            create.registerType("Wednesday", new QuantLib::Weekday(QuantLib::Wednesday));
//        }
//
//        {
//            ObjectHandler::Create<QuantLibAddin::InterpolatedYieldCurve::Interpolator> create;
//            create.registerType("BackwardFlat", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::BackwardFlat));
//            create.registerType("CubicNaturalSpline", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::CubicNaturalSpline));
//            create.registerType("ForwardFlat", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::ForwardFlat));
//            create.registerType("FritschButlandCubic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::FritschButlandCubic));
//            create.registerType("FritschButlandLogCubic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::FritschButlandLogCubic));
//            create.registerType("KrugerCubic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::KrugerCubic));
//            create.registerType("KrugerLogCubic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::KrugerLogCubic));
//            create.registerType("Linear", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::Linear));
//            create.registerType("LogCubicNaturalSpline", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::LogCubicNaturalSpline));
//            create.registerType("LogLinear", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::LogLinear));
//            create.registerType("LogParabolic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::LogParabolic));
//            create.registerType("MonotonicCubicNaturalSpline", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::MonotonicCubicNaturalSpline));
//            create.registerType("MonotonicLogCubicNaturalSpline", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::MonotonicLogCubicNaturalSpline));
//            create.registerType("MonotonicLogParabolic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::MonotonicLogParabolic));
//            create.registerType("MonotonicParabolic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::MonotonicParabolic));
//            create.registerType("Parabolic", new QuantLibAddin::InterpolatedYieldCurve::Interpolator(QuantLibAddin::InterpolatedYieldCurve::Parabolic));
//        }
//
//        {
//            ObjectHandler::Create<QuantLibAddin::InterpolatedYieldCurve::Traits> create;
//            create.registerType("Discount", new QuantLibAddin::InterpolatedYieldCurve::Traits(QuantLibAddin::InterpolatedYieldCurve::Discount));
//            create.registerType("ForwardRate", new QuantLibAddin::InterpolatedYieldCurve::Traits(QuantLibAddin::InterpolatedYieldCurve::ForwardRate));
//            create.registerType("ZeroYield", new QuantLibAddin::InterpolatedYieldCurve::Traits(QuantLibAddin::InterpolatedYieldCurve::ZeroYield));
//        }
//
//        {
//            ObjectHandler::Create<QuantLibAddin::RateHelper::DepoInclusionCriteria> create;
//            create.registerType("AllDepos", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::AllDepos));
//            create.registerType("DeposBeforeFirstFuturesExpiryDate", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesExpiryDate));
//            create.registerType("DeposBeforeFirstFuturesStartDate", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesStartDate));
//            create.registerType("DeposBeforeFirstFuturesStartDatePlusOne", new QuantLibAddin::RateHelper::DepoInclusionCriteria(QuantLibAddin::RateHelper::DeposBeforeFirstFuturesStartDatePlusOne));
//        }
//
//        {
//            ObjectHandler::Create<QuantLibAddin::SwapIndex::FixingType> create;
//            create.registerType("IfrFix", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IfrFix));
//            create.registerType("Isda", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::Isda));
//            create.registerType("IsdaFixA", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IsdaFixA));
//            create.registerType("IsdaFixAm", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IsdaFixAm));
//            create.registerType("IsdaFixB", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IsdaFixB));
//            create.registerType("IsdaFixPm", new QuantLibAddin::SwapIndex::FixingType(QuantLibAddin::SwapIndex::IsdaFixPm));
//        }
//
//    }
//
//    void unregisterEnumeratedTypes() {
//    
//        ObjectHandler::Create<QuantLib::Average::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Barrier::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::BusinessDayConvention>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::CapFloor::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::CmsMarketCalibration::CalibrationType>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Compounding>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::CubicInterpolation::BoundaryCondition>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::CubicInterpolation::DerivativeApprox>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Currency>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::DateGeneration::Rule>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Duration::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::EndCriteria::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Frequency>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::GFunctionFactory::YieldCurveModel>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Month>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::OvernightIndexedSwap::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Position::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::PriceType>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Protection::Side>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Replication::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::SalvagingAlgorithm::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::SensitivityAnalysis>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Settlement::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::TimeUnit>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::VanillaSwap::Type>().unregisterTypes();
//        ObjectHandler::Create<QuantLib::Weekday>().unregisterTypes();
//        ObjectHandler::Create<QuantLibAddin::InterpolatedYieldCurve::Interpolator>().unregisterTypes();
//        ObjectHandler::Create<QuantLibAddin::InterpolatedYieldCurve::Traits>().unregisterTypes();
//        ObjectHandler::Create<QuantLibAddin::RateHelper::DepoInclusionCriteria>().unregisterTypes();
//        ObjectHandler::Create<QuantLibAddin::SwapIndex::FixingType>().unregisterTypes();
//
//    }
//
//}
//
