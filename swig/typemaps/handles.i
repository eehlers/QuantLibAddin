
%define QUANTLIB_HANDLE(T_ADDIN,T_LIB...)

%typemap(rp_tm_cpp_parm) QuantLib::Handle<T_LIB> const & "const std::string &";
%typemap(rp_tm_cpp_args) QuantLib::Handle<T_LIB> const & "$1_name_handle";
%typemap(rp_tm_csh_parm) QuantLib::Handle<T_LIB> const & "const char *";
%typemap(rp_tm_csh_clcp) QuantLib::Handle<T_LIB> const & "StringBuilder";
%typemap(rp_tm_csh_args) QuantLib::Handle<T_LIB> const & "$1_name_handle";
%typemap(rp_tm_xll_argf) QuantLib::Handle<T_LIB> const & "$1_name_handle";

%typemap(rp_tm_cfy_cnvt) QuantLib::Handle<T_LIB> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, T_ADDIN, T_LIB)
        QuantLib::Handle<T_LIB> $1_name_handle =
            QuantLib::Handle<T_LIB>($1_name_get);
%}
%typemap(rp_tm_cfy_args) QuantLib::Handle<T_LIB> const & "$1_name_handle";
%typemap(rp_tm_cpp_cnvt) QuantLib::Handle<T_LIB> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, T_ADDIN, T_LIB)
    QuantLib::Handle<T_LIB> $1_name_handle =
        QuantLib::Handle<T_LIB>($1_name_get);
%} 

%typemap(rp_tm_csh_cnvt) QuantLib::Handle<T_LIB> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, T_ADDIN, T_LIB)
        QuantLib::Handle<T_LIB> $1_name_handle =
            QuantLib::Handle<T_LIB>($1_name_get);
%} 
%typemap(rp_tm_xll_cnvt) QuantLib::Handle<T_LIB> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, T_ADDIN, T_LIB)
        QuantLib::Handle<T_LIB> $1_name_handle =
            QuantLib::Handle<T_LIB>($1_name_get);
%}
%enddef
