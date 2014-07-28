
%typemap(rp_cpp_in) QuantLib::Date const & "const ObjectHandler::property_t&";
%typemap(rp_cpp_in) QuantLib::Calendar const & "const std::string&";
%typemap(rp_cpp_in) QuantLib::DayCounter const & "const std::string&";
%typemap(rp_cpp_in) QuantLib::Volatility "double";
%typemap(rp_cpp_in) QuantLib::Rate "double";

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

%typemap(rp_cpp_call) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_cpp_call) QuantLib::Calendar const & "$1_name_enum";
%typemap(rp_cpp_call) QuantLib::DayCounter const & "$1_name_enum";

%typemap(rp_excel) QuantLib::Date const & "P";
%typemap(rp_excel) QuantLib::Calendar const & "P";
%typemap(rp_excel) QuantLib::DayCounter const & "P";
%typemap(rp_excel) QuantLib::Volatility "E";
%typemap(rp_excel) QuantLib::Rate "E";

%typemap(rp_excel_in) QuantLib::Date const & "OPER*";
%typemap(rp_excel_in) QuantLib::Calendar const & "OPER*";
%typemap(rp_excel_in) QuantLib::DayCounter const & "OPER*";
%typemap(rp_excel_in) QuantLib::Volatility "double*";
%typemap(rp_excel_in) QuantLib::Rate "double*";

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

//%include processes.i
%include exercise.i
%include quote.i
%include volatilities.i
%include yieldtermstructures.i
%feature("rp:generation", "manual");
%include date.i
%include utilities.i
%include settings.i

