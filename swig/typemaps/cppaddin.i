
// rp_add_* - C++ addin
// These typemaps generate source code for cpp and hpp files in the AddinCpp directory.
// This code is not used for the Excel addin.

%typemap(rp_tm_add_ret) ql_val_dbl "double";

%typemap(rp_tm_add_prm) ql_val_dbl "double";
%typemap(rp_tm_add_prm) ql_val_str "const std::string&";
%typemap(rp_tm_add_prm) ql_val_any "const reposit::property_t&";

%typemap(rp_tm_add_cnv) QuantLib::Date const & %{
    QuantLib::Date $1_name_cnv =
        reposit::convert2<QuantLib::Date, reposit::property_t>($1_name);
%}

%typemap(rp_tm_add_cnv) QuantLib::Calendar const & %{
    QuantLib::Calendar $1_name_enum =
        reposit::Create<QuantLib::Calendar>()($1_name);
%} 

%typemap(rp_tm_add_cnv) QuantLib::DayCounter const & %{
    QuantLib::DayCounter $1_name_enum =
        reposit::Create<QuantLib::DayCounter>()($1_name);
%} 

%typemap(rp_tm_add_cnv) QuantLib::Handle<QuantLib::Quote> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
    QuantLib::Handle<QuantLib::Quote> $1_name_handle =
        QuantLib::Handle<QuantLib::Quote>($1_name_get);
%} 

%typemap(rp_tm_add_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
    QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%} 

%typemap(rp_tm_add_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

%typemap(rp_tm_add_cnv) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
%}

%typemap(rp_tm_add_cnv) boost::shared_ptr<QuantLib::Exercise> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
%}

%typemap(rp_tm_add_cnv) QuantLib::Option::Type %{
    QuantLib::Option::Type $1_name_enum =
        reposit::Create<QuantLib::Option::Type>()($1_name);
%} 

%typemap(rp_tm_add_cnv) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
%}
%typemap(rp_tm_add_cnv) const boost::shared_ptr<QuantLib::PricingEngine>& %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::AnalyticEuropeanEngine, QuantLib::PricingEngine)
%}

%typemap(rp_tm_add_cll) ql_cnv_val "$1_name_cnv";
%typemap(rp_tm_add_cll) ql_cnv_enm "$1_name_enum";
%typemap(rp_tm_add_cll) ql_cnv_hnd "$1_name_handle";
%typemap(rp_tm_add_cll) ql_cnv_obj "$1_name_get";

%typemap(rp_tm_add_prm) ql_val_dbl "double";
%typemap(rp_tm_add_prm) ql_val_str "const std::string &";
%typemap(rp_tm_add_prm) ql_val_any "const reposit::property_t&";

