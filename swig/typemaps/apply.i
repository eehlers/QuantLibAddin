
// Some types that require overrides within QuantLib, tell reposit to treat them like strings.
%apply rp_tp_string { QuantLib::Period const & };
%apply rp_tp_string { QuantLib::Schedule const & };
%apply rp_tp_string { QuantLib::OptimizationMethod & };
%apply rp_tp_string { QuantLib::EndCriteria const & };

// These QuantLib types behave like enum.
%apply rp_tp_enm { QuantLib::Currency };
%apply rp_tp_enm { QuantLib::Currency & };
%apply rp_tp_enm { QuantLib::Option::Type };
%apply rp_tp_enm { QuantLib::Frequency const & };
%apply rp_tp_enm { QuantLib::BusinessDayConvention };
%apply rp_tp_enm { QuantLib::Futures::Type };
%apply rp_tp_enm { QuantLibAddin::RateHelper::DepoInclusionCriteria };
%apply rp_tp_enm { QuantLib::DateGeneration::Rule };
%apply rp_tp_enm { QuantLibAddin::SwapIndex::FixingType };
%apply rp_tp_enm { QuantLib::VanillaSwap::Type };

%apply rp_tp_enm_cls { QuantLib::Calendar };
%apply rp_tp_enm_cls { QuantLib::Calendar const & };
%apply rp_tp_enm_cls { QuantLib::DayCounter };
%apply rp_tp_enm_cls { QuantLib::DayCounter const & };

// Types on which we want to invoke member functions.
%apply rp_tp_add_obj { QuantLibAddin::Quote };
%apply rp_tp_add_obj { QuantLibAddin::SimpleQuote };
%apply rp_tp_add_obj { QuantLibAddin::Index };

// Data types of objects passed as function parameters to be retrieved from the repository
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::Index> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::IborIndex> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::SwapIndex> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::OvernightIndex> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::PricingEngine> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::StrikedTypePayoff> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::Exercise> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLibAddin::RateHelper> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::Schedule> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::OneFactorAffineModel> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::ShortRateModel> const & };
%apply rp_tp_obj1 { boost::shared_ptr<QuantLib::VanillaSwap> const & };

// For addin functions that wrap QuantLibAddin objects rather than QuantLib objects
%apply rp_tp_obj2 { QuantLibAddin::PiecewiseYieldCurve };
%apply rp_tp_obj2 { QuantLibAddin::Interpolation };
%apply rp_tp_obj2 { QuantLibAddin::RateHelper };
%apply rp_tp_obj2 { QuantLibAddin::RelinkableHandle };

%apply ql_tp_handle { QuantLib::Handle<QuantLib::Quote> const & };
%apply ql_tp_handle { QuantLib::Handle<QuantLib::YieldTermStructure> const & };
%apply ql_tp_handle { QuantLib::Handle<QuantLib::BlackVolTermStructure> const & };

