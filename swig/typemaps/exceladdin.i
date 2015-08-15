
// rp_xll_* - Excel addin

%typemap(rp_tm_xll_cod) ql_val_dbl "E";
%typemap(rp_tm_xll_cod) ql_val_str "C";
%typemap(rp_tm_xll_cod) ql_val_any "P";

%typemap(rp_tm_xll_cod) QuantLib::FlatForward * "C";
%typemap(rp_tm_xll_cod) QuantLib::BlackConstantVol * "C";
%typemap(rp_tm_xll_cod) QuantLib::SimpleQuote * "C";
%typemap(rp_tm_xll_cod) QuantLib::BlackScholesMertonProcess * "C";
%typemap(rp_tm_xll_cod) QuantLib::AnalyticEuropeanEngine * "C";
%typemap(rp_tm_xll_cod) QuantLib::PlainVanillaPayoff * "C";
%typemap(rp_tm_xll_cod) QuantLib::Instrument * "C";
%typemap(rp_tm_xll_cod) QuantLib::EuropeanExercise * "C";
%typemap(rp_tm_xll_cod) QuantLib::VanillaOption * "C";
//%typemap(rp_tm_xll_cod) const QuantLib::DayCounter& "C";

//%typemap(rp_tm_xll_prm) ql_val_dbl "double*";
//%typemap(rp_tm_xll_prm) ql_val_str "OPER*";
//%typemap(rp_tm_xll_prm) ql_val_any "OPER*";
%typemap(rp_tm_xll_prm) const boost::shared_ptr<QuantLib::PricingEngine>& "char*";
%typemap(rp_tm_xll_prm) const QuantLib::Date& "OPER*";
%typemap(rp_tm_xll_prm) const boost::shared_ptr<QuantLib::StrikedTypePayoff>& "char*";
%typemap(rp_tm_xll_prm) const boost::shared_ptr<QuantLib::Exercise>& "char*";
%typemap(rp_tm_xll_prm) const boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> & "char*";
%typemap(rp_tm_xll_prm) const boost::shared_ptr<QuantLib::Index>& "char*";
%typemap(rp_tm_xll_prm) QuantLib::Option::Type "char*";
%typemap(rp_tm_xll_prm) QuantLib::Real "double*";
%typemap(rp_tm_xll_prm) QuantLib::Handle< QuantLib::Quote > const & "char*";
%typemap(rp_tm_xll_prm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "OPER*";
%typemap(rp_tm_xll_prm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "char*";
%typemap(rp_tm_xll_prm) QuantLib::Calendar const & "char*";
%typemap(rp_tm_xll_prm) QuantLib::Volatility "double*";
%typemap(rp_tm_xll_prm) QuantLib::DayCounter const & "char*";
%typemap(rp_tm_xll_prm) QuantLib::Rate "double*";
%typemap(rp_tm_xll_prm) QuantLib::Period const & "char*";

%typemap(rp_tm_xll_cnv) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = ObjectHandler::convert2<QuantLib::Date>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::Date());
            
        ObjectHandler::property_t $1_name_cnv2 = ObjectHandler::convert2<ObjectHandler::property_t>(
            ObjectHandler::ConvertOper(*$1_name));            
%} 

//%typemap(rp_tm_xll_cnv) const QuantLib::DayCounter& %{
//        std::string $1_name_cnv = ObjectHandler::convert2<std::string>(
//            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::DayCounter());
//%} 

%typemap(rp_tm_xll_cnv) const boost::shared_ptr<QuantLib::Index>& %{
        OH_GET_REFERENCE($1_name_obj, $1_name,
            QuantLibAddin::Index, QuantLib::Index);        
%} 

%typemap(rp_tm_xll_cnv) const boost::shared_ptr<QuantLib::PricingEngine>& %{
        OH_GET_REFERENCE($1_name_obj, $1_name,
            QuantLibAddin::AnalyticEuropeanEngine, QuantLib::PricingEngine);        
%} 
                      
%typemap(rp_tm_xll_cnv) const boost::shared_ptr<QuantLib::StrikedTypePayoff>& %{
        OH_GET_REFERENCE($1_name_obj, $1_name,
            QuantLibAddin::PlainVanillaPayoff, QuantLib::StrikedTypePayoff)
        std::string $1_name_vo = std::string($1_name);
%} 

%typemap(rp_tm_xll_cnv) const boost::shared_ptr<QuantLib::Exercise>& %{
        OH_GET_REFERENCE($1_name_obj, $1_name,
            QuantLibAddin::EuropeanExercise, QuantLib::Exercise)
        std::string $1_name_vo = std::string($1_name);
%} 

%typemap(rp_tm_xll_cnv) QuantLib::Option::Type %{
    QuantLib::Option::Type $1_name_enum =
        ObjectHandler::Create<QuantLib::Option::Type>()($1_name);
%} 

%typemap(rp_tm_xll_cnv) boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const & %{
    OH_GET_REFERENCE($1_name_obj, $1_name, QuantLibAddin::BlackScholesMertonProcess, QuantLib::GeneralizedBlackScholesProcess)
        std::string $1_name_vo = std::string($1_name);
%} 

%typemap(rp_tm_xll_cnv) QuantLib::Handle< QuantLib::Quote > const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::SimpleQuote, QuantLib::Quote)
    QuantLib::Handle<QuantLib::Quote> $1_name_handle =
        QuantLib::Handle<QuantLib::Quote>($1_name_get);
        std::string $1_name_vo = std::string($1_name);        
%} 

%typemap(rp_tm_xll_cnv) QuantLib::Handle< QuantLib::YieldTermStructure > const & %{
        std::string $1_name_vo = ObjectHandler::convert2<std::string>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", "");

        OH_GET_OBJECT_DEFAULT($1_nameCoerce, $1_name_vo, ObjectHandler::Object)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLibAddin::CoerceHandle<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    $1_nameCoerce, QuantLib::Handle<QuantLib::YieldTermStructure>());
%} 

%typemap(rp_tm_xll_cnv) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & %{
    OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
        QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%} 

%typemap(rp_tm_xll_cnv) QuantLib::Calendar const & %{
   QuantLib::Calendar calendar_enum =
        ObjectHandler::Create<QuantLib::Calendar>()(calendar);
%} 

%typemap(rp_tm_xll_cnv) QuantLib::DayCounter const & %{
    QuantLib::DayCounter $1_name_enum =
        ObjectHandler::Create<QuantLib::DayCounter>()($1_name);
//    std::string $1_name_cnv = ObjectHandler::convert2<std::string>(
//        ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::DayCounter());        
%} 

%typemap(rp_tm_xll_cnv) QuantLib::Period const & %{
        QuantLib::Period $1_name_cnv = f($1_name);
%} 

%typemap(rp_xll_call) ql_cnv_val "$1_name_cnv";

//%typemap(rp_tm_xll_ret) ql_val_dbl "double*";
%typemap(rp_tm_xll_ret) QuantLib::Real "double*";

%typemap(rp_tm_xll_cll_val) ql_val_dbl "*$1_name";
//%typemap(rp_tm_xll_cll_val) const QuantLib::DayCounter& "$1_name_cnv";
%typemap(rp_tm_xll_cll_val) const QuantLib::DayCounter& "$1_name";
%typemap(rp_tm_xll_cll_val) const boost::shared_ptr<QuantLib::StrikedTypePayoff>& "$1_name_vo";
%typemap(rp_tm_xll_cll_val) const boost::shared_ptr<QuantLib::Exercise>& "$1_name_vo";
%typemap(rp_tm_xll_cll_val) boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const & "$1_name_vo";
%typemap(rp_tm_xll_cll_val) QuantLib::Handle< QuantLib::Quote > const & "$1_name_vo";
%typemap(rp_tm_xll_cll_val) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_vo";
%typemap(rp_tm_xll_cll_val) QuantLib::Volatility "*$1_name";
%typemap(rp_tm_xll_cll_val) const QuantLib::Date& "$1_name_cnv2";
%typemap(rp_tm_xll_cll_val) QuantLib::DayCounter const & "$1_name";

%typemap(rp_tm_xll_cll_obj) const QuantLib::Date& "$1_name_cnv";
%typemap(rp_tm_xll_cll_obj) const boost::shared_ptr<QuantLib::PricingEngine>& "$1_name_obj";
%typemap(rp_tm_xll_cll_obj) const boost::shared_ptr<QuantLib::StrikedTypePayoff>& "$1_name_obj";
%typemap(rp_tm_xll_cll_obj) const boost::shared_ptr<QuantLib::Exercise>& "$1_name_obj";
%typemap(rp_tm_xll_cll_obj) const boost::shared_ptr<QuantLib::Index>& "$1_name_obj";
%typemap(rp_tm_xll_cll_obj) boost::shared_ptr< QuantLib::GeneralizedBlackScholesProcess > const & "$1_name_obj";
%typemap(rp_tm_xll_cll_obj) QuantLib::Option::Type "$1_name_enum";
%typemap(rp_tm_xll_cll_obj) QuantLib::Real "*$1_name";
%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::Quote > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) QuantLib::Calendar const & "$1_name_enum";
%typemap(rp_tm_xll_cll_obj) QuantLib::DayCounter const & "$1_name_enum";
%typemap(rp_tm_xll_cll_obj) QuantLib::Volatility "*$1_name";
%typemap(rp_tm_xll_cll_obj) QuantLib::Rate "*$1_name";
%typemap(rp_tm_xll_cll_obj) const QuantLib::Period& "$1_name_cnv";

%typemap(rp_tm_xll_rdc) QuantLib::Real %{
        static QuantLib::Real ret;
        ret = returnValue;
        return &ret;
%}
