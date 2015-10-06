
//*****************************************************************************
// rp_tm_cpp_* - typemaps for the C++ Addin
//*****************************************************************************

// rp_tm_cpp_rttp - Function return type (F)

// rp_tm_cpp_parm - Function input parameter (F/C/M)
%typemap(rp_tm_cpp_parm) QuantLib::Date const & "const reposit::property_t&";

// rp_tm_cpp_cnvt - Convert inputs from C++ Addin api types into underlying Library types (F/C/M)
%typemap(rp_tm_cpp_cnvt) QuantLib::Date const & %{
    QuantLib::Date $1_name_cnv =
        reposit::convert2<QuantLib::Date, reposit::property_t>($1_name);
%}

// We would like to define one typemap to handle every occurrence of
// RP_GET_REFERENCE.  But for each type, the from and to types are different.
// We can specify those with %feature directives in the function *.i files but
// we would need to write some code so for now a different typemap for each type.
%typemap(rp_tm_cpp_cnvt) boost::shared_ptr<QuantLib::StrikedTypePayoff> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
%}

%typemap(rp_tm_cpp_cnvt) boost::shared_ptr<QuantLib::Exercise> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
%}

%typemap(rp_tm_cpp_cnvt) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
%}

%typemap(rp_tm_cpp_cnvt) boost::shared_ptr<QuantLib::PricingEngine> const & %{
    RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::AnalyticEuropeanEngine, QuantLib::PricingEngine)
%}

// rp_tm_cpp_rtdc - declare variable to capture return value of called function
%typemap(rp_tm_cpp_rtdc) QuantLib::Date "QuantLib::Date returnValue =";

// rp_tm_cpp_rtst - return statement (F/M)
%typemap(rp_tm_cpp_rtst) QuantLib::Date "return returnValue.serialNumber();";

// rp_tm_cpp_args - arguments to the underlying Library function (F/C/M)
%typemap(rp_tm_cpp_args) QuantLib::Date const & "$1_name_cnv";

// rp_tm_cpp_rtmb - return type of a member function (M)
%typemap(rp_tm_cpp_rtmb) QuantLib::Date "long";

