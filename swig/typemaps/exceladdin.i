
// rp_xll_* - Excel addin
%typemap(rp_tm_xxx_oh_get) QuantLib::TermStructure %{
        OH_GET_OBJECT(yyy, objectID, ObjectHandler::Object)
        boost::shared_ptr<QuantLib::TermStructure> xxx =
            QuantLibAddin::CoerceTermStructure<
                QuantLibAddin::TermStructure,
                QuantLib::TermStructure>()(
                    yyy);        
%}
%typemap(rp_tm_xxx_oh_get) QuantLib::YieldTermStructure %{
        OH_GET_OBJECT(yyy, objectID, ObjectHandler::Object)
        boost::shared_ptr<QuantLib::YieldTermStructure> xxx =
            QuantLibAddin::CoerceTermStructure<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    yyy);        
%}

%typemap(rp_tm_xll_cnv) QuantLib::Handle< QuantLib::Quote > const & %{
        OH_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::Quote, QuantLib::Quote)
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
        QuantLib::Period $1_name_cnv;
        QuantLibAddin::cppToLibrary($1_name, $1_name_cnv);
%}

%typemap(rp_tm_xll_cnv) QuantLib::Period %{
        QuantLib::Period $1_name_cnv;
        QuantLibAddin::cppToLibrary($1_name, $1_name_cnv);
%}

%typemap(rp_tm_xll_cnv) const std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> >& %{
        std::vector<std::string> z =
            ObjectHandler::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> > $1_name_vec =
            ObjectHandler::getObjectVector<QuantLibAddin::RateHelper>(z);
%}

%typemap(rp_tm_xll_cnv) const boost::shared_ptr<QuantLibAddin::RateHelper>& qlarh %{
        OH_GET_OBJECT($1_name_obj, $1_name, QuantLibAddin::RateHelper);        
%}

%typemap(rp_tm_xll_cnv) const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& %{
        std::vector<std::string> $1_name_vec =
            ObjectHandler::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::RateHelper> > $1_name_vec2 =
            ObjectHandler::getLibraryObjectVector<QuantLibAddin::RateHelper, QuantLib::RateHelper>($1_name_vec);            
%}

%typemap(rp_tm_xll_cnv) const std::vector<QuantLib::Handle<QuantLib::Quote> >& %{
        std::vector<ObjectHandler::property_t> $1_name_vec =
            ObjectHandler::operToVector<ObjectHandler::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Handle<QuantLib::Quote> > $1_name_vec2 =
            ObjectHandler::operToVector<QuantLib::Handle<QuantLib::Quote> >(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_cnv) const std::vector<QuantLib::Date>& %{
        std::vector<ObjectHandler::property_t> $1_name_vec =
            ObjectHandler::operToVector<ObjectHandler::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Date> $1_name_vec2 =
            ObjectHandler::operToVector<QuantLib::Date>(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_rdc) std::vector<QuantLib::Date> %{
        std::vector<long> returnValVec = QuantLibAddin::libraryToVector(returnValue);
        static OPER xRet;
        ObjectHandler::vectorToOper(returnValVec, xRet);
        return &xRet;
%}

%typemap(rp_tm_xll_rdc) QuantLib::Natural %{
        static long ret;
        ret = returnValue;
        return &ret;
%}

%typemap(rp_tm_xll_rdc) QuantLib::DayCounter const & %{
        std::ostringstream os;
        os << returnValue;
        static char ret[XL_MAX_STR_LEN];
        ObjectHandler::stringToChar(os.str(), ret);
        return ret;
%}

%typemap(rp_tm_xll_cll_val) QuantLib::Handle< QuantLib::Quote > const & "$1_name_vo";
%typemap(rp_tm_xll_cll_val) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_vo";
%typemap(rp_tm_xll_cll_val) const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& "$1_name_vec";
%typemap(rp_tm_xll_cll_val) const std::vector<QuantLib::Handle<QuantLib::Quote> >& "$1_name_vec";
%typemap(rp_tm_xll_cll_val) const std::vector<QuantLib::Date>& "$1_name_vec";
%typemap(rp_tm_xll_cll_val) const std::vector<QuantLib::Real>& "$1_name_vec";

%typemap(rp_tm_xll_cll_obj) QuantLib::Period "$1_name_cnv";
%typemap(rp_tm_xll_cll_obj) const QuantLib::Period& "$1_name_cnv";
%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::Quote > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "$1_name_handle";
%typemap(rp_tm_xll_cll_obj) const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& "$1_name_vec2";
%typemap(rp_tm_xll_cll_obj) const std::vector<QuantLib::Handle<QuantLib::Quote> >& "$1_name_vec2";
%typemap(rp_tm_xll_cll_obj) const std::vector<QuantLib::Date>& "$1_name_vec2";

%typemap(rp_tm_xll_ret) QuantLib::Date "long*";
//%typemap(rp_tm_xll_ret) QuantLib::Date & "long*";

%typemap(rp_tm_xll_cod) QuantLib::Period "C";
//%typemap(rp_tm_xll_cod) QuantLib::Frequency const & "C";
%typemap(rp_tm_xll_cod) QuantLib::Date "N";
//%typemap(rp_tm_xll_cod) QuantLib::Date & "N";
%typemap(rp_tm_xll_cod) QuantLib::Handle< QuantLib::Quote > const & "C";
%typemap(rp_tm_xll_cod) QuantLib::Handle< QuantLib::YieldTermStructure > const & "P";
%typemap(rp_tm_xll_cod) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "C";

%typemap(rp_tm_xll_prm) QuantLib::Period "char*";
//%typemap(rp_tm_xll_prm) QuantLib::Frequency const & "char*";
%typemap(rp_tm_xll_prm) QuantLib::Handle< QuantLib::Quote > const & "char*";
%typemap(rp_tm_xll_prm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "OPER*";
%typemap(rp_tm_xll_prm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "char*";

%typemap(rp_tm_xll_rdc) QuantLib::Date %{
        static long returnValueXL;
        returnValueXL = static_cast<long>(QuantLibAddin::libraryToScalar(returnValue));
        return &returnValueXL;
%}

%typemap(rp_tm_xll_rdc) std::vector<QuantLib::Real> %{
        std::vector<double> returnValVec = QuantLibAddin::libraryToVector(returnValue);
        static OPER xRet;
        ObjectHandler::vectorToOper(returnValVec, xRet);
        return &xRet;
%}

%typemap(rp_xll_get) void "";
%typemap(rp_xll_get) SWIGTYPE "$1_type returnValue =";
