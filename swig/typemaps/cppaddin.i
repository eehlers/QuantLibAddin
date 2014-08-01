
// rp_add_* - C++ addin
// These typemaps generate source code for cpp and hpp files in the AddinCpp directory.
// This code is not used for the Excel addin.

%typemap(rp_add_typ) QuantLib::Real "double";

%typemap(rp_add_in) QuantLib::Date const & "const ObjectHandler::property_t&";
%typemap(rp_add_in) QuantLib::Calendar const & "const std::string&";
%typemap(rp_add_in) QuantLib::DayCounter const & "const std::string&";
%typemap(rp_add_in) QuantLib::Volatility "double";
%typemap(rp_add_in) QuantLib::Rate "double";
%typemap(rp_add_in) QuantLib::Real "double";
%typemap(rp_add_in) QuantLib::Handle<QuantLib::Quote> const & "const std::string&";
%typemap(rp_add_in) QuantLib::Handle<QuantLib::YieldTermStructure> const & "const std::string&";
%typemap(rp_add_in) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "const std::string&";
%typemap(rp_add_in) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & "const std::string&";
%typemap(rp_add_in) boost::shared_ptr<QuantLib::Exercise> const & "const std::string&";
%typemap(rp_add_in) QuantLib::Option::Type "const std::string&";
%typemap(rp_add_in) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "const std::string&";
%typemap(rp_add_in) const boost::shared_ptr<QuantLib::PricingEngine>& "const std::string&";

%typemap(rp_add_cnv) QuantLib::Date const & %{
    QuantLib::Date $1_name_cnv =
        ObjectHandler::convert2<QuantLib::Date, ObjectHandler::property_t>($1_name);
%}

%typemap(rp_add_cnv) QuantLib::Calendar const & %{
    QuantLib::Calendar $1_name_enum =
        ObjectHandler::Create<QuantLib::Calendar>()($1_name);
%} 

%typemap(rp_add_cnv) QuantLib::DayCounter const & %{
    QuantLib::DayCounter $1_name_enum =
        ObjectHandler::Create<QuantLib::DayCounter>()($1_name);
%} 

%typemap(rp_add_cnv) QuantLib::Handle<QuantLib::Quote> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
    QuantLib::Handle<QuantLib::Quote> $1_name_handle =
        QuantLib::Handle<QuantLib::Quote>($1_name_get);
%} 

%typemap(rp_add_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
    QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%} 

%typemap(rp_add_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

%typemap(rp_add_cnv) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
%}

%typemap(rp_add_cnv) boost::shared_ptr<QuantLib::Exercise> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
%}

%typemap(rp_add_cnv) QuantLib::Option::Type %{
    QuantLib::Option::Type $1_name_enum =
        ObjectHandler::Create<QuantLib::Option::Type>()($1_name);
%} 

%typemap(rp_add_cnv) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
%}
%typemap(rp_add_cnv) const boost::shared_ptr<QuantLib::PricingEngine>& %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::AnalyticEuropeanEngine, QuantLib::PricingEngine)
%}

%typemap(rp_add_call) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_add_call) QuantLib::Calendar const & "$1_name_enum";
%typemap(rp_add_call) QuantLib::DayCounter const & "$1_name_enum";
%typemap(rp_add_call) QuantLib::Handle<QuantLib::Quote> const & "$1_name_handle";
%typemap(rp_add_call) QuantLib::Handle<QuantLib::YieldTermStructure> const & "$1_name_handle";
%typemap(rp_add_call) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "$1_name_handle";
%typemap(rp_add_call) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & "$1_name_get";
%typemap(rp_add_call) boost::shared_ptr<QuantLib::Exercise> const & "$1_name_get";
%typemap(rp_add_call) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "$1_name_get";
%typemap(rp_add_call) QuantLib::Option::Type "$1_name_enum";
%typemap(rp_add_call) const boost::shared_ptr<QuantLib::PricingEngine>& "$1_name_get";

%typemap(rp_add_in) QuantLib::Date const & "const ObjectHandler::property_t&";
%typemap(rp_add_in) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "const ObjectHandler::property_t&";
%typemap(rp_add_in) boost::shared_ptr< QuantLib::Exercise > const & "const ObjectHandler::property_t&";
%typemap(rp_add_in) QuantLib::Option::Type "const std::string &";
%typemap(rp_add_in) QuantLib::Real "double";
%typemap(rp_add_in) QuantLib::Handle<QuantLib::Quote> const & "const ObjectHandler::property_t&";
%typemap(rp_add_in) QuantLib::Handle<QuantLib::YieldTermStructure> const & "const std::string &";
%typemap(rp_add_in) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "const std::string &";
%typemap(rp_add_in) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "const std::string &";
%typemap(rp_add_in) QuantLib::Volatility "double";
%typemap(rp_add_in) QuantLib::Calendar const & "const std::string &";
%typemap(rp_add_in) QuantLib::DayCounter const & "const std::string &";
%typemap(rp_add_in) QuantLib::Rate "double";
%typemap(rp_add_in) const boost::shared_ptr<QuantLib::PricingEngine>& "const std::string &";

