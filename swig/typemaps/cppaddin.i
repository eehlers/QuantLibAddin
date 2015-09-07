
//*****************************************************************************
// rp_tm_cpp_* - typemaps for the C++ Addin
//*****************************************************************************

// rp_tm_cpp_ret - Function return type (F)
// FIXME can delete this one?
%typemap(rp_tm_cpp_ret) ql_val_dbl "double";

// rp_tm_cpp_prm - Function input parameter (F/C/M)
%typemap(rp_tm_cpp_prm) ql_val_dbl "double";
%typemap(rp_tm_cpp_prm) ql_val_str "const std::string &";
%typemap(rp_tm_cpp_prm) ql_val_any "const reposit::property_t&";
%typemap(rp_tm_cpp_prm) QuantLib::Date const & "const reposit::property_t&";
%typemap(rp_tm_cpp_prm) QuantLib::Handle< QuantLib::Quote > const & "const std::string &";
%typemap(rp_tm_cpp_prm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "const std::string &";
%typemap(rp_tm_cpp_prm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "const std::string &";

// rp_tm_cpp_cnv - Convert inputs from C++ Addin api types into underlying Library types (F/C/M)
%typemap(rp_tm_cpp_cnv) QuantLib::Date const & %{
    QuantLib::Date $1_name_cnv =
        reposit::convert2<QuantLib::Date, reposit::property_t>($1_name);
%}

%typemap(rp_tm_cpp_cnv) QuantLib::Calendar const & %{
    QuantLib::Calendar $1_name_enum =
        reposit::Create<QuantLib::Calendar>()($1_name);
%} 

%typemap(rp_tm_cpp_cnv) QuantLib::DayCounter const & %{
    QuantLib::DayCounter $1_name_enum =
        reposit::Create<QuantLib::DayCounter>()($1_name);
%} 

%typemap(rp_tm_cpp_cnv) QuantLib::Handle<QuantLib::Quote> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
    QuantLib::Handle<QuantLib::Quote> $1_name_handle =
        QuantLib::Handle<QuantLib::Quote>($1_name_get);
%} 

%typemap(rp_tm_cpp_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
    QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%} 

%typemap(rp_tm_cpp_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

%typemap(rp_tm_cpp_cnv) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
%}

%typemap(rp_tm_cpp_cnv) boost::shared_ptr<QuantLib::Exercise> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
%}

%typemap(rp_tm_cpp_cnv) QuantLib::Option::Type %{
    QuantLib::Option::Type $1_name_enum =
        reposit::Create<QuantLib::Option::Type>()($1_name);
%} 

%typemap(rp_tm_cpp_cnv) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
%}
%typemap(rp_tm_cpp_cnv) const boost::shared_ptr<QuantLib::PricingEngine>& %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::AnalyticEuropeanEngine, QuantLib::PricingEngine)
%}

// rp_tm_cpp_rtd - declare variable to capture return value of called function
%typemap(rp_tm_cpp_rtd) QuantLib::Date "QuantLib::Date returnValue =";

// rp_tm_cpp_rts - return statement (F/M)
%typemap(rp_tm_cpp_rts) QuantLib::Date "return returnValue.serialNumber();";

// rp_tm_cpp_arg - arguments to the underlying Library function (F/C/M)
//%typemap(rp_tm_cpp_arg) ql_cnv_val "$1_name_cnv";
//%typemap(rp_tm_cpp_arg) ql_cnv_enm "$1_name_enum";
//%typemap(rp_tm_cpp_arg) ql_cnv_hnd "$1_name_handle";
//%typemap(rp_tm_cpp_arg) ql_cnv_obj "$1_name_get";
%typemap(rp_tm_cpp_arg) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_tm_cpp_arg) const QuantLib::Handle< QuantLib::Quote >& "$1_name_handle";
%typemap(rp_tm_cpp_arg) const QuantLib::Handle<QuantLib::YieldTermStructure>& "$1_name_handle";
%typemap(rp_tm_cpp_arg) const QuantLib::Handle<QuantLib::BlackVolTermStructure>& "$1_name_handle";

// rp_tm_cpp_rtm - return type of a member function (M)
%typemap(rp_tm_cpp_rtm) QuantLib::Date "long";

