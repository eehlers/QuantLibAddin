
// These QuantLib types behave like double.
%apply ql_val_dbl { QuantLib::Real };
%apply ql_val_dbl { QuantLib::Rate };
%apply ql_val_dbl { QuantLib::Volatility };

// These QuantLib types behave like string.
%apply ql_val_str { const boost::shared_ptr<QuantLib::Exercise> & };
%apply ql_val_str { const boost::shared_ptr<QuantLib::PricingEngine>& };
%apply ql_val_str { const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> & };
%apply ql_val_str { const boost::shared_ptr<QuantLib::Index> & };
%apply ql_val_str { QuantLib::Calendar const & };
%apply ql_val_str { QuantLib::DayCounter const & };
%apply ql_val_str { QuantLib::Handle<QuantLib::BlackVolTermStructure> const & };
%apply ql_val_str { QuantLib::Handle<QuantLib::Quote> const & };
//%apply ql_val_str { QuantLib::Handle<QuantLib::YieldTermStructure> const & };
%apply ql_val_str { QuantLib::Option::Type };
%apply ql_val_str { QuantLib::Handle< QuantLib::Quote > const & };
%apply ql_val_str { boost::shared_ptr< QuantLib::StrikedTypePayoff > const & };
%apply ql_val_str { boost::shared_ptr< QuantLib::Exercise > const & };
%apply ql_val_str { QuantLib::Period const & };

// These QuantLib types behave like any.
%apply ql_val_any { QuantLib::Date const & };
//%apply ql_val_any { QuantLib::Date };
//%apply ql_val_any { boost::shared_ptr< QuantLib::StrikedTypePayoff > const & };
//%apply ql_val_any { boost::shared_ptr< QuantLib::Exercise > const & };
//%apply ql_val_any { QuantLib::Handle< QuantLib::Quote > const & };
%apply ql_val_any { QuantLib::Handle<QuantLib::YieldTermStructure> const & };

// Names of variables after they have been converted.
%apply ql_cnv_val { QuantLib::Date const & };
%apply ql_cnv_val { const QuantLib::DayCounter& };
%apply ql_cnv_enm { QuantLib::Calendar const & };
%apply ql_cnv_enm { QuantLib::DayCounter const & };
%apply ql_cnv_enm { QuantLib::Option::Type };
%apply ql_cnv_hnd { QuantLib::Handle<QuantLib::BlackVolTermStructure> const & };
%apply ql_cnv_hnd { QuantLib::Handle<QuantLib::Quote> const & };
%apply ql_cnv_hnd { QuantLib::Handle<QuantLib::YieldTermStructure> const & };
%apply ql_cnv_obj { boost::shared_ptr< QuantLib::StrikedTypePayoff > const & };
%apply ql_cnv_obj { boost::shared_ptr< QuantLib::Exercise > const & };
%apply ql_cnv_obj { const boost::shared_ptr<QuantLib::PricingEngine>& };
%apply ql_cnv_obj { boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & };

%apply rp_tp_add_obj { QuantLibAddin::Index };
