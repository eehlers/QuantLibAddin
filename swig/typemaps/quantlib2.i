
// These QuantLib types behave like double.
%apply ql_val_cnv_dbl { QuantLib::Real };
%apply ql_val_cnv_dbl { QuantLib::Rate };
%apply ql_val_cnv_dbl { QuantLib::Volatility };

// These QuantLib types behave like string.
%apply ql_val_cnv_str { QuantLib::Option::Type };
%apply ql_val_cnv_str { QuantLib::Handle<QuantLib::Quote> const & };
%apply ql_val_cnv_str { QuantLib::Handle<QuantLib::YieldTermStructure> const & };
%apply ql_val_cnv_str { QuantLib::Handle<QuantLib::BlackVolTermStructure> const & };
%apply ql_val_cnv_str { boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & };
%apply ql_val_cnv_str { QuantLib::Calendar const & };
%apply ql_val_cnv_str { QuantLib::DayCounter const & };

// These QuantLib types behave like any.
%apply ql_val_cnv_any { QuantLib::Date const & };
%apply ql_val_cnv_any { boost::shared_ptr< QuantLib::StrikedTypePayoff > const & };
%apply ql_val_cnv_any { boost::shared_ptr< QuantLib::Exercise > const & };

