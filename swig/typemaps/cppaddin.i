
// rp_add_* - C++ addin
// These typemaps generate source code for cpp and hpp files in the AddinCpp directory.
// This code is not used for the Excel addin.

%typemap(rp_tm_add_ret) ql_val_dbl "double";

%typemap(rp_tm_add_prm) ql_val_dbl "double";
%typemap(rp_tm_add_prm) ql_val_str "const std::string&";
%typemap(rp_tm_add_prm) ql_val_any "const ObjectHandler::property_t&";

%typemap(rp_tm_add_cnv) QuantLib::Date const & %{
    QuantLib::Date $1_name_cnv =
        ObjectHandler::convert2<QuantLib::Date, ObjectHandler::property_t>($1_name);
%}

%typemap(rp_tm_add_cnv) QuantLib::Calendar const & %{
    QuantLib::Calendar $1_name_enum =
        ObjectHandler::Create<QuantLib::Calendar>()($1_name);
%} 

%typemap(rp_tm_add_cnv) QuantLib::DayCounter const & %{
    QuantLib::DayCounter $1_name_enum =
        ObjectHandler::Create<QuantLib::DayCounter>()($1_name);
%} 

%typemap(rp_tm_add_cnv) QuantLib::Handle<QuantLib::Quote> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
    QuantLib::Handle<QuantLib::Quote> $1_name_handle =
        QuantLib::Handle<QuantLib::Quote>($1_name_get);
%} 

%typemap(rp_tm_add_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
    QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%} 

%typemap(rp_tm_add_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

%typemap(rp_tm_add_cnv) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
%}

%typemap(rp_tm_add_cnv) boost::shared_ptr<QuantLib::Exercise> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
%}

%typemap(rp_tm_add_cnv) QuantLib::Option::Type %{
    QuantLib::Option::Type $1_name_enum =
        ObjectHandler::Create<QuantLib::Option::Type>()($1_name);
%} 

%typemap(rp_tm_add_cnv) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
%}
%typemap(rp_tm_add_cnv) const boost::shared_ptr<QuantLib::PricingEngine>& %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::AnalyticEuropeanEngine, QuantLib::PricingEngine)
%}

%typemap(rp_tm_add_cll) ql_cnv_val "$1_name_cnv";
%typemap(rp_tm_add_cll) ql_cnv_enm "$1_name_enum";
%typemap(rp_tm_add_cll) ql_cnv_hnd "$1_name_handle";
%typemap(rp_tm_add_cll) ql_cnv_obj "$1_name_get";

%typemap(rp_tm_add_prm) ql_val_dbl "double";
%typemap(rp_tm_add_prm) ql_val_str "const std::string &";
%typemap(rp_tm_add_prm) ql_val_any "const ObjectHandler::property_t&";

