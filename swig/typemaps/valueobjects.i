
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
%typemap(rp_tm_val_prm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "const reposit::property_t&";
%typemap(rp_tm_val_prm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "const std::string &";
%typemap(rp_tm_val_prm) QuantLib::Period "const std::string&";
%typemap(rp_tm_val_prm) std::vector< boost::shared_ptr< QuantLib::RateHelper > > const & "const std::vector<std::string>&";
%typemap(rp_tm_val_prm) std::vector< QuantLib::Handle< QuantLib::Quote > > const & "const std::vector<reposit::property_t>&";
%typemap(rp_tm_val_prm) std::vector< QuantLib::Date > const & "const std::vector<reposit::property_t>&";

%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Natural>& "reposit::vector::convert2<long>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Real>& "reposit::vector::convert2<double>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Rate>& "reposit::vector::convert2<double>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Spread>& "reposit::vector::convert2<double>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<boost::shared_ptr<QuantLibAddin::Leg> >& "reposit::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Leg>& "reposit::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::Quote > const & "reposit::convert2<std::string>(value)";
%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::YieldTermStructure > const & "value";
%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "reposit::convert2<std::string>(value)";
%typemap(rp_tm_val_cnv) QuantLib::Period "reposit::convert2<std::string>(value)";
%typemap(rp_tm_val_cnv) const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& "reposit::vector::convert2<std::string>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Handle<QuantLib::Quote> >& "reposit::vector::convert2<reposit::property_t>(value, nameUpper)";
%typemap(rp_tm_val_cnv) const std::vector<QuantLib::Date>& "reposit::vector::convert2<reposit::property_t>(value, nameUpper)";

%typemap(rp_tm_val_dcl) std::vector< QuantLib::Natural > const & "std::vector<long> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Real > const & "std::vector<double> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Rate > const & "std::vector<double> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Spread > const & "std::vector<double> $1_name_";
%typemap(rp_tm_val_dcl) const std::vector<boost::shared_ptr<QuantLibAddin::Leg> >& "std::vector<std::string> $1_name_";
%typemap(rp_tm_val_dcl) const std::vector<QuantLib::Leg>& "std::vector<std::string> $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Period "std::string $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::Quote > const & "std::string $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::YieldTermStructure > const & "reposit::property_t $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "std::string $1_name_";
%typemap(rp_tm_val_dcl) std::vector< boost::shared_ptr< QuantLib::RateHelper > > const & "std::vector<std::string> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Handle< QuantLib::Quote > > const & "std::vector<reposit::property_t> $1_name_";
%typemap(rp_tm_val_dcl) std::vector< QuantLib::Date > const & "std::vector<reposit::property_t> $1_name_";

