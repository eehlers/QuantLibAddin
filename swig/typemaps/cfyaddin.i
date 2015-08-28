
// rp_cfy_* - =countify addin

%typemap(rp_tm_cfy_prm) QuantLib::Date const & "long $1_name_cfy"
%typemap(rp_tm_cfy_prm) QuantLib::Handle< QuantLib::Quote > const & "const char * $1_name";
%typemap(rp_tm_cfy_prm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "const char * $1_name";
%typemap(rp_tm_cfy_prm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "const char * $1_name";

%typemap(rp_tm_cfy_mng) QuantLib::Date "INT32";
%typemap(rp_tm_cfy_mng) QuantLib::Date const & "INT32";

%typemap(rp_tm_cfy_cnv) QuantLib::Date const & %{
        ObjectHandler::property_t $1_name($1_name_cfy);
        QuantLib::Date $1_name_cnv =
            ObjectHandler::convert2<QuantLib::Date, ObjectHandler::property_t>($1_name);
%}

%typemap(rp_tm_cfy_cnv) QuantLib::Handle<QuantLib::Quote> const & %{
        OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
        QuantLib::Handle<QuantLib::Quote> $1_name_handle =
            QuantLib::Handle<QuantLib::Quote>($1_name_get);
%} 

%typemap(rp_tm_cfy_cnv) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
        OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%} 

%typemap(rp_tm_cfy_cnv) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
        OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
        QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
            QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

%typemap(rp_tm_cfy_cll) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_tm_cfy_cll) const QuantLib::Handle< QuantLib::Quote >& "$1_name_handle";
%typemap(rp_tm_cfy_cll) const QuantLib::Handle<QuantLib::YieldTermStructure>& "$1_name_handle";
%typemap(rp_tm_cfy_cll) const QuantLib::Handle<QuantLib::BlackVolTermStructure>& "$1_name_handle";

%typemap(rp_tm_cfy_ret1) QuantLib::Date "QuantLib::Date returnValue =";
%typemap(rp_tm_cfy_ret2) QuantLib::Date "return returnValue.serialNumber();";

%typemap(rp_tm_add_cll) QuantLib::Date const & "$1_name_cnv";

%typemap(rp_tm_cfy_rt3) QuantLib::Date "long";

