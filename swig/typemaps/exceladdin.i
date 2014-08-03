
// rp_xll_* - Excel addin

%typemap(rp_xll) ql_val_dbl "E";
%typemap(rp_xll) ql_val_str "P";
%typemap(rp_xll) ql_val_any "P";

%typemap(rp_xll_in) ql_val_dbl "double*";
%typemap(rp_xll_in) ql_val_str "OPER*";
%typemap(rp_xll_in) ql_val_any "OPER*";

%typemap(rp_xll_in) const QuantLib::Date& "OPER*";

%typemap(rp_xll_call_val) ql_val_dbl "*$1_name";
%typemap(rp_xll_call_val) const QuantLib::DayCounter& "$1_name_cnv";
%typemap(rp_xll_call_val) QuantLib::Date const & "$1_name_cnv2";

%typemap(rp_xll_cnv) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = ObjectHandler::convert2<QuantLib::Date>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::Date());
            
        ObjectHandler::property_t $1_name_cnv2 = ObjectHandler::convert2<ObjectHandler::property_t>(
            ObjectHandler::ConvertOper(*$1_name));            
%} 

%typemap(rp_xll_cnv) const QuantLib::DayCounter& %{
        std::string $1_name_cnv = ObjectHandler::convert2<std::string>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::DayCounter());
%} 

%typemap(rp_xll_call) ql_cnv_val "$1_name_cnv";

%typemap(rp_xll_out) ql_val_dbl "double*";

%typemap(rp_xll_call_obj) const QuantLib::Date& "$1_name_cnv";

