
//*****************************************************************************
// rp_tm_csh_* - typemaps for the C# Addin
//*****************************************************************************

%typemap(rp_tm_csh_parm) QuantLib::Date const & "long";
%typemap(rp_tm_csh_parm) ql_tp_handle "const char *";

// rp_tm_csh_args - arguments to the underlying Library function (F/C/M)
%typemap(rp_tm_csh_args) QuantLib::Date const & "$1_name_cnv";

%typemap(rp_tm_csh_clcp) QuantLib::Date const & "int";
%typemap(rp_tm_csh_clcp) ql_tp_handle "StringBuilder";

// rp_tm_csh_cnvt - Convert inputs from C# Addin api types into underlying Library types (F/C/M)
%typemap(rp_tm_csh_cnvt) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv =
            QuantLib::Date($1_name);
%}

// We would like to define one typemap to handle every occurrence of
// RP_GET_REFERENCE.  But for each type, the from and to types are different.
// We can specify those with %feature directives in the function *.i files but
// we would need to write some code so for now a different typemap for each type.
%typemap(rp_tm_csh_cnvt) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
%}

%typemap(rp_tm_csh_cnvt) boost::shared_ptr<QuantLib::Exercise> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
%}

%typemap(rp_tm_csh_cnvt) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
%}

%typemap(rp_tm_csh_cnvt) boost::shared_ptr<QuantLib::PricingEngine> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::AnalyticEuropeanEngine, QuantLib::PricingEngine)
%}

// Handles - same as RP_GET_REFERENCE above - for now a separate typemap for each type.
%typemap(rp_tm_csh_cnvt) QuantLib::Handle<QuantLib::Quote> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
        QuantLib::Handle<QuantLib::Quote> $1_name_handle =
            QuantLib::Handle<QuantLib::Quote>($1_name_get);
%} 

%typemap(rp_tm_csh_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%} 

%typemap(rp_tm_csh_cnvt) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
        QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
            QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

// rp_tm_csh_args - arguments to the underlying Library function (F/C/M)
%typemap(rp_tm_csh_args) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_tm_csh_args) ql_tp_handle "$1_name_handle";
