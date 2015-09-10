
//*****************************************************************************
// rp_tm_scr_* - typemaps for Serialization - Create
//*****************************************************************************

// rp_tm_scr_cnvt - convert types from the Value Object to the corresponding Library Object

%typemap(rp_tm_scr_cnvt) QuantLib::Period const & %{
    std::string $1_name_str =
        reposit::convert2<std::string>(valueObject->getProperty("$1_name"));
    QuantLib::Period $1_name;
    QuantLibAddin::cppToLibrary($1_name_str, $1_name);
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::Quote> const & %{
    reposit::property_t $1_name_prop =
        valueObject->getProperty("$1_name");
    valueObject->processVariant($1_name_prop);            
    QuantLib::Handle<QuantLib::Quote> $1_name = 
        reposit::convert2<QuantLib::Handle<QuantLib::Quote> >(
            $1_name_prop, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> const & %{
    std::string $1_name_str =
        reposit::convert2<std::string>(valueObject->getProperty("$1_name"));
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
        reposit::convert2<std::string>(valueObject->getProperty("$1_name"));
    valueObject->processPrecedentID($1_name_str);
    RP_GET_OBJECT_DEFAULT($1_name_coerce, $1_name_str, reposit::Object)
    QuantLib::Handle<QuantLib::BlackVolTermStructure> $1_name =
        QuantLibAddin::CoerceHandle<
            QuantLibAddin::BlackVolTermStructure,
            QuantLib::BlackVolTermStructure>()(
                $1_name_coerce, QuantLib::Handle<QuantLib::BlackVolTermStructure>());
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Natural> const & %{
   std::vector<long> $1_name_vec =
        reposit::vector::convert2<long>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Natural> $1_name =
        QuantLibAddin::convertVector<long, QuantLib::Natural>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Real> const & %{
   std::vector<double> $1_name_vec =
        reposit::vector::convert2<double>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Real> $1_name =
        QuantLibAddin::convertVector<double, QuantLib::Real>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Rate> const & %{
   std::vector<double> $1_name_vec =
        reposit::vector::convert2<double>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Rate> $1_name =
        QuantLibAddin::convertVector<double, QuantLib::Rate>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Spread> const & %{
   std::vector<double> $1_name_vec =
        reposit::vector::convert2<double>(valueObject->getProperty("$1_name"), "$1_name");
   std::vector<QuantLib::Spread> $1_name =
        QuantLibAddin::convertVector<double, QuantLib::Spread>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Date> const & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert2<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    std::vector<QuantLib::Date> $1_name =
        reposit::vector::convert2<QuantLib::Date>($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<boost::shared_ptr<QuantLib::RateHelper> > const & %{
    std::vector<std::string> $1_name_vec =
        reposit::vector::convert2<std::string>(valueObject->getProperty("$1_name"), "$1_name");
    for (std::vector<std::string>::const_iterator i = $1_name_vec.begin();
            i != $1_name_vec.end(); ++i)
        valueObject->processPrecedentID(*i);            
    std::vector<boost::shared_ptr<QuantLib::RateHelper> > $1_name =
        reposit::getLibraryObjectVector<QuantLibAddin::RateHelper, QuantLib::RateHelper>($1_name_vec);
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Handle<QuantLib::Quote> > const & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert2<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    valueObject->processVariant($1_name_vec);
    std::vector<QuantLib::Handle<QuantLib::Quote> > $1_name =
        reposit::vector::convert2<QuantLib::Handle<QuantLib::Quote> >($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Leg> const & %{
        // FIXME temporary hack to allow create_instruments.cpp to compile under Linux.
        // For the moment we have no need to deserialize a swap.
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

