
//*****************************************************************************
// rp_tm_cfy_* - typemaps for the =countify Addin
//*****************************************************************************

// rp_tm_cfy_rtfn - Function return type (F)

// rp_tm_cfy_rtmb - return value of a member function (M)
%typemap(rp_tm_cfy_rtmb) QuantLib::Date "long";

// rp_tm_cfy_parm - function parameters (F/C/M)
%typemap(rp_tm_cfy_parm) QuantLib::Date const & "long $1_name_cfy"
%typemap(rp_tm_cfy_parm) QuantLib::Handle< QuantLib::Quote > const & "const char * $1_name";
%typemap(rp_tm_cfy_parm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "const char * $1_name";
%typemap(rp_tm_cfy_parm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "const char * $1_name";

// rp_tm_cfy_cnvt - convert input values from =countify datatypes into datatypes of the underlying Library (F/C/M)
%typemap(rp_tm_cfy_cnvt) QuantLib::Date const & %{
        reposit::property_t $1_name($1_name_cfy);
        QuantLib::Date $1_name_cnv =
            reposit::convert2<QuantLib::Date, reposit::property_t>($1_name);
%}

%typemap(rp_tm_cfy_cnvt) QuantLib::Handle<QuantLib::Quote> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
        QuantLib::Handle<QuantLib::Quote> $1_name_handle =
            QuantLib::Handle<QuantLib::Quote>($1_name_get);
%}

%typemap(rp_tm_cfy_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%}

%typemap(rp_tm_cfy_cnvt) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
        QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
            QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%}

// rp_tm_cfy_rtdf - declare variable to capture return value of Library function (FM)

// rp_tm_cfy_rtdm - declare variable to capture return value of Library function (FM)
%typemap(rp_tm_cfy_rtdm) QuantLib::Date "QuantLib::Date returnValue =";

// rp_tm_cfy_args - arguments to pass to underlying Library function
%typemap(rp_tm_cfy_args) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_tm_cfy_args) const QuantLib::Handle< QuantLib::Quote >& "$1_name_handle";
%typemap(rp_tm_cfy_args) const QuantLib::Handle<QuantLib::YieldTermStructure>& "$1_name_handle";
%typemap(rp_tm_cfy_args) const QuantLib::Handle<QuantLib::BlackVolTermStructure>& "$1_name_handle";

// rp_tm_cfy_rtsf - return statement (F)

// rp_tm_cfy_rtsm - return statement of a Library member function (M)
%typemap(rp_tm_cfy_rtsm) QuantLib::Date "return returnValue.serialNumber();";

// rp_tm_cfy_rtex - return statement in the event of an exception



// rp_tm_cfy_mngo - generate the json to register functions with the mongo database
%typemap(rp_tm_cfy_mngo) QuantLib::Date "INT32";
%typemap(rp_tm_cfy_mngo) QuantLib::Date const & "INT32";

