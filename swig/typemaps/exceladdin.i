
// rp_xll_* - Excel addin

%typemap(rp_xll) ql_val_dbl "E";
%typemap(rp_xll) ql_val_str const & "P";
%typemap(rp_xll) ql_val_any const & "P";

%typemap(rp_xll_in) ql_val_dbl "double*";
%typemap(rp_xll_in) ql_val_str "OPER*";
%typemap(rp_xll_in) ql_val_any "OPER*";

%typemap(rp_xll_cnv) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = ObjectHandler::convert2<QuantLib::Date>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::Date());
%} 

%typemap(rp_xll_call) ql_cnv_val "$1_name_cnv";

%typemap(rp_xll_out) ql_val_dbl "double*";

