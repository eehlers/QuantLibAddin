
// These QuantLib types behave like double.
%apply rp_tp_double { QuantLib::Real };
%apply rp_tp_double { QuantLib::Rate };
%apply rp_tp_double { QuantLib::Volatility };

// These QuantLib types behave like string.
%apply rp_tp_string { const boost::shared_ptr<QuantLib::Exercise> & };
%apply rp_tp_string { const boost::shared_ptr<QuantLib::PricingEngine>& };
%apply rp_tp_string { const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> & };
%apply rp_tp_string { const boost::shared_ptr<QuantLib::Index> & };
%apply rp_tp_string { QuantLib::Calendar const & };
%apply rp_tp_string { QuantLib::DayCounter const & };
%apply rp_tp_string { QuantLib::Handle<QuantLib::BlackVolTermStructure> const & };
%apply rp_tp_string { QuantLib::Handle<QuantLib::Quote> const & };
%apply rp_tp_string { QuantLib::Option::Type };
%apply rp_tp_string { QuantLib::Handle< QuantLib::Quote > const & };
%apply rp_tp_string { boost::shared_ptr< QuantLib::StrikedTypePayoff > const & };
%apply rp_tp_string { boost::shared_ptr< QuantLib::Exercise > const & };
%apply rp_tp_string { QuantLib::Period const & };

// These QuantLib types behave like any.
%apply rp_tp_any { QuantLib::Date const & };
%apply rp_tp_any { std::vector< QuantLib::Date > const & };
%apply rp_tp_any { QuantLib::Handle<QuantLib::YieldTermStructure> const & };

// Names of variables after they have been converted.
%apply rp_tp_cnv2 { QuantLib::Date const & };

%apply rp_tp_add_obj { QuantLibAddin::Index };
