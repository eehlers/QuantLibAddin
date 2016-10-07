
//*****************************************************************************
// rp_tm_xll_* - typemaps for the Excel Addin
//*****************************************************************************

// rp_tm_xll_rtft - function return type (F/M)
%typemap(rp_tm_xll_rtft) QuantLib::Date "long*";
%typemap(rp_tm_xll_rtft) QuantLib::Period "char*";
%typemap(rp_tm_xll_rtft) QuantLib::Currency const & "char*";
%typemap(rp_tm_xll_rtft) QuantLib::InterestRate "double*";

// rp_tm_xll_parm - function parameters (F/C/M)
%typemap(rp_tm_xll_parm) QuantLib::Date "OPER*";
%typemap(rp_tm_xll_parm) QuantLib::Date const & "OPER*";
%typemap(rp_tm_xll_parm) QuantLib::Period "char*";
%typemap(rp_tm_xll_parm) QuantLib::Bond const & "char*";
%typemap(rp_tm_xll_parm) QuantLib::YieldTermStructure const & "char*";
%typemap(rp_tm_xll_parm) boost::shared_ptr<QuantLibAddin::RateHelper> const & "char*";
%typemap(rp_tm_xll_parm) boost::shared_ptr<QuantLib::YieldTermStructure> const & "char*";
//%typemap(rp_tm_xll_parm) boost::shared_ptr<QuantLib::Bond> const & "char*";
%typemap(rp_tm_xll_parm) QuantLib::Handle<QuantLib::YieldTermStructure> const & "OPER*";
%typemap(rp_tm_xll_parm) QuantLib::Handle<QuantLib::Quote> const & "OPER*";
%typemap(rp_tm_xll_parm) QuantLib::Handle<QuantLib::SimpleQuote> const & "char*";
%typemap(rp_tm_xll_parm) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "char*";
%typemap(rp_tm_xll_parm) QuantLib::TimeSeries<QuantLib::Real> const & "OPER*";

// rp_tm_xll_cnvt - convert from Excel datatypes to the datatypes of the underlying Library

%typemap(rp_tm_xll_cnvt) QuantLib::Period %{
        QuantLib::Period $1_name_cnv;
        QuantLibAddin::cppToLibrary($1_name, $1_name_cnv);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Period const & %{
        QuantLib::Period $1_name_cnv;
        QuantLibAddin::cppToLibrary($1_name, $1_name_cnv);
%}

// FIXME in the two typemaps below we allow all date arguments to have a default value.
// This should be done explicitly using rp_tm_xll_cnvt2.
%typemap(rp_tm_xll_cnvt) QuantLib::Date %{
        QuantLib::Date $1_name_cnv = reposit::convert2<QuantLib::Date>(
            reposit::ConvertOper(*$1_name), "$1_name", QuantLib::Date());

        reposit::property_t $1_name_cnv2 = reposit::convert2<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = reposit::convert2<QuantLib::Date>(
            reposit::ConvertOper(*$1_name), "$1_name", QuantLib::Date());

        reposit::property_t $1_name_cnv2 = reposit::convert2<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
%}

// here is the correct typemap for when a default value is specified in the swig iface file.
%typemap(rp_tm_xll_cnvt2) QuantLib::Date %{
        QuantLib::Date $1_name_cnv = reposit::convert2<QuantLib::Date>(
            reposit::ConvertOper(*$1_name), "$1_name", QuantLib::Date());

        reposit::property_t $1_name_cnv2 = reposit::convert2<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
%}

%typemap(rp_tm_xll_cnvt2) QuantLib::Date & %{
        QuantLib::Date $1_name_cnv = reposit::convert2<QuantLib::Date>(
            reposit::ConvertOper(*$1_name), "$1_name", QuantLib::Date());

        reposit::property_t $1_name_cnv2 = reposit::convert2<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Date> %{
        std::vector< QuantLib::Date > $1_name_vec =
            reposit::operToVector< QuantLib::Date >(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Period> %{
        std::vector< QuantLib::Period > $1_name_vec =
            reposit::operToVector< QuantLib::Period >(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Bond const & %{
        RP_GET_UNDERLYING($1_name_cnv, $1_name,
            QuantLibAddin::Bond, QuantLib::Bond)
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Leg const & %{
        RP_GET_UNDERLYING($1_name_cnv, $1_name,
            QuantLibAddin::Leg, QuantLib::Leg)
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Schedule const & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::Schedule, QuantLib::Schedule)
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Calendar const & %{
        QuantLib::Calendar $1_name_enm =
            reposit::Create<QuantLib::Calendar>()($1_name);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::OptimizationMethod & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::OptimizationMethod, QuantLib::OptimizationMethod)
%}

%typemap(rp_tm_xll_cnvt) QuantLib::EndCriteria const & %{
        RP_GET_REFERENCE($1_name_cnv, $1_name,
            QuantLibAddin::EndCriteria, QuantLib::EndCriteria)
%}

%typemap(rp_tm_xll_cnvt) QuantLib::YieldTermStructure const & %{
        RP_GET_OBJECT($1_name_temp, $1_name, reposit::Object)
        boost::shared_ptr<QuantLib::YieldTermStructure> $1_name_temp2 =
            QuantLibAddin::CoerceLibrarySame<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    $1_name_temp);
        const QuantLib::YieldTermStructure &$1_name_cnv =
            *($1_name_temp2.get());
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

%typemap(rp_tm_xll_cnvt) boost::shared_ptr<QuantLib::YieldTermStructure> const & %{
        RP_GET_REFERENCE($1_name_obj, $1_name, QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure)
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
        std::string $1_name_vo = reposit::convert2<std::string>(
            reposit::ConvertOper(*$1_name), "$1_name", "");

        RP_GET_OBJECT_DEFAULT($1_nameCoerce, $1_name_vo, reposit::Object)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLibAddin::CoerceHandle<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    //$1_nameCoerce);
                    $1_nameCoerce, QuantLib::Handle<QuantLib::YieldTermStructure>());
%}

%typemap(rp_tm_xll_cnvt2) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
        std::string $1_name_vo = reposit::convert2<std::string>(
            reposit::ConvertOper(*$1_name), "$1_name", "");

        RP_GET_OBJECT_DEFAULT($1_nameCoerce, $1_name_vo, reposit::Object)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLibAddin::CoerceHandle<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    $1_nameCoerce, $rp_value);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
        RP_GET_REFERENCE($1_name_get, $1_name, QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
        QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name_handle =
            QuantLib::Handle<QuantLib::BlackVolTermStructure>($1_name_get);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::SimpleQuote> const & %{
        RP_GET_OBJECT($1_name_get, $1_name, reposit::Object)
        QuantLib::Handle<QuantLib::SimpleQuote> $1_name_handle =
            QuantLibAddin::CoerceHandle<
                QuantLibAddin::SimpleQuote,
                QuantLib::SimpleQuote>()(
                    $1_name_get);
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Date> const & %{
        std::vector<reposit::property_t> $1_name_vec =
            reposit::operToVector<reposit::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Date> $1_name_vec2 =
            reposit::operToVector<QuantLib::Date>(*$1_name, "$1_name");
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

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> > const & %{
        std::vector<std::string> z =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> > $1_name_vec =
            reposit::getObjectVector<QuantLibAddin::RateHelper>(z);
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLibAddin::Bond> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLibAddin::Bond> > $1_name_vec2 =
            reposit::getObjectVector<QuantLibAddin::Bond>($1_name_vec);
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLib::RateHelper> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::RateHelper> > $1_name_vec2 =
            reposit::getLibraryObjectVector<QuantLibAddin::RateHelper, QuantLib::RateHelper>($1_name_vec);
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLib::InterestRate> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::InterestRate> > $1_name_vec2 =
            reposit::getLibraryObjectVector<QuantLibAddin::InterestRate, QuantLib::InterestRate>($1_name_vec);            
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLib::CalibrationHelper> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::CalibrationHelper> > $1_name_vec2 =
            reposit::getLibraryObjectVector<QuantLibAddin::CalibrationHelper, QuantLib::CalibrationHelper>($1_name_vec);
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLib::FloatingRateCouponPricer> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::FloatingRateCouponPricer> > $1_name_vec2 =
            reposit::getLibraryObjectVector<QuantLibAddin::FloatingRateCouponPricer, QuantLib::FloatingRateCouponPricer>($1_name_vec);
%}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLib::Instrument> > const & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::Instrument> > $1_name_vec2 =
            reposit::getLibraryObjectVector<QuantLibAddin::Instrument, QuantLib::Instrument>($1_name_vec);
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

%typemap(rp_tm_xll_cnvt) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > const & %{
        //std::vector<std::vector<reposit::property_t> > $1_name_vec =
        //    reposit::operToMatrix<reposit::property_t>(*$1_name, "$1_name");
        std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > $1_name_vec2 =
            reposit::operToMatrix<QuantLib::Handle<QuantLib::Quote> >(*$1_name, "$1_name");
%}

// rp_tm_xll_argf - arguments to the underlying Library function
%typemap(rp_tm_xll_argf) QuantLib::Date "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Period "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Period const & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Bond const & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Leg const & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Schedule const & "*$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::OptimizationMethod& "*$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::EndCriteria const & "*$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::YieldTermStructure const & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Handle<QuantLib::SimpleQuote> const & "$1_name_handle";
%typemap(rp_tm_xll_argf) boost::shared_ptr<QuantLibAddin::RateHelper> const & "$1_name_obj";
%typemap(rp_tm_xll_argf) boost::shared_ptr<QuantLib::YieldTermStructure> const & "$1_name_obj";
%typemap(rp_tm_xll_argf) ql_tp_handle "$1_name_handle";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLib::CalibrationHelper> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLib::FloatingRateCouponPricer> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Date> const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Natural> const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLibAddin::Bond> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLib::RateHelper> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLib::InterestRate> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLib::Instrument> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Handle<QuantLib::Quote> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLibAddin::Leg> > const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Leg> const & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> > const & "$1_name_vec";
%typemap(rp_tm_xll_argf) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > const & "$1_name_vec2";

%typemap(rp_tm_xll_argf2) QuantLib::Date "$1_name_cnv";
%typemap(rp_tm_xll_argf2) QuantLib::Date & "$1_name_cnv";
%typemap(rp_tm_xll_argf2) QuantLib::Date const & "$1_name_cnv";

// rp_tm_xll_rtst - return statement (F/M)
%typemap(rp_tm_xll_rtst) QuantLib::Natural %{
        static long ret;
        ret = returnValue;
        return &ret;
%}

%typemap(rp_tm_xll_rtst) QuantLib::Size %{
        static long ret;
        ret = returnValue;
        return &ret;
%}

%typemap(rp_tm_xll_rtst) QuantLib::Period %{
        std::string str = QuantLibAddin::libraryToScalar(returnValue);
        static char ret[XL_MAX_STR_LEN];
        reposit::stringToChar(str, ret);
        return ret;
%}

%typemap(rp_tm_xll_rtst) QuantLib::Period & %{
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

%typemap(rp_tm_xll_rtst) std::vector<std::vector<QuantLib::Real> > %{
        static OPER xRet;
        reposit::matrixToOper(returnValue, xRet);
        return &xRet;
%}

// rp_tm_xll_argfv - arguments to the Value Object constructor (C)
%typemap(rp_tm_xll_argfv) QuantLib::Date "$1_name_cnv2";
%typemap(rp_tm_xll_argfv) QuantLib::Date const & "$1_name_cnv2";
%typemap(rp_tm_xll_argfv) QuantLib::Handle< QuantLib::Quote > const & "$1_name_cnv";
%typemap(rp_tm_xll_argfv) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_vo";

%typemap(rp_tm_xll_argfv2) QuantLib::Date "$1_name_cnv2";
%typemap(rp_tm_xll_argfv2) QuantLib::Date const & "$1_name_cnv2";
%typemap(rp_tm_xll_argfv2) QuantLib::Handle< QuantLib::YieldTermStructure > const & "$1_name_vo";

// rp_tm_xll_cdrt - code to register the return type with Excel
%typemap(rp_tm_xll_cdrt) QuantLib::Period "C";
%typemap(rp_tm_xll_cdrt) QuantLib::Date "N";
%typemap(rp_tm_xll_cdrt) QuantLib::Handle<QuantLib::YieldTermStructure> const & "P";
%typemap(rp_tm_xll_cdrt) QuantLib::Handle<QuantLib::Quote> const & "C";
%typemap(rp_tm_xll_cdrt) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "C";
%typemap(rp_tm_xll_cdrt) QuantLib::InterestRate "E";

// rp_tm_xll_code - code to register the parameter with Excel
%typemap(rp_tm_xll_code) QuantLib::Period "C";
//%typemap(rp_tm_xll_code) QuantLib::Date "N";
%typemap(rp_tm_xll_code) QuantLib::Date "P";
%typemap(rp_tm_xll_code) QuantLib::Date const & "P";
%typemap(rp_tm_xll_code) QuantLib::Bond const & "C";
%typemap(rp_tm_xll_code) QuantLib::YieldTermStructure const & "C";
%typemap(rp_tm_xll_code) boost::shared_ptr<QuantLibAddin::RateHelper> const & "C";
%typemap(rp_tm_xll_code) boost::shared_ptr<QuantLib::YieldTermStructure> const & "C";
%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::Quote> const & "P";
%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::SimpleQuote> const & "C";
%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::YieldTermStructure> const & "P";
%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "C";

%typemap(rp_tm_xll_loop) QuantLib::Date const & "$1_name_cnv";

%typemap(rp_tm_xll_rtdc) QuantLib::Calendar const & %{
        QuantLib::Calendar returnValue =
%}

%typemap(rp_tm_xll_rtdc) QuantLib::Currency const & %{
        QuantLib::Currency returnValue =
%}

%typemap(rp_tm_xxx_rp_get) QuantLib::Quote %{
        RP_GET_REFERENCE(xxx, objectID, QuantLibAddin::Quote, QuantLib::Quote);
%}
