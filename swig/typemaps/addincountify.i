
//*****************************************************************************
// rp_tm_cfy_* - typemaps for the =countify Addin
//*****************************************************************************

// rp_tm_cfy_rtfn - Function return type (F)

// rp_tm_cfy_rtmb - return value of a member function (M)
%typemap(rp_tm_cfy_rtmb) QuantLib::Date "long";

// rp_tm_cfy_parm - function parameters (F/C/M)
%typemap(rp_tm_cfy_parm) QuantLib::Date "long $1_name_cfy"
%typemap(rp_tm_cfy_parm) QuantLib::Date const & "long $1_name_cfy"
%typemap(rp_tm_cfy_parm) QuantLib::Handle< QuantLib::Quote > const & "const char * $1_name";
%typemap(rp_tm_cfy_parm) QuantLib::Handle< QuantLib::YieldTermStructure > const & "const char * $1_name";
%typemap(rp_tm_cfy_parm) QuantLib::Handle< QuantLib::BlackVolTermStructure > const & "const char * $1_name";

// rp_tm_cfy_cnvt - convert input values from =countify datatypes into datatypes of the underlying Library (F/C/M)
%typemap(rp_tm_cfy_cnvt) QuantLib::Date %{
        reposit::property_t $1_name($1_name_cfy);
        QuantLib::Date $1_name_cnv = $1_name_cfy ?
            reposit::convert2<QuantLib::Date, reposit::property_t>($1_name) :
            QuantLib::Date();
%}
%typemap(rp_tm_cfy_cnvt) QuantLib::Date const & %{
        reposit::property_t $1_name($1_name_cfy);
        QuantLib::Date $1_name_cnv = $1_name_cfy ?
            reposit::convert2<QuantLib::Date, reposit::property_t>($1_name) :
            QuantLib::Date();
%}

%typemap(rp_tm_cfy_cnvt) QuantLib::Period const & %{
        QuantLib::Period $1_name_cnv;
        QuantLibAddin::cppToLibrary($1_name, $1_name_cnv);
%}

// rp_tm_cfy_rtdf - declare variable to capture return value of Library function (FM)

// rp_tm_cfy_rtdm - declare variable to capture return value of Library function (FM)
%typemap(rp_tm_cfy_rtdm) QuantLib::Date "QuantLib::Date returnValue =";

// rp_tm_cfy_args - arguments to pass to underlying Library function
%typemap(rp_tm_cfy_args) QuantLib::Date "$1_name_cnv";
%typemap(rp_tm_cfy_args) QuantLib::Date const & "$1_name_cnv";
%typemap(rp_tm_cfy_args) QuantLib::Period const & "$1_name_cnv";

// rp_tm_cfy_rtsf - return statement (F)

// rp_tm_cfy_rtsm - return statement of a Library member function (M)
%typemap(rp_tm_cfy_rtsm) QuantLib::Date "return returnValue.serialNumber();";

// rp_tm_cfy_rtex - return statement in the event of an exception



// rp_tm_cfy_mngo - generate the json to register functions with the mongo database
%typemap(rp_tm_cfy_mngo) QuantLib::Date "INT64";
%typemap(rp_tm_cfy_mngo) QuantLib::Date const & "INT64";

%typemap(rp_tm_cfy_parm) std::vector<QuantLib::Real> const & "FLYLIB_OPAQUE $1_name_vec"
%typemap(rp_tm_cfy_parm) std::vector<QuantLib::Natural> const & "FLYLIB_OPAQUE $1_name_vec"
%typemap(rp_tm_cfy_parm) std::vector<QuantLib::Rate> const & "FLYLIB_OPAQUE $1_name_vec"
%typemap(rp_tm_cfy_parm) std::vector<QuantLib::Spread> const & "FLYLIB_OPAQUE $1_name_vec"

%typemap(rp_tm_cfy_cnvt) std::vector<QuantLib::Real> const & %{
        std::vector<double> $1_name = f1($1_name_vec);
%}
%typemap(rp_tm_cfy_cnvt) std::vector<QuantLib::Natural> const & %{
        std::vector<long> $1_name = f2($1_name_vec);
        std::vector<QuantLib::Natural> $1_name_vec2 =
            QuantLibAddin::convertVector<long, QuantLib::Natural>($1_name);
%}
%typemap(rp_tm_cfy_cnvt) std::vector<QuantLib::Rate> const & %{
        std::vector<double> $1_name = f1($1_name_vec);
%}
%typemap(rp_tm_cfy_cnvt) std::vector<QuantLib::Spread> const & %{
        std::vector<double> $1_name = f1($1_name_vec);
%}

%typemap(rp_tm_cfy_args) std::vector<QuantLib::Real> const & "$1_name";
%typemap(rp_tm_cfy_args) std::vector<QuantLib::Natural> const & "$1_name_vec2";
%typemap(rp_tm_cfy_args) std::vector<QuantLib::Rate> const & "$1_name";
%typemap(rp_tm_cfy_args) std::vector<QuantLib::Spread> const & "$1_name";

%typemap(rp_tm_cfy_mngo) std::vector<QuantLib::Real> const & "CSTR[][]";
%typemap(rp_tm_cfy_mngo) std::vector<QuantLib::Natural> const & "CSTR[][]";
%typemap(rp_tm_cfy_mngo) std::vector<QuantLib::Rate> const & "CSTR[][]";
%typemap(rp_tm_cfy_mngo) std::vector<QuantLib::Spread> const & "CSTR[][]";

%typemap(rp_tm_cfy_parm) std::vector<QuantLib::Date> const & "FLYLIB_OPAQUE $1_name_vec"
%typemap(rp_tm_cfy_parm) std::vector<boost::shared_ptr<QuantLibAddin::Leg> > const & "FLYLIB_OPAQUE $1_name_vec"

%typemap(rp_tm_cfy_cnvt) std::vector<QuantLib::Date> const & %{
        std::vector<reposit::property_t> $1_name = f3($1_name_vec);
        std::vector<QuantLib::Date> $1_name_vec2 = f5($1_name_vec);
%}

%typemap(rp_tm_cfy_cnvt) std::vector<boost::shared_ptr<QuantLibAddin::Leg>> const & %{
        std::vector<std::string> $1_name = f4($1_name_vec);
        std::vector<boost::shared_ptr<QuantLibAddin::Leg> > $1_name_vec2 =
            reposit::getObjectVector<QuantLibAddin::Leg>($1_name);
%}

%typemap(rp_tm_cfy_args) std::vector<QuantLib::Date> const & "$1_name_vec2";
%typemap(rp_tm_cfy_args) std::vector<boost::shared_ptr<QuantLibAddin::Leg>> const & "$1_name_vec2";

%typemap(rp_tm_cfy_mngo) std::vector<QuantLib::Date> const & "CSTR[][]";
%typemap(rp_tm_cfy_mngo) std::vector<boost::shared_ptr<QuantLibAddin::Leg>> const & "CSTR[][]";

%typemap(rp_tm_cfy_parm) std::vector<bool> const & "FLYLIB_OPAQUE $1_name_vec"
%typemap(rp_tm_cfy_parm) std::vector<QuantLib::Leg> const & "FLYLIB_OPAQUE $1_name_vec"

%typemap(rp_tm_cfy_cnvt) std::vector<bool> const & %{
        std::vector<bool> $1_name = f6($1_name_vec);
%}
%typemap(rp_tm_cfy_cnvt) std::vector<QuantLib::Leg> const & %{
        std::vector<std::string> $1_name = f4($1_name_vec);
        std::vector<boost::shared_ptr<QuantLibAddin::Leg> > $1_name_vec_temp =
            reposit::getObjectVector<QuantLibAddin::Leg>($1_name);
        std::vector<QuantLib::Leg> $1_name_vec2($1_name_vec_temp.size());
        boost::shared_ptr<QuantLib::Leg> qlLeg;
        for (QuantLib::Size i=0; i<$1_name_vec_temp.size(); ++i) {
            $1_name_vec_temp[i]->getLibraryObject(qlLeg);
            $1_name_vec2[i] = *qlLeg;
        }
%}

%typemap(rp_tm_cfy_args) std::vector<bool> const & "$1_name";
%typemap(rp_tm_cfy_args) std::vector<QuantLib::Leg> const & "$1_name_vec2";

%typemap(rp_tm_cfy_mngo) std::vector<bool> const & "CSTR[][]";
%typemap(rp_tm_cfy_mngo) std::vector<QuantLib::Leg> const & "CSTR[][]";

