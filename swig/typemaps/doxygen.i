
//*****************************************************************************
// rp_tm_dox_* - typemaps for the Doxygen Addin
//*****************************************************************************

%typemap(rp_tm_dox_rtdc) QuantLib::Natural "long returnValue";
%typemap(rp_tm_dox_rtdc) QuantLib::Real "double returnValue";
%typemap(rp_tm_dox_rtdc) QuantLib::Volatility "double returnValue";
%typemap(rp_tm_dox_rtdc) QuantLib::Period "string returnValue";
%typemap(rp_tm_dox_rtdc) QuantLib::Date "string returnValue";
%typemap(rp_tm_dox_rtdc) std::vector<QuantLib::Real> "vector<double> returnValue";
%typemap(rp_tm_dox_rtdc) std::vector<QuantLib::Date> "vector<long> returnValue";

%typemap(rp_tm_dox_mbvr) QuantLib::Date "string $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Period "string $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Natural "long $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Date const & "string $1_name";
%typemap(rp_tm_dox_mbvr) QuantLib::Handle const & "string $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Period> "vector<string> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Period> const &"vector<string> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Date> "vector<long> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Date> const &"vector<long> $1_name";
%typemap(rp_tm_dox_mbvr) std::vector<QuantLib::Natural> const & "vector<long> $1_name";
%typemap(rp_tm_dox_mbvr) boost::shared_ptr< QuantLibAddin::RateHelper > const & "string $1_name";
%typemap(rp_tm_dox_mbvr) std::vector< QuantLib::Handle< QuantLib::Quote > > const & "string $1_name";
%typemap(rp_tm_dox_mbvr) std::vector< QuantLib::Leg > const & "string $1_name";
%typemap(rp_tm_dox_mbvr) std::vector< boost::shared_ptr< QuantLibAddin::Leg > > const & "string $1_name";

