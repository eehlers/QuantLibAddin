
// rp_xll_* - Excel addin

%typemap(rp_xll) ql_val_dbl "E";
%typemap(rp_xll) ql_val_str "C";
%typemap(rp_xll) ql_val_any "P";

%typemap(rp_xll) QuantLib::FlatForward * "C";
%typemap(rp_xll) QuantLib::BlackConstantVol * "C";
%typemap(rp_xll) QuantLib::SimpleQuote * "C";
%typemap(rp_xll) QuantLib::BlackScholesMertonProcess * "C";
%typemap(rp_xll) QuantLib::AnalyticEuropeanEngine * "C";
%typemap(rp_xll) QuantLib::PlainVanillaPayoff * "C";
%typemap(rp_xll) QuantLib::Instrument * "C";
%typemap(rp_xll) QuantLib::EuropeanExercise * "C";
%typemap(rp_xll) QuantLib::VanillaOption * "C";
//%typemap(rp_xll) const QuantLib::DayCounter& "C";

//%typemap(rp_xll_in) ql_val_dbl "double*";
//%typemap(rp_xll_in) ql_val_str "OPER*";
//%typemap(rp_xll_in) ql_val_any "OPER*";
%typemap(rp_xll_in) const boost::shared_ptr<QuantLib::PricingEngine>& "char*";
%typemap(rp_xll_in) const QuantLib::Date& "OPER*";
%typemap(rp_xll_in) const boost::shared_ptr<QuantLib::StrikedTypePayoff>& "char*";
%typemap(rp_xll_in) const boost::shared_ptr<QuantLib::Exercise>& "char*";
%typemap(rp_xll_in) QuantLib::Option::Type "char*";
%typemap(rp_xll_in) QuantLib::Real "double*";
%typemap(rp_xll_in) boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const & "char*";
%typemap(rp_xll_in) QuantLib::Handle< QuantLib::Quote > const & "char*";
%typemap(rp_xll_in) QuantLib::Handle< QuantLib::YieldTermStructure > const & "char*";
%typemap(rp_xll_in) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "char*";
%typemap(rp_xll_in) QuantLib::Calendar const & "char*";
%typemap(rp_xll_in) QuantLib::Volatility "double*";
%typemap(rp_xll_in) QuantLib::DayCounter const & "char*";
%typemap(rp_xll_in) QuantLib::Rate "double*";

%typemap(rp_xll_cnv) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = ObjectHandler::convert2<QuantLib::Date>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::Date());
            
        ObjectHandler::property_t $1_name_cnv2 = ObjectHandler::convert2<ObjectHandler::property_t>(
            ObjectHandler::ConvertOper(*$1_name));            
%} 

//%typemap(rp_xll_cnv) const QuantLib::DayCounter& %{
//        std::string $1_name_cnv = ObjectHandler::convert2<std::string>(
//            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::DayCounter());
//%} 

%typemap(rp_xll_cnv) const boost::shared_ptr<QuantLib::PricingEngine>& %{
        OH_GET_REFERENCE($1_name_obj, $1_name, QuantLibAddin::AnalyticEuropeanEngine, QuantLib::PricingEngine);        
%} 
                      
%typemap(rp_xll_cnv) const boost::shared_ptr<QuantLib::StrikedTypePayoff>& %{
        OH_GET_REFERENCE($1_name_obj, $1_name,
            QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
        std::string $1_name_vo = std::string($1_name);
%} 

%typemap(rp_xll_cnv) const boost::shared_ptr<QuantLib::Exercise>& %{
        OH_GET_REFERENCE($1_name_obj, $1_name,
            QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
        std::string $1_name_vo = std::string($1_name);
%} 

%typemap(rp_xll_cnv) QuantLib::Option::Type %{
    QuantLib::Option::Type $1_name_enum =
        ObjectHandler::Create<QuantLib::Option::Type>()($1_name);
%} 

%typemap(rp_xll_cnv) boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const & %{
    OH_GET_REFERENCE($1_name_obj, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
        std::string $1_name_vo = std::string($1_name);
%} 

%typemap(rp_xll_cnv) QuantLib::Handle< QuantLib::Quote > const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
    QuantLib::Handle<QuantLib::Quote> $1_name_handle =
        QuantLib::Handle<QuantLib::Quote>($1_name_get);
        std::string $1_name_vo = std::string($1_name);        
%} 

%typemap(rp_xll_cnv) QuantLib::Handle< QuantLib::YieldTermStructure > const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
    QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::YieldTermStructure>($1_name_get);
%} 

%typemap(rp_xll_cnv) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

%typemap(rp_xll_cnv) QuantLib::Calendar const & %{
   QuantLib::Calendar calendar_enum =
        ObjectHandler::Create<QuantLib::Calendar>()(calendar);
%} 

%typemap(rp_xll_cnv) QuantLib::DayCounter const & %{
    QuantLib::DayCounter $1_name_enum =
        ObjectHandler::Create<QuantLib::DayCounter>()($1_name);
//    std::string $1_name_cnv = ObjectHandler::convert2<std::string>(
//        ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::DayCounter());        
%} 
        
%typemap(rp_xll_call) ql_cnv_val "$1_name_cnv";

//%typemap(rp_xll_out) ql_val_dbl "double*";
%typemap(rp_xll_out) QuantLib::Real "double*";

%typemap(rp_xll_call_val) ql_val_dbl "*$1_name";
//%typemap(rp_xll_call_val) const QuantLib::DayCounter& "$1_name_cnv";
%typemap(rp_xll_call_val) const QuantLib::DayCounter& "$1_name";
%typemap(rp_xll_call_val) const boost::shared_ptr<QuantLib::StrikedTypePayoff>& "$1_name_vo";
%typemap(rp_xll_call_val) const boost::shared_ptr<QuantLib::Exercise>& "$1_name_vo";
%typemap(rp_xll_call_val) boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const & "$1_name_vo";
%typemap(rp_xll_call_val) QuantLib::Handle< QuantLib::Quote > const & "$1_name_vo";
%typemap(rp_xll_call_val) QuantLib::Volatility "*$1_name";
%typemap(rp_xll_call_val) const QuantLib::Date& "$1_name_cnv2";
%typemap(rp_xll_call_val) QuantLib::DayCounter const & "$1_name";

%typemap(rp_xll_call_obj) const QuantLib::Date& "$1_name_cnv";
%typemap(rp_xll_call_obj) const boost::shared_ptr<QuantLib::PricingEngine>& "$1_name_obj";
%typemap(rp_xll_call_obj) const boost::shared_ptr<QuantLib::StrikedTypePayoff>& "$1_name_obj";
%typemap(rp_xll_call_obj) const boost::shared_ptr<QuantLib::Exercise>& "$1_name_obj";
%typemap(rp_xll_call_obj) boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const & "$1_name_obj";
%typemap(rp_xll_call_obj) QuantLib::Option::Type "$1_name_enum";
%typemap(rp_xll_call_obj) QuantLib::Real "*$1_name";
%typemap(rp_xll_call_obj) QuantLib::Handle< QuantLib::Quote > const & "$1_name_handle";
%typemap(rp_xll_call_obj) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_handle";
%typemap(rp_xll_call_obj) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "$1_name_handle";
%typemap(rp_xll_call_obj) QuantLib::Calendar const & "$1_name_enum";
%typemap(rp_xll_call_obj) QuantLib::DayCounter const & "$1_name_enum";
%typemap(rp_xll_call_obj) QuantLib::Volatility "*$1_name";
%typemap(rp_xll_call_obj) QuantLib::Rate "*$1_name";

%typemap(rp_xll_ret) QuantLib::Real %{
        static QuantLib::Real ret;
        ret = returnValue;
        return &ret;
%}
