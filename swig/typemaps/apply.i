
// Some types that require overrides within QuantLib, tell reposit to treat them like strings.
%apply rp_tp_string { QuantLib::Period const & };
%apply rp_tp_string { QuantLib::Schedule const & };
%apply rp_tp_string { QuantLib::OptimizationMethod & };
%apply rp_tp_string { QuantLib::EndCriteria const & };

// Enuerated types.
ENUMERATED_TYPE(QuantLib::Currency)
ENUMERATED_TYPE(QuantLib::Option::Type)
ENUMERATED_TYPE(QuantLib::Frequency)
ENUMERATED_TYPE(QuantLib::BusinessDayConvention)
ENUMERATED_TYPE(QuantLib::Futures::Type)
ENUMERATED_TYPE(QuantLibAddin::RateHelper::DepoInclusionCriteria)
ENUMERATED_TYPE(QuantLib::DateGeneration::Rule)
ENUMERATED_TYPE(QuantLibAddin::SwapIndex::FixingType)
ENUMERATED_TYPE(QuantLib::VanillaSwap::Type)

// Enuerated classes.
ENUMERATED_CLASS(QuantLib::Calendar)
ENUMERATED_CLASS(QuantLib::DayCounter)

// Types on which we want to invoke member functions.
%apply rp_tp_add_obj { QuantLibAddin::Quote };
%apply rp_tp_add_obj { QuantLibAddin::SimpleQuote };
%apply rp_tp_add_obj { QuantLibAddin::Index };

// Data types of objects passed as function parameters to be retrieved from the repository
OBJECT_WRAPPER(QuantLibAddin::Index, QuantLib::Index)
OBJECT_WRAPPER(QuantLibAddin::IborIndex, QuantLib::IborIndex)
OBJECT_WRAPPER(QuantLibAddin::SwapIndex, QuantLib::SwapIndex)
OBJECT_WRAPPER(QuantLibAddin::OvernightIndex, QuantLib::OvernightIndex)
OBJECT_WRAPPER(QuantLibAddin::PricingEngine, QuantLib::PricingEngine)
OBJECT_WRAPPER(QuantLibAddin::StrikedTypePayoff, QuantLib::StrikedTypePayoff)
OBJECT_WRAPPER(QuantLibAddin::Exercise, QuantLib::Exercise)
OBJECT_WRAPPER(QuantLibAddin::GeneralizedBlackScholesProcess, QuantLib::GeneralizedBlackScholesProcess)
OBJECT_WRAPPER(QuantLibAddin::Schedule, QuantLib::Schedule)
OBJECT_WRAPPER(QuantLibAddin::OneFactorAffineModel, QuantLib::OneFactorAffineModel)
OBJECT_WRAPPER(QuantLibAddin::ShortRateModel, QuantLib::ShortRateModel)
OBJECT_WRAPPER(QuantLibAddin::G2, QuantLib::G2)
OBJECT_WRAPPER(QuantLibAddin::VanillaSwap, QuantLib::VanillaSwap)
OBJECT_WRAPPER(QuantLibAddin::Instrument, QuantLib::Instrument)
OBJECT_WRAPPER(QuantLibAddin::InterestRateIndex, QuantLib::InterestRateIndex)
OBJECT_WRAPPER(QuantLibAddin::CalibrationHelper, QuantLib::CalibrationHelper)
OBJECT_WRAPPER(QuantLibAddin::SwaptionHelper, QuantLib::SwaptionHelper)
OBJECT_WRAPPER(QuantLibAddin::CalibratedModel, QuantLib::CalibratedModel)
OBJECT_WRAPPER(QuantLibAddin::RateHelper, QuantLib::RateHelper)

// For addin functions that wrap QuantLibAddin objects rather than QuantLib objects
%apply rp_tp_obj2 { QuantLibAddin::PiecewiseYieldCurve };
%apply rp_tp_obj2 { QuantLibAddin::Interpolation };
%apply rp_tp_obj2 { QuantLibAddin::RateHelper };
%apply rp_tp_obj2 { QuantLibAddin::RelinkableHandle };

%apply ql_tp_handle { QuantLib::Handle<QuantLib::Quote> const & };
%apply ql_tp_handle { QuantLib::Handle<QuantLib::YieldTermStructure> const & };
%apply ql_tp_handle { QuantLib::Handle<QuantLib::BlackVolTermStructure> const & };

