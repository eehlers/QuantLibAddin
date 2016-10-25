
//*****************************************************************************
// rp_tm_scr_* - typemaps for Serialization - Create
//*****************************************************************************

// rp_tm_scr_cnvt - convert types from the Value Object to the corresponding Library Object

%typemap(rp_tm_scr_cnvt) QuantLib::Period const & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    QuantLib::Period $1_name;
    QuantLibAddin::cppToLibrary($1_name_str, $1_name);
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Date const & %{
    QuantLib::Date $1_name =
        reposit::convert<QuantLib::Date>(
            valueObject->getProperty("$1_name"));
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Schedule const & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    RP_GET_REFERENCE($1_name_obj, $1_name_str,
        QuantLibAddin::Schedule, QuantLib::Schedule)
    const QuantLib::Schedule &$1_name = *$1_name_obj;
    valueObject->processPrecedentID($1_name_str);
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Leg const & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    RP_GET_REFERENCE($1_name_obj, $1_name_str,
        QuantLibAddin::Leg, QuantLib::Leg)
    const QuantLib::Leg &$1_name = *$1_name_obj;
    valueObject->processPrecedentID($1_name_str);
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::Quote> const & %{
    reposit::property_t $1_name_prop =
        valueObject->getProperty("$1_name");
    valueObject->processVariant($1_name_prop);
    QuantLib::Handle<QuantLib::Quote> $1_name =
        reposit::convert<QuantLib::Handle<QuantLib::Quote> >(
            $1_name_prop, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
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

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    valueObject->processPrecedentID($1_name_str);
    RP_GET_OBJECT_DEFAULT($1_name_coerce, $1_name_str, reposit::Object)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name =
        QuantLibAddin::CoerceHandle<
            QuantLibAddin::BlackVolTermStructure,
            QuantLib::BlackVolTermStructure>()(
                $1_name_coerce, QuantLib::Handle<QuantLib::BlackVolTermStructure>());
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::SwaptionVolatilityStructure> const & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    valueObject->processPrecedentID($1_name_str);
    RP_GET_OBJECT_DEFAULT($1_name_coerce, $1_name_str, reposit::Object)
    QuantLib::Handle<QuantLib::SwaptionVolatilityStructure> $1_name =
        QuantLibAddin::CoerceHandle<
            QuantLibAddin::SwaptionVolatilityStructure,
            QuantLib::SwaptionVolatilityStructure>()(
                $1_name_coerce, QuantLib::Handle<QuantLib::SwaptionVolatilityStructure>());
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::DefaultProbabilityTermStructure> const & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    valueObject->processPrecedentID($1_name_str);
    RP_GET_OBJECT_DEFAULT($1_name_coerce, $1_name_str, reposit::Object)
    QuantLib::Handle<QuantLib::DefaultProbabilityTermStructure> $1_name =
        QuantLibAddin::CoerceHandle<
            QuantLibAddin::DefaultProbabilityTermStructure,
            QuantLib::DefaultProbabilityTermStructure>()(
                $1_name_coerce, QuantLib::Handle<QuantLib::DefaultProbabilityTermStructure>());
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Natural> const & %{
   std::vector<long> $1_name_vec =
        reposit::vector::convert<long>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Natural> $1_name =
        QuantLibAddin::convertVector<long, QuantLib::Natural>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Integer> const & %{
   std::vector<long> $1_name_vec =
        reposit::vector::convert<long>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Integer> $1_name =
        QuantLibAddin::convertVector<long, QuantLib::Integer>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Real> const & %{
   std::vector<double> $1_name_vec =
        reposit::vector::convert<double>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Real> $1_name =
        QuantLibAddin::convertVector<double, QuantLib::Real>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Rate> const & %{
   std::vector<double> $1_name_vec =
        reposit::vector::convert<double>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Rate> $1_name =
        QuantLibAddin::convertVector<double, QuantLib::Rate>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Spread> const & %{
   std::vector<double> $1_name_vec =
        reposit::vector::convert<double>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Spread> $1_name =
        QuantLibAddin::convertVector<double, QuantLib::Spread>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Date> const & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    std::vector<QuantLib::Date> $1_name =
        reposit::vector::convert<QuantLib::Date>($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Period> const & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    std::vector<QuantLib::Period> $1_name =
        reposit::vector::convert<QuantLib::Period>($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<boost::shared_ptr<QuantLib::RateHelper> > const & %{
    std::vector<std::string> $1_name_vec =
        reposit::vector::convert<std::string>(valueObject->getProperty("$1_name"), "$1_name");
    for (std::vector<std::string>::const_iterator i = $1_name_vec.begin();
            i != $1_name_vec.end(); ++i)
        valueObject->processPrecedentID(*i);
    std::vector<boost::shared_ptr<QuantLib::RateHelper> > $1_name =
        reposit::getLibraryObjectVector<QuantLibAddin::RateHelper, QuantLib::RateHelper>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<boost::shared_ptr<QuantLib::InterestRate> > const & %{
    std::vector<std::string> $1_name_vec =
        reposit::vector::convert<std::string>(valueObject->getProperty("$1_name"), "$1_name");
    for (std::vector<std::string>::const_iterator i = $1_name_vec.begin();
            i != $1_name_vec.end(); ++i)
        valueObject->processPrecedentID(*i);
    std::vector<boost::shared_ptr<QuantLib::InterestRate> > $1_name =
        reposit::getLibraryObjectVector<QuantLibAddin::InterestRate, QuantLib::InterestRate>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<boost::shared_ptr<QuantLib::Issuer> > const & %{
    std::vector<std::string> $1_name_vec =
        reposit::vector::convert<std::string>(valueObject->getProperty("$1_name"), "$1_name");
    for (std::vector<std::string>::const_iterator i = $1_name_vec.begin();
            i != $1_name_vec.end(); ++i)
        valueObject->processPrecedentID(*i);
    std::vector<boost::shared_ptr<QuantLib::Issuer> > $1_name =
        reposit::getLibraryObjectVector<QuantLibAddin::Issuer, QuantLib::Issuer>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<boost::shared_ptr<QuantLib::DefaultProbabilityHelper> > const & %{
    std::vector<std::string> $1_name_vec =
        reposit::vector::convert<std::string>(valueObject->getProperty("$1_name"), "$1_name");
    for (std::vector<std::string>::const_iterator i = $1_name_vec.begin();
            i != $1_name_vec.end(); ++i)
        valueObject->processPrecedentID(*i);
    std::vector<boost::shared_ptr<QuantLib::DefaultProbabilityHelper> > $1_name =
        reposit::getLibraryObjectVector<QuantLibAddin::DefaultProbabilityHelper, QuantLib::DefaultProbabilityHelper>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Handle<QuantLib::Quote> > const & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    valueObject->processVariant($1_name_vec);
    std::vector<QuantLib::Handle<QuantLib::Quote> > $1_name =
        reposit::vector::convert<QuantLib::Handle<QuantLib::Quote> >($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > const & %{
    std::vector<std::vector<reposit::property_t> > $1_name_vec =
        reposit::matrix::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    valueObject->processVariant($1_name_vec);
    std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > $1_name =
        reposit::matrix::convert<QuantLib::Handle<QuantLib::Quote> >($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Leg> const & %{
        // FIXME temporary hack to allow create_instruments.cpp to compile under Linux.
        // For the moment we have no need to deserialize a leg.
        std::vector<QuantLib::Leg> $1_name;
        //std::vector<std::string> $1_name_vec =
        //    reposit::operToVector<std::string>(*$1_name, "$1_name");
        //std::vector<boost::shared_ptr<QuantLibAddin::Leg> > $1_name_vec_temp =
        //    reposit::getObjectVector<QuantLibAddin::Leg>($1_name_vec);
        //std::vector<QuantLib::Leg> $1_name_vec2($1_name_vec_temp.size());
        //boost::shared_ptr<QuantLib::Leg> qlLeg;
        //for (QuantLib::Size i=0; i<$1_name_vec_temp.size(); ++i) {
        //    $1_name_vec_temp[i]->getLibraryObject(qlLeg);
        //    $1_name_vec2[i] = *qlLeg;
        //}
%}

%typemap(rp_tm_scr_cnvt) std::vector<boost::shared_ptr<QuantLibAddin::Leg> > const & %{
        // FIXME temporary hack to allow create_leg.cpp to compile under Linux.
        // For the moment we have no need to deserialize a leg.
        std::vector< boost::shared_ptr< QuantLibAddin::Leg > > legs;
%}

