
// rp_val_* - valueobjects
// These typemaps generate source code for cpp and hpp files in the qlo/valueobjects directory.

%typemap(rp_tm_val_prm) const std::vector<QuantLib::Natural>& "const std::vector<long>&";
%typemap(rp_tm_val_prm) const std::vector<QuantLib::Real>& "const std::vector<double>&";
%typemap(rp_tm_val_prm) const std::vector<QuantLib::Rate>& "const std::vector<double>&";
%typemap(rp_tm_val_prm) const std::vector<QuantLib::Spread>& "const std::vector<double>&";
%typemap(rp_tm_val_prm) const std::vector<QuantLib::Spread>& "const std::vector<double>&";
%typemap(rp_tm_val_prm) const std::vector<boost::shared_ptr<QuantLibAddin::Leg> >& "const std::vector<std::string>&";
%typemap(rp_tm_val_prm) const std::vector<QuantLib::Leg>& "const std::vector<std::string>&";
%typemap(rp_tm_val_prm) QuantLib::Handle< QuantLib::Quote > const & "const std::string &";
%typemap(rp_tm_val_prm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "const ObjectHandler::property_t&";
%typemap(rp_tm_val_prm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "const std::string &";
%typemap(rp_tm_val_prm) QuantLib::Period "const std::string&";
%typemap(rp_tm_val_prm) std::vector< boost::shared_ptr< QuantLib::RateHelper > > const & "const std::vector<std::string>&";
%typemap(rp_tm_val_prm) std::vector< QuantLib::Handle< QuantLib::Quote > > const & "const std::vector<ObjectHandler::property_t>&";
%typemap(rp_tm_val_prm) std::vector< QuantLib::Date > const & "const std::vector<ObjectHandler::property_t>&";

%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Natural>& "ObjectHandler::vector::convert2<long>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Real>& "ObjectHandler::vector::convert2<double>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Rate>& "ObjectHandler::vector::convert2<double>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Spread>& "ObjectHandler::vector::convert2<double>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<boost::shared_ptr<QuantLibAddin::Leg> >& "ObjectHandler::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Leg>& "ObjectHandler::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::Quote > const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::YieldTermStructure > const & "value";
%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_tm_val_cnv) QuantLib::Period "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_tm_val_cnv) const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& "ObjectHandler::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Handle<QuantLib::Quote> >& "ObjectHandler::vector::convert2<ObjectHandler::property_t>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Date>& "ObjectHandler::vector::convert2<ObjectHandler::property_t>(value, nameUpper)";

%typemap(rp_tm_val_dcl) std::vector< QuantLib::Natural > const & "std::vector<long> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Real > const & "std::vector<double> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Rate > const & "std::vector<double> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Spread > const & "std::vector<double> $1_name_";
%typemap(rp_tm_val_dcl) const std::vector<boost::shared_ptr<QuantLibAddin::Leg> >& "std::vector<std::string> $1_name_";
%typemap(rp_tm_val_dcl) const std::vector<QuantLib::Leg>& "std::vector<std::string> $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Period "std::string $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::Quote > const & "std::string $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::YieldTermStructure > const & "ObjectHandler::property_t $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "std::string $1_name_";
%typemap(rp_tm_val_dcl) std::vector< boost::shared_ptr< QuantLib::RateHelper > > const & "std::vector<std::string> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Handle< QuantLib::Quote > > const & "std::vector<ObjectHandler::property_t> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Date > const & "std::vector<ObjectHandler::property_t> $1_name_";

