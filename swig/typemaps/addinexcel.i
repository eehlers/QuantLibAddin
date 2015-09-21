
//*****************************************************************************
// rp_tm_xll_* - typemaps for the Excel Addin
//*****************************************************************************

// rp_tm_xll_rtft - function return type (F/M)
%typemap(rp_tm_xll_rtft) QuantLib::Date "long*";
%typemap(rp_tm_xll_rtft) QuantLib::Period "char*";

// rp_tm_xll_parm - function parameters (F/C/M)
%typemap(rp_tm_xll_parm) QuantLib::Period "char*";
%typemap(rp_tm_xll_parm) QuantLib::Handle<QuantLib::YieldTermStructure> const & "OPER*";
%typemap(rp_tm_xll_parm) QuantLib::Handle<QuantLib::Quote> const & "char*";
%typemap(rp_tm_xll_parm) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "char*";
%typemap(rp_tm_xll_parm) QuantLib::Date const & "OPER*";

// rp_tm_xll_cnvt - convert from Excel datatypes to the datatypes of the underlying Library

%typemap(rp_tm_xll_cnvt) QuantLib::Period %{
        QuantLib::Period $1_name_cnv;
        QuantLibAddin::cppToLibrary($1_name, $1_name_cnv);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Period const & %{
        QuantLib::Period $1_name_cnv;
        QuantLibAddin::cppToLibrary($1_name, $1_name_cnv);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Date const & %{
        $rp_typedef_base $1_name_cnv = reposit::convert2<$rp_typedef_base>(
            reposit::ConvertOper(*$1_name), "$1_name", $rp_typedef_base());

        reposit::property_t $1_name_cnv2 = reposit::convert2<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Schedule const & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::Schedule, QuantLib::Schedule)
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Calendar const & %{
        $rp_typedef_base $1_name_enm =
            reposit::Create<$rp_typedef_base>()($1_name);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::OptimizationMethod & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::OptimizationMethod, QuantLib::OptimizationMethod)
%}

%typemap(rp_tm_xll_cnvt) QuantLib::EndCriteria const & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::EndCriteria, QuantLib::EndCriteria)
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Natural> const & %{
        std::vector<long> $1_name_vec =
            reposit::operToVector<long>(*$1_name, "$1_name");
        std::vector<QuantLib::Natural> $1_name_vec2 =
            QuantLibAddin::convertVector<long, QuantLib::Natural>($1_name_vec);
%}

%typemap(rp_tm_xll_cnvt) boost::shared_ptr<QuantLibAddin::RateHelper> const & qlarh %{
        RP_GET_OBJECT($1_name_obj, $1_name, QuantLibAddin::RateHelper);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::Quote> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::Quote, QuantLib::Quote)
        QuantLib::Handle<QuantLib::Quote> $1_name_handle =
            QuantLib::Handle<QuantLib::Quote>($1_name_get);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
        std::string $1_name_vo = reposit::convert2<std::string>(
            reposit::ConvertOper(*$1_name), "$1_name", "");

        RP_GET_OBJECT_DEFAULT($1_nameCoerce, $1_name_vo, reposit::Object)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLibAddin::CoerceHandle<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    $1_nameCoerce, QuantLib::Handle<QuantLib::YieldTermStructure>());
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
        QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
            QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Date> const & %{
        std::vector<reposit::property_t> $1_name_vec =
            reposit::operToVector<reposit::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Date> $1_name_vec2 =
            reposit::operToVector<QuantLib::Date>(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> > const & %{
        std::vector<std::string> z =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> > $1_name_vec =
            reposit::getObjectVector<QuantLibAddin::RateHelper>(z);
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLib::RateHelper> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::RateHelper> > $1_name_vec2 =
            reposit::getLibraryObjectVector<QuantLibAddin::RateHelper, QuantLib::RateHelper>($1_name_vec);
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLib::CalibrationHelper> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::CalibrationHelper> > $1_name_vec2 =
            reposit::getLibraryObjectVector<QuantLibAddin::CalibrationHelper, QuantLib::CalibrationHelper>($1_name_vec);
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Handle<QuantLib::Quote> > const & %{
        std::vector<reposit::property_t> $1_name_vec =
            reposit::operToVector<reposit::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Handle<QuantLib::Quote> > $1_name_vec2 =
            reposit::operToVector<QuantLib::Handle<QuantLib::Quote> >(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLibAddin::Leg> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLibAddin::Leg> > $1_name_vec2 =
            reposit::getObjectVector<QuantLibAddin::Leg>($1_name_vec);
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Leg> const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLibAddin::Leg> > $1_name_vec_temp =
            reposit::getObjectVector<QuantLibAddin::Leg>($1_name_vec);
        std::vector<QuantLib::Leg> $1_name_vec2($1_name_vec_temp.size());
        boost::shared_ptr<QuantLib::Leg> qlLeg;
        for (QuantLib::Size i=0; i<$1_name_vec_temp.size(); ++i) {
            $1_name_vec_temp[i]->getLibraryObject(qlLeg);
            $1_name_vec2[i] = *qlLeg;
        }
%}

// rp_tm_xll_argf - arguments to the underlying Library function
%typemap(rp_tm_xll_argf) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Period "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Period const & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Schedule const & "*$1_name_cnv";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLib::CalibrationHelper> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) QuantLib::OptimizationMethod& "*$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::EndCriteria const & "*$1_name_cnv";
%typemap(rp_tm_xll_argf) ql_tp_handle "$1_name_handle";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Date> const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Natural> const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLib::RateHelper> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Handle<QuantLib::Quote> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLibAddin::Leg> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Leg> const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> > const & "$1_name_vec";

// rp_tm_xll_rtst - return statement (F/M)
%typemap(rp_tm_xll_rtst) QuantLib::Natural %{
        static long ret;
        ret = returnValue;
        return &ret;
%}

%typemap(rp_tm_xll_rtst) QuantLib::BusinessDayConvention %{
        std::ostringstream os;
        os << returnValue;
        static char ret[XL_MAX_STR_LEN];
        reposit::stringToChar(os.str(), ret);
        return ret;
%}

%typemap(rp_tm_xll_rtst) QuantLib::DayCounter const & %{
        std::ostringstream os;
        os << returnValue;
        static char ret[XL_MAX_STR_LEN];
        reposit::stringToChar(os.str(), ret);
        return ret;
%}

%typemap(rp_tm_xll_rtst) QuantLib::Calendar %{
        std::ostringstream os;
        os << returnValue;
        static char ret[XL_MAX_STR_LEN];
        reposit::stringToChar(os.str(), ret);
        return ret;
%}

%typemap(rp_tm_xll_rtst) QuantLib::Period %{
        std::string str = QuantLibAddin::libraryToScalar(returnValue);
        static char ret[XL_MAX_STR_LEN];
        reposit::stringToChar(str, ret);
        return ret;
%}

%typemap(rp_tm_xll_rtst) QuantLib::Date %{
        static long returnValueXL;
        returnValueXL = static_cast<long>(QuantLibAddin::libraryToScalar(returnValue));
        return &returnValueXL;
%}

%typemap(rp_tm_xll_rtst) std::vector<QuantLib::Date> %{
        std::vector<long> returnValVec = QuantLibAddin::libraryToVector(returnValue);
        static OPER xRet;
        reposit::vectorToOper(returnValVec, xRet);
        return &xRet;
%}

%typemap(rp_tm_xll_rtst) std::vector<QuantLib::Real> %{
        std::vector<double> returnValVec = QuantLibAddin::libraryToVector(returnValue);
        static OPER xRet;
        reposit::vectorToOper(returnValVec, xRet);
        return &xRet;
%}

// rp_tm_xll_argfv - arguments to the Value Object constructor (C)
%typemap(rp_tm_xll_argfv) QuantLib::Date const & "$1_name_cnv2";
%typemap(rp_tm_xll_argfv) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_vo";

// rp_tm_xll_code - code to register the parameter with Excel
%typemap(rp_tm_xll_code) QuantLib::Period "C";
%typemap(rp_tm_xll_code) QuantLib::Date "N";
%typemap(rp_tm_xll_code) QuantLib::Date const & "P";
%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::YieldTermStructure> const & "P";
%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::Quote> const & "C";
%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "C";
