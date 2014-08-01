
// rp_val_* - valueobjects
// These typemaps generate source code for cpp and hpp files in the qlo/valueobjects directory.

// *** BEGIN typemap rp_val_in
// This typemap generates code in the valueobject cpp and hpp files
// which declares the types of the inputs to the valuobject constructor.

// These QuantLib types behave like double.
%typemap(rp_val_in) QuantLib::Rate "double";
%typemap(rp_val_in) QuantLib::Real "double";
%typemap(rp_val_in) QuantLib::Volatility "double";

// These QuantLib types behave like string.
%typemap(rp_val_in) boost::shared_ptr<QuantLib::Exercise> const & "const std::string&";
%typemap(rp_val_in) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "const std::string&";
%typemap(rp_val_in) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & "const std::string&";
%typemap(rp_val_in) const boost::shared_ptr<QuantLib::PricingEngine>& "const std::string&";
%typemap(rp_val_in) QuantLib::Calendar const & "const std::string&";
%typemap(rp_val_in) QuantLib::DayCounter const & "const std::string&";
%typemap(rp_val_in) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "const std::string&";
%typemap(rp_val_in) QuantLib::Handle<QuantLib::Quote> const & "const std::string&";
%typemap(rp_val_in) QuantLib::Handle<QuantLib::YieldTermStructure> const & "const std::string&";
%typemap(rp_val_in) QuantLib::Option::Type "const std::string&";

// These QuantLib types behave like any.
%typemap(rp_val_in) QuantLib::Date const & "const ObjectHandler::property_t&";

// *** END   typemap rp_val_in

// *** BEGIN typemap rp_val_declare
// This typemap generates code in the valueobject hpp file
// which declares the types of the member variables.

// These QuantLib types behave like double.
%typemap(rp_val_declare) QuantLib::Rate "double $1_name_";
%typemap(rp_val_declare) QuantLib::Real "double $1_name_";
%typemap(rp_val_declare) QuantLib::Volatility "double $1_name_";

// These QuantLib types behave like string.
%typemap(rp_val_declare) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Calendar const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::DayCounter const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Handle<QuantLib::YieldTermStructure> const & "std::string $1_name_";
%typemap(rp_val_declare) QuantLib::Option::Type "std::string $1_name_";

// These QuantLib types behave like any.
%typemap(rp_val_declare) boost::shared_ptr< QuantLib::Exercise > const & "ObjectHandler::property_t $1_name_";
%typemap(rp_val_declare) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "ObjectHandler::property_t $1_name_";
%typemap(rp_val_declare) QuantLib::Date const & "ObjectHandler::property_t $1_name_";
%typemap(rp_val_declare) QuantLib::Handle<QuantLib::Quote> const & "ObjectHandler::property_t $1_name_";

// *** END   typemap rp_val_declare

// *** BEGIN typemap rp_val_cnv
// This typemap generates cpp code which converts a valueobject property from "any" (const ObjectHandler::property_t&)
// to the type of the valueobject member variable, which is either a native C++ type, or any.

// The conversion for a double.
%typemap(rp_val_cnv) ql_val_cnv_dbl "ObjectHandler::convert2<double>(value)";
// The conversion for a string.
%typemap(rp_val_cnv) ql_val_cnv_str "ObjectHandler::convert2<std::string>(value)";
// No conversion is required for values of type "any" (const ObjectHandler::property_t&)
%typemap(rp_val_cnv) ql_val_cnv_any "value";

// *** END   typemap rp_val_cnv

