
//*****************************************************************************
// rp_tm_dox_* - typemaps for the Doxygen Addin
//*****************************************************************************

%typemap(rp_tm_dox_rtdc) QuantLib::Natural "long returnValue";
%typemap(rp_tm_dox_rtdc) QuantLib::Real "double returnValue";
%typemap(rp_tm_dox_rtdc) QuantLib::Volatility "double returnValue";
%typemap(rp_tm_dox_rtdc) QuantLib::Period "string returnValue";
%typemap(rp_tm_dox_rtdc) QuantLib::Date "string returnValue";
%typemap(rp_tm_dox_rtdc) std::vector<QuantLib::Real> "vector<double> returnValue";
%typemap(rp_tm_dox_rtdc) std::vector<QuantLib::Real> & "vector<double> returnValue";
%typemap(rp_tm_dox_rtdc) std::vector<QuantLib::Date> "vector<long> returnValue";
%typemap(rp_tm_dox_rtdc) std::vector< std::vector< reposit::property_t > > "vector<vector<any> > returnValue";

%typemap(rp_tm_dox_mbvr) QuantLib::Date "long $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Date & "long $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Natural "long $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Period "string $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Bond & "string $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::YieldTermStructure & "string $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Handle & "string $1_name";
%typemap(rp_tm_dox_mbvr) boost::shared_ptr< QuantLibAddin::RateHelper > & "string $1_name";
%typemap(rp_tm_dox_mbvr) boost::shared_ptr< QuantLib::YieldTermStructure > & "string $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Period> "vector<string> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Period> & "vector<string> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Date> "vector<long> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Date> & "vector<long> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Natural> & "vector<long> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector< QuantLib::Handle< QuantLib::Quote > > & "vector<string> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector< QuantLib::Leg > & "vector<string> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector< boost::shared_ptr< QuantLibAddin::Bond > > & "vector<string> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector< boost::shared_ptr< QuantLibAddin::Leg > > & "vector<string> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector< boost::shared_ptr< QuantLib::InterestRate > > & "vector<string> $1_name";

