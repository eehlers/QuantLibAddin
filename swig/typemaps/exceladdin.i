
// rp_xll_* - Excel addin

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

%typemap(rp_tm_xll_cnv) QuantLib::Period const & %{
        QuantLib::Period $1_name_cnv = f($1_name);
%}

%typemap(rp_tm_xll_rdc) std::vector<QuantLib::Date> %{
        std::vector<long> returnValVec = QuantLibAddin::libraryToVector(returnValue);
        static OPER xRet;
        ObjectHandler::vectorToOper(returnValVec, xRet);
        return &xRet;
%}

%typemap(rp_tm_xll_cll_val) QuantLib::Handle< QuantLib::Quote > const & "$1_name_vo";
%typemap(rp_tm_xll_cll_val) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_vo";

%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::Quote > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) const QuantLib::Period& "$1_name_cnv";
