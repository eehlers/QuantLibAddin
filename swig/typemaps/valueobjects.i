
// rp_val_* - valueobjects

%typemap(rp_val_in) QuantLib::Date const & "const ObjectHandler::property_t&";
%typemap(rp_val_in) QuantLib::Calendar const & "const std::string&";
%typemap(rp_val_in) QuantLib::DayCounter const & "const std::string&";
%typemap(rp_val_in) QuantLib::Volatility "double";
%typemap(rp_val_in) QuantLib::Rate "double";
%typemap(rp_val_in) QuantLib::Real "double";
%typemap(rp_val_in) QuantLib::Handle<QuantLib::Quote> const & "const std::string&";
%typemap(rp_val_in) QuantLib::Handle<QuantLib::YieldTermStructure> const & "const std::string&";
%typemap(rp_val_in) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "const std::string&";
%typemap(rp_val_in) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & "const std::string&";
%typemap(rp_val_in) boost::shared_ptr<QuantLib::Exercise> const & "const std::string&";
%typemap(rp_val_in) QuantLib::Option::Type "const std::string&";
%typemap(rp_val_in) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "const std::string&";
%typemap(rp_val_in) const boost::shared_ptr<QuantLib::PricingEngine>& "const std::string&";

%typemap(rp_val_declare) QuantLib::Date const & "ObjectHandler::property_t $1_name_";
%typemap(rp_val_declare) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "ObjectHandler::property_t $1_name_";
%typemap(rp_val_declare) boost::shared_ptr< QuantLib::Exercise > const & "ObjectHandler::property_t $1_name_";
%typemap(rp_val_declare) QuantLib::Option::Type "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Real "double $1_name_";
%typemap(rp_val_declare) QuantLib::Handle<QuantLib::Quote> const & "ObjectHandler::property_t $1_name_";
%typemap(rp_val_declare) QuantLib::Handle<QuantLib::YieldTermStructure> const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "std::string $1_name_";
%typemap(rp_val_declare) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Calendar const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Volatility "double $1_name_";
%typemap(rp_val_declare) QuantLib::DayCounter const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Rate "double $1_name_";

%typemap(rp_val_cnv) QuantLib::Date const & "value";
%typemap(rp_val_cnv) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "value";
%typemap(rp_val_cnv) boost::shared_ptr< QuantLib::Exercise > const & "value";
%typemap(rp_val_cnv) QuantLib::Option::Type "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_val_cnv) QuantLib::Real "ObjectHandler::convert2<double>(value)";
%typemap(rp_val_cnv) QuantLib::Handle<QuantLib::Quote> const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_val_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_val_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_val_cnv) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_val_cnv) QuantLib::Calendar const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_val_cnv) QuantLib::Volatility "ObjectHandler::convert2<double>(value)";
%typemap(rp_val_cnv) QuantLib::DayCounter const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_val_cnv) QuantLib::Rate "ObjectHandler::convert2<double>(value)";

