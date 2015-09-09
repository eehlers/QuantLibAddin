
//*****************************************************************************
// rp_tm_vob_* - typemaps for Value Objects
//*****************************************************************************

// rp_tm_vob_prm - Value Object constructor parameters
%typemap(rp_tm_vob_prm) QuantLib::Period "const std::string&";
%typemap(rp_tm_vob_prm) QuantLib::Handle< QuantLib::Quote > const & "const std::string &";
%typemap(rp_tm_vob_prm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "const reposit::property_t&";
%typemap(rp_tm_vob_prm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "const std::string &";
%typemap(rp_tm_vob_prm) std::vector<QuantLib::Date > const & "const std::vector<reposit::property_t>&";
%typemap(rp_tm_vob_prm) std::vector<QuantLib::Leg> const & "const std::vector<std::string>&";
%typemap(rp_tm_vob_prm) std::vector<boost::shared_ptr<QuantLibAddin::Leg> > const & "const std::vector<std::string>&";
%typemap(rp_tm_vob_prm) std::vector<boost::shared_ptr<QuantLib::RateHelper > > const & "const std::vector<std::string>&";
%typemap(rp_tm_vob_prm) std::vector<QuantLib::Handle<QuantLib::Quote > > const & "const std::vector<reposit::property_t>&";

// rp_tm_vob_mbv - Value Object class member variables
%typemap(rp_tm_vob_mbv) QuantLib::Period "std::string $1_name_";
%typemap(rp_tm_vob_mbv) QuantLib::Handle<QuantLib::Quote > const & "std::string $1_name_";
%typemap(rp_tm_vob_mbv) QuantLib::Handle<QuantLib::YieldTermStructure > const & "reposit::property_t $1_name_";
%typemap(rp_tm_vob_mbv) QuantLib::Handle<QuantLib::BlackVolTermStructure > const & "std::string $1_name_";
%typemap(rp_tm_vob_mbv) std::vector<QuantLib::Leg> const & "std::vector<std::string> $1_name_";
%typemap(rp_tm_vob_mbv) std::vector<QuantLib::Date > const & "std::vector<reposit::property_t> $1_name_";
%typemap(rp_tm_vob_mbv) std::vector<boost::shared_ptr<QuantLibAddin::Leg> > const & "std::vector<std::string> $1_name_";
%typemap(rp_tm_vob_mbv) std::vector<boost::shared_ptr<QuantLib::RateHelper > > const & "std::vector<std::string> $1_name_";
%typemap(rp_tm_vob_mbv) std::vector<QuantLib::Handle<QuantLib::Quote > > const & "std::vector<reposit::property_t> $1_name_";

// rp_tm_vob_ser - code to serialize a Value Object member variable

// rp_tm_vob_nam - Insert the parameter name into the vo property names array

// rp_tm_vob_ini - vo ctor initializer list

// rp_tm_vob_cnv - in ValueObject::setSystemProperty, convert value from property_t to native type (C)
%typemap(rp_tm_vob_cnv) QuantLib::Period "reposit::convert2<std::string>(value)";
%typemap(rp_tm_vob_cnv) QuantLib::Handle<QuantLib::Quote> const & "reposit::convert2<std::string>(value)";
%typemap(rp_tm_vob_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & "value";
%typemap(rp_tm_vob_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "reposit::convert2<std::string>(value)";
%typemap(rp_tm_vob_cnv) std::vector<QuantLib::Leg> const & "reposit::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_vob_cnv) std::vector<QuantLib::Date> const & "reposit::vector::convert2<reposit::property_t>(value, nameUpper)";
%typemap(rp_tm_vob_cnv) std::vector<boost::shared_ptr<QuantLibAddin::Leg> > const & "reposit::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_vob_cnv) std::vector<boost::shared_ptr<QuantLib::RateHelper> > const & "reposit::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_vob_cnv) std::vector<QuantLib::Handle<QuantLib::Quote> > const & "reposit::vector::convert2<reposit::property_t>(value, nameUpper)";

