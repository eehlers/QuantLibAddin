
%typemap(rp_add_class) QuantLib::Instrument * %{
    OH_LIB_CLASS(Instrument, QuantLib::Instrument);
%}

%typemap(rp_add_type) QuantLib::Real "double";

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

%typemap(rp_vo_declare) QuantLib::Date const & "ObjectHandler::property_t $1_name_";
%typemap(rp_vo_declare) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "ObjectHandler::property_t $1_name_";
%typemap(rp_vo_declare) boost::shared_ptr< QuantLib::Exercise > const & "ObjectHandler::property_t $1_name_";
%typemap(rp_vo_declare) QuantLib::Option::Type "std::string $1_name_";
%typemap(rp_vo_declare) QuantLib::Real "double $1_name_";
%typemap(rp_vo_declare) QuantLib::Handle<QuantLib::Quote> const & "ObjectHandler::property_t $1_name_";
%typemap(rp_vo_declare) QuantLib::Handle<QuantLib::YieldTermStructure> const & "std::string $1_name_";
%typemap(rp_vo_declare) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "std::string $1_name_";
%typemap(rp_vo_declare) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "std::string $1_name_";
%typemap(rp_vo_declare) QuantLib::Calendar const & "std::string $1_name_";
%typemap(rp_vo_declare) QuantLib::Volatility "double $1_name_";
%typemap(rp_vo_declare) QuantLib::DayCounter const & "std::string $1_name_";
%typemap(rp_vo_declare) QuantLib::Rate "double $1_name_";

%typemap(rp_vo_cnv) QuantLib::Date const & "value";
%typemap(rp_vo_cnv) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "value";
%typemap(rp_vo_cnv) boost::shared_ptr< QuantLib::Exercise > const & "value";
%typemap(rp_vo_cnv) QuantLib::Option::Type "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_vo_cnv) QuantLib::Real "ObjectHandler::convert2<double>(value)";
%typemap(rp_vo_cnv) QuantLib::Handle<QuantLib::Quote> const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_vo_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_vo_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_vo_cnv) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_vo_cnv) QuantLib::Calendar const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_vo_cnv) QuantLib::Volatility "ObjectHandler::convert2<double>(value)";
%typemap(rp_vo_cnv) QuantLib::DayCounter const & "ObjectHandler::convert2<std::string>(value)";
%typemap(rp_vo_cnv) QuantLib::Rate "ObjectHandler::convert2<double>(value)";

%typemap(rp_excel) QuantLib::Date const & "P";
%typemap(rp_excel) QuantLib::Calendar const & "P";
%typemap(rp_excel) QuantLib::DayCounter const & "P";
%typemap(rp_excel) QuantLib::Volatility "E";
%typemap(rp_excel) QuantLib::Rate "E";
%typemap(rp_excel) QuantLib::Real "E";
%typemap(rp_excel) QuantLib::Handle<QuantLib::Quote> const & "X";
%typemap(rp_excel) QuantLib::Handle<QuantLib::YieldTermStructure> const & "X";
%typemap(rp_excel) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "X";
%typemap(rp_excel) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "X";
%typemap(rp_excel) boost::shared_ptr< QuantLib::Exercise > const & "X";
%typemap(rp_excel) QuantLib::Option::Type "X";
%typemap(rp_excel) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "X";
%typemap(rp_excel) const boost::shared_ptr<QuantLib::PricingEngine>& "X";

%typemap(rp_excel_in) QuantLib::Date const & "OPER*";
%typemap(rp_excel_in) QuantLib::Calendar const & "OPER*";
%typemap(rp_excel_in) QuantLib::DayCounter const & "OPER*";
%typemap(rp_excel_in) QuantLib::Volatility "double*";
%typemap(rp_excel_in) QuantLib::Rate "double*";
%typemap(rp_excel_in) QuantLib::Real "double*";
%typemap(rp_excel_in) QuantLib::Handle<QuantLib::Quote> const & "xxx";
%typemap(rp_excel_in) QuantLib::Handle<QuantLib::YieldTermStructure> const & "xxx";
%typemap(rp_excel_in) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "xxx";
%typemap(rp_excel_in) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "xxx";
%typemap(rp_excel_in) boost::shared_ptr< QuantLib::Exercise > const & "xxx";
%typemap(rp_excel_in) QuantLib::Option::Type "xxx";
%typemap(rp_excel_in) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "xxx";
%typemap(rp_excel_in) const boost::shared_ptr<QuantLib::PricingEngine>& "xxx";

%typemap(rp_excel_cnv) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = ObjectHandler::convert2<QuantLib::Date>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::Date());
%} 

%typemap(rp_excel_call) QuantLib::Date const & "$1_name_cnv";

%typemap(rp_excel_out) QuantLib::Real "double*";

%module(
    rp_obj_dir="../qlo",
    rp_add_dir="../AddinCpp",
    rp_xll_dir="../../QuantLibXL2/qlxl",
    rp_obj_inc="qlo",
    rp_add_inc="AddinCpp",
    rp_xll_inc="qlxl"
) QuantLibAddin

%include exercise.i
%include instruments.i
%include payoffs.i
%include pricingengines.i
%include processes.i
%include quote.i
%include volatilities.i
%include yieldtermstructures.i
%feature("rp:generation", "manual");
%include date.i
%include settings.i
%include utilities.i

