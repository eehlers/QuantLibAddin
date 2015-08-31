
// These QuantLib types behave like long.
%apply rp_tp_long { QuantLib::Natural };

// These QuantLib types behave like double.
%apply rp_tp_double { QuantLib::Real };
%apply rp_tp_double { QuantLib::Rate };
%apply rp_tp_double { QuantLib::Time };
%apply rp_tp_double { QuantLib::Volatility };
%apply rp_tp_double { QuantLib::DiscountFactor };

// These QuantLib types behave like any.
%apply rp_tp_any { QuantLib::Date const & };

// These QuantLib types behave like enum.
%apply rp_tp_enm { QuantLib::Option::Type };
%apply rp_tp_enm { QuantLib::DayCounter };
%apply rp_tp_enm { QuantLib::DayCounter const & };
%apply rp_tp_enm { QuantLib::Frequency const & };
%apply rp_tp_enm { QuantLib::Calendar };
%apply rp_tp_enm { QuantLib::Calendar const & };
%apply rp_tp_enm { QuantLib::DayCounter const & };
%apply rp_tp_enm { QuantLib::BusinessDayConvention };
%apply rp_tp_enm { QuantLib::Futures::Type };
%apply rp_tp_enm { QuantLibAddin::RateHelper::DepoInclusionCriteria };

// Some types that require overrides within QuantLib, tell reposit to treat them like strings.
%apply rp_tp_string { QuantLib::Period const & };

// Names of variables after they have been converted.
%apply rp_tp_cnv2 { QuantLib::Date const & };

// Types on which we want to invoke member functions.
%apply rp_tp_add_obj { QuantLibAddin::Quote };
%apply rp_tp_add_obj { QuantLibAddin::SimpleQuote };
%apply rp_tp_add_obj { QuantLibAddin::Index };

// Data types of objects passed as function parameters to be retrieved from the repository
%apply rp_tp_obj1 { const boost::shared_ptr<QuantLib::Index>& };
%apply rp_tp_obj1 { const boost::shared_ptr<QuantLib::IborIndex>& };
%apply rp_tp_obj1 { const boost::shared_ptr<QuantLib::OvernightIndex>& };
%apply rp_tp_obj1 { const boost::shared_ptr<QuantLib::PricingEngine>& };
%apply rp_tp_obj1 { const boost::shared_ptr<QuantLib::StrikedTypePayoff>& };
%apply rp_tp_obj1 { const boost::shared_ptr<QuantLib::Exercise>& };
%apply rp_tp_obj1 { const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess>& };
%apply rp_tp_obj1 { const boost::shared_ptr<QuantLibAddin::RateHelper>& };

// For addin functions that wrap QuantLibAddin objects rather than QuantLib objects
%apply rp_tp_obj2 { QuantLibAddin::PiecewiseYieldCurve };
%apply rp_tp_obj2 { QuantLibAddin::Interpolation };
%apply rp_tp_obj2 { QuantLibAddin::RateHelper };
%apply rp_tp_obj2 { QuantLibAddin::RelinkableHandle };


