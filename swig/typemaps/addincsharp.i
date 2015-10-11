
//*****************************************************************************
// rp_tm_csh_* - typemaps for the C# Addin
//*****************************************************************************

%typemap(rp_tm_csh_parm) QuantLib::Date "long";
%typemap(rp_tm_csh_parm) QuantLib::Date const & "long";
//%typemap(rp_tm_csh_parm) QuantLib::Period const & "const char *";

// rp_tm_csh_args - arguments to the underlying Library function (F/C/M)
%typemap(rp_tm_csh_args) QuantLib::Date "$1_name_cnv";
%typemap(rp_tm_csh_args) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_tm_csh_args) QuantLib::Period const & "$1_name_cnv";
%typemap(rp_tm_csh_args) QuantLib::OptimizationMethod & "*$1_name_cnv";
%typemap(rp_tm_csh_args) QuantLib::EndCriteria & "*$1_name_cnv";
%typemap(rp_tm_csh_args) QuantLib::Schedule & "*$1_name_cnv";

%typemap(rp_tm_csh_clcp) QuantLib::Date "int";
%typemap(rp_tm_csh_clcp) QuantLib::Date const & "int";

%typemap(rp_tm_csh_loop) QuantLib::Date const & "$1_name_cnv";

// rp_tm_csh_cnvt - Convert inputs from C# Addin api types into underlying Library types (F/C/M)
%typemap(rp_tm_csh_cnvt) QuantLib::Date %{
        QuantLib::Date $1_name_cnv =
            (0==$1_name) ? QuantLib::Date() : QuantLib::Date($1_name);
%}
%typemap(rp_tm_csh_cnvt) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv =
            (0==$1_name) ? QuantLib::Date() : QuantLib::Date($1_name);
%}
%typemap(rp_tm_csh_cnvt) QuantLib::Period const & %{
        QuantLib::Period $1_name_cnv;
        QuantLibAddin::cppToLibrary($1_name, $1_name_cnv);
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

// rp_tm_csh_args - arguments to the underlying Library function (F/C/M)
%typemap(rp_tm_csh_args) QuantLib::Date const & "$1_name_cnv";

%typemap(rp_tm_csh_rttp) std::vector<QuantLib::Date> "long *";

%typemap(rp_tm_csh_parm) std::vector<QuantLib::Period> "long $1_name_length, char const* const*";

%typemap(rp_tm_csh_rscp) std::vector<QuantLib::Date> "IntPtr";

%typemap(rp_tm_csh_clcp) std::vector<QuantLib::Period> "int $1_name_length, [MarshalAs(UnmanagedType.LPArray, ArraySubType=UnmanagedType.LPStr)] string[]";

%typemap(rp_tm_csh_parm) std::vector<QuantLib::Date> const & "long $1_name_length, long*";

%typemap(rp_tm_csh_clcp) std::vector<QuantLib::Date> const & "int $1_name_length, int[]";

%typemap(rp_tm_csh_cnvt) std::vector<QuantLib::Date> const & %{
        std::vector<reposit::property_t> $1_name_vec;
        std::vector<QuantLib::Date> $1_name_vec2;
        for (int i=0; i<$1_name_length; i++) {
            $1_name_vec.push_back($1_name[i]);
            $1_name_vec2.push_back(
                (0==$1_name[i]) ? QuantLib::Date() : QuantLib::Date($1_name[i]));
        }
%}

%typemap(rp_tm_csh_cnvt) std::vector<QuantLib::Period> %{
        //std::vector<reposit::property_t> $1_name_vec;
        std::vector<QuantLib::Period> $1_name_vec2;
        for (int i=0; i<$1_name_length; i++) {
            //$1_name_vec.push_back($1_name[i]);
            QuantLib::Period x1;
            QuantLibAddin::cppToLibrary($1_name[i], x1);
            $1_name_vec2.push_back(QuantLib::Period(x1));
        }
%}

%typemap(rp_tm_csh_cnvt) QuantLib::OptimizationMethod & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::OptimizationMethod, QuantLib::OptimizationMethod)
%}

%typemap(rp_tm_csh_cnvt) QuantLib::Schedule const & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::Schedule, QuantLib::Schedule)
%}

%typemap(rp_tm_csh_cnvt) QuantLib::EndCriteria & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::EndCriteria, QuantLib::EndCriteria)
%}

%typemap(rp_tm_csh_rtst) std::vector<QuantLib::Date> %{
        long *ret = new long[returnValue.size()+1];
        ret[0]=returnValue.size();
        for (unsigned int i=0;i<returnValue.size();i++)
            ret[i+1]=returnValue[i].serialNumber();
        return ret;
%}
