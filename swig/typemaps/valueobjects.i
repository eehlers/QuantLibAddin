
// rp_val_* - valueobjects
// These typemaps generate source code for cpp and hpp files in the qlo/valueobjects directory.

%typemap(rp_tm_val_prm) QuantLib::Handle< QuantLib::Quote > const & "const std::string &";
%typemap(rp_tm_val_prm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "const ObjectHandler::property_t&";
%typemap(rp_tm_val_prm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "const std::string &";

%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::Quote > const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::YieldTermStructure > const & "value";
%typemap(rp_tm_val_cnv) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "ObjectHandler::convert2<std::string>(value)";

%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::Quote > const & "std::string $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::YieldTermStructure > const & "ObjectHandler::property_t $1_name_";
%typemap(rp_tm_val_dcl) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "std::string $1_name_";