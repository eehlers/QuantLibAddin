//*****************************************************************************
// rp_tm_lib_* - typemaps for Library Objects
//*****************************************************************************

// GROUP

// HPP

// Not a real typemap. Defined in code.  RP_OBJ_CLASS (C)
// rp_tm_lib_cls

// CPP

// rp_tm_lib_rtst - Return statement (F)

//*****************************************************************************
// rp_tm_vob_* - typemaps for Value Objects
//*****************************************************************************

// GROUP

// XPP

// rp_tm_vob_parm - Value Object constructor parameters (C)

%typemap(rp_tm_vob_parm) std::vector<QuantLib::Date > & "const std::vector<reposit::property_t>&";

// HPP

// rp_tm_vob_mbvr - Value Object class member variables (C)

%typemap(rp_tm_vob_mbvr) std::vector<QuantLib::Date > & "std::vector<reposit::property_t> $1_name_";

// rp_tm_vob_srmv - code to serialize a Value Object member variable (C)

// CPP

// rp_tm_vob_name - Insert the parameter name into the vo property names array (C)

// rp_tm_vob_init - vo ctor initializer list (C)

// rp_tm_vob_cnvt - in ValueObject::setSystemProperty, convert value from property_t to native type (C)

%typemap(rp_tm_vob_cnvt) std::vector<QuantLib::Date> & "reposit::vector::convert<reposit::property_t>(value, nameUpper)";

//*****************************************************************************
// rp_tm_scr_* - typemaps for Serialization - Create
//*****************************************************************************

// GROUP

// CPP

// rp_tm_scr_cnvt - convert types from the Value Object to the corresponding Library Object (C)

%typemap(rp_tm_scr_cnvt) QuantLib::Period & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    QuantLib::Period $1_name = QuantLibAddin::Get<std::string, QuantLib::Period>()($1_name_str);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Real> & %{
   std::vector<double> $1_name_vec =
        reposit::vector::convert<double>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Real> $1_name =
        QuantLibAddin::convertVector<double, QuantLib::Real>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Date> & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    std::vector<QuantLib::Date> $1_name =
        reposit::vector::convert<QuantLib::Date>($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::Quote> & %{
    reposit::property_t $1_name_prop =
        valueObject->getProperty("$1_name");
    valueObject->processVariant($1_name_prop);
    QuantLib::Handle<QuantLib::Quote> $1_name =
        reposit::convert<QuantLib::Handle<QuantLib::Quote> >(
            $1_name_prop, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    valueObject->processPrecedentID($1_name_str);
    RP_GET_OBJECT_DEFAULT($1_name_coerce, $1_name_str, reposit::Object)
    QuantLib::Handle<QuantLib::YieldTermStructure> $1_name =
        QuantLibAddin::CoerceHandle<
            QuantLibAddin::YieldTermStructure,
            QuantLib::YieldTermStructure>()(
                $1_name_coerce, QuantLib::Handle<QuantLib::YieldTermStructure>());
%}

//*****************************************************************************
// rp_tm_cpp_* - typemaps for the C++ Addin
//*****************************************************************************

// GROUP

// XPP

// rp_tm_cpp_rttp - Function return type (F)

// rp_tm_cpp_parm - Function input parameter (F/C/M)

// rp_tm_cpp_rtmb - return type of a member function (M)

// CPP

// rp_tm_cpp_cnvt - Convert inputs from C++ Addin api types into underlying Library types (F/C/M)

// rp_tm_cpp_rtdc - declare variable to capture return value of Library function (F/M)

// rp_tm_cpp_rtst - return statement (F/M)

// rp_tm_cpp_args - arguments to the underlying Library function (F/C/M)

//*****************************************************************************
// rp_tm_xll_* - typemaps for the Excel Addin
//*****************************************************************************

// GROUP

// CPP

// rp_tm_xll_rtft - function return type (F/M)

%typemap(rp_tm_xll_rtft) QuantLib::Date "long*";
//%typemap(rp_tm_xll_rtft) QuantLib::Period "char*";

// rp_tm_xll_parm - function parameters (F/C/M)

//%typemap(rp_tm_xll_parm) QuantLib::Period & "char*";

// rp_tm_xll_cnvt - convert from Excel datatypes to the datatypes of the underlying Library

%typemap(rp_tm_xll_cnvt) QuantLib::Period & %{
        QuantLib::Period $1_name_cnv = QuantLibAddin::Get<std::string, QuantLib::Period>()($1_name);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Date & %{
        QuantLib::Date $1_name_cnv = reposit::convert<QuantLib::Date>(
            reposit::ConvertOper(*$1_name), "$1_name", QuantLib::Date());

        //reposit::property_t $1_name_cnv2 = reposit::convert<reposit::property_t>(
        //    reposit::ConvertOper(*$1_name));
%}

%typemap(rp_tm_xll_cnvt2) QuantLib::Date & %{
        QuantLib::Date $1_name_cnv = reposit::convert<QuantLib::Date>(
            reposit::ConvertOper(*$1_name), "$1_name", QuantLib::Date());

        //reposit::property_t $1_name_cnv2 = reposit::convert<reposit::property_t>(
        //    reposit::ConvertOper(*$1_name));
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> & %{
        std::string $1_name_vo = reposit::convert<std::string>(
            reposit::ConvertOper(*$1_name), "$1_name", "");

        RP_GET_OBJECT_DEFAULT($1_nameCoerce, $1_name_vo, reposit::Object)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLibAddin::CoerceHandle<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    //$1_nameCoerce);
                    $1_nameCoerce, QuantLib::Handle<QuantLib::YieldTermStructure>());
%}

%typemap(rp_tm_xll_cnvt2) QuantLib::Handle<QuantLib::YieldTermStructure> & %{
        std::string $1_name_vo = reposit::convert<std::string>(
            reposit::ConvertOper(*$1_name), "$1_name", "");

        RP_GET_OBJECT_DEFAULT($1_nameCoerce, $1_name_vo, reposit::Object)
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle =
            QuantLibAddin::CoerceHandle<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    $1_nameCoerce, $rp_value);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::Quote> & %{
        reposit::property_t $1_name_cnv = reposit::convert<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
        QuantLib::Handle<QuantLib::Quote> $1_name_handle = 
            reposit::convert<QuantLib::Handle<QuantLib::Quote> >(
                reposit::ConvertOper(*$1_name), "$1_name");
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Date> & %{
        std::vector<reposit::property_t> $1_name_vec =
            reposit::operToVector<reposit::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Date> $1_name_vec2 =
            reposit::operToVector<QuantLib::Date>(*$1_name, "$1_name");
%}

// rp_tm_xll_argfv - arguments to the Value Object constructor (C)

%typemap(rp_tm_xll_argf) QuantLib::Period "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Period & "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Date "$1_name_cnv";
%typemap(rp_tm_xll_argf) QuantLib::Date & "$1_name_cnv";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Date> & "$1_name_vec2";

// rp_tm_xll_argf - arguments to the underlying Library function (F/C/M)

// rp_tm_xll_rtdc - declare variable to capture return value of Library function (F/M)

// rp_tm_xll_rtst - return statement (F/M)

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

%typemap(rp_tm_xll_rtst) std::vector<QuantLib::Real> %{
        std::vector<double> returnValVec = QuantLibAddin::libraryToVector(returnValue);
        static OPER xRet;
        reposit::vectorToOper(returnValVec, xRet);
        return &xRet;
%}

%typemap(rp_tm_xll_rtst) std::vector<QuantLib::Date> %{
        std::vector<long> returnValVec = QuantLibAddin::libraryToVector(returnValue);
        static OPER xRet;
        reposit::vectorToOper(returnValVec, xRet);
        return &xRet;
%}

// rp_tm_xll_cdrt - code to register the return type with Excel

//%typemap(rp_tm_xll_cdrt) QuantLib::Period "C";
%typemap(rp_tm_xll_cdrt) QuantLib::Date "N";

// rp_tm_xll_code - code to register the parameter with Excel

%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::Quote> & "P";

//%typemap(rp_tm_xll_code) QuantLib::Period & "C";
%typemap(rp_tm_xll_code) QuantLib::Date & "P";

// rp_tm_xll_loop - arguments to boost::bind object for a looping function (F/M)

%typemap(rp_tm_xll_loop) QuantLib::Date & "$1_name_cnv";
