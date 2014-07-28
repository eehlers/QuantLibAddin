
%typemap(rp_cpp_in) QuantLib::Date const & "const ObjectHandler::property_t&";
%typemap(rp_cpp_in) QuantLib::Calendar const & "const std::string&";
%typemap(rp_cpp_in) QuantLib::DayCounter const & "const std::string&";
%typemap(rp_cpp_in) QuantLib::Volatility "double";
%typemap(rp_cpp_in) QuantLib::Rate "double";
%typemap(rp_cpp_in) QuantLib::Real "double";
%typemap(rp_cpp_in) QuantLib::Handle<QuantLib::Quote> const & "const std::string&";
%typemap(rp_cpp_in) QuantLib::Handle<QuantLib::YieldTermStructure> const & "const std::string&";
%typemap(rp_cpp_in) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "const std::string&";
%typemap(rp_cpp_in) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & "const std::string&";
%typemap(rp_cpp_in) boost::shared_ptr<QuantLib::Exercise> const & "const std::string&";
%typemap(rp_cpp_in) QuantLib::Option::Type "const std::string&";
%typemap(rp_cpp_in) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "const std::string&";

%typemap(rp_cpp_cnv) QuantLib::Date const & %{
    QuantLib::Date $1_name_cnv =
        ObjectHandler::convert2<QuantLib::Date, ObjectHandler::property_t>($1_name);
%}

%typemap(rp_cpp_cnv) QuantLib::Calendar const & %{
    QuantLib::Calendar $1_name_enum =
        ObjectHandler::Create<QuantLib::Calendar>()($1_name);
%} 

%typemap(rp_cpp_cnv) QuantLib::DayCounter const & %{
    QuantLib::DayCounter $1_name_enum =
        ObjectHandler::Create<QuantLib::DayCounter>()($1_name);
%} 

%typemap(rp_cpp_cnv) QuantLib::Handle<QuantLib::Quote> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
    QuantLib::Handle<QuantLib::Quote> $1_name_handle =
        QuantLib::Handle<QuantLib::Quote>($1_name_get);
%} 

%typemap(rp_cpp_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
    QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%} 

%typemap(rp_cpp_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

%typemap(rp_cpp_cnv) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
%}

%typemap(rp_cpp_cnv) boost::shared_ptr<QuantLib::Exercise> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
%}

%typemap(rp_cpp_cnv) QuantLib::Option::Type %{
    QuantLib::Option::Type $1_name_enum =
        ObjectHandler::Create<QuantLib::Option::Type>()($1_name);
%} 

%typemap(rp_cpp_cnv) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
%}

%typemap(rp_cpp_call) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_cpp_call) QuantLib::Calendar const & "$1_name_enum";
%typemap(rp_cpp_call) QuantLib::DayCounter const & "$1_name_enum";
%typemap(rp_cpp_call) QuantLib::Handle<QuantLib::Quote> const & "$1_name_handle";
%typemap(rp_cpp_call) QuantLib::Handle<QuantLib::YieldTermStructure> const & "$1_name_handle";
%typemap(rp_cpp_call) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "$1_name_handle";
%typemap(rp_cpp_call) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & "$1_name_get";
%typemap(rp_cpp_call) boost::shared_ptr<QuantLib::Exercise> const & "$1_name_get";
%typemap(rp_cpp_call) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "$1_name_get";
%typemap(rp_cpp_call) QuantLib::Option::Type "$1_name_enum";

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

%typemap(rp_excel_cnv) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = ObjectHandler::convert2<QuantLib::Date>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::Date());
%} 

%typemap(rp_excel_call) QuantLib::Date const & "$1_name_cnv";

//%module QuantLibAddin
%module(
    rp_obj_dir="qlo",
    rp_xl_dir="../QuantLibXL2"
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

