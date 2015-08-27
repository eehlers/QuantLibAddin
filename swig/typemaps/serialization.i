
// rp_ser_* - serialization
// These typemaps generate source code for the serialization create functions.
// At present the default behavior is adequate.

%typemap(rp_tm_cre_cnv) QuantLib::Period %{
    std::string $1_name_str =
        ObjectHandler::convert2<std::string>(valueObject->getProperty("$1_name"));
    QuantLib::Period $1_name;
    QuantLibAddin::cppToLibrary($1_name_str, $1_name);
%}

%typemap(rp_tm_cre_cnv) const QuantLib::Period& %{
    std::string $1_name_str =
        ObjectHandler::convert2<std::string>(valueObject->getProperty("$1_name"));
    QuantLib::Period $1_name;
    QuantLibAddin::cppToLibrary($1_name_str, $1_name);
%}

%typemap(rp_tm_cre_cnv) const QuantLib::Handle<QuantLib::Quote>& %{
    ObjectHandler::property_t $1_name_prop =
        valueObject->getProperty("$1_name");
    valueObject->processVariant($1_name_prop);            
    QuantLib::Handle<QuantLib::Quote> $1_name = 
        ObjectHandler::convert2<QuantLib::Handle<QuantLib::Quote> >(
            $1_name_prop, "$1_name");
%}

%typemap(rp_tm_cre_cnv) QuantLib::Handle<QuantLib::YieldTermStructure>& %{
    std::string $1_name_str =
        ObjectHandler::convert2<std::string>(valueObject->getProperty("$1_name"));
    valueObject->processPrecedentID($1_name_str);
    OH_GET_OBJECT_DEFAULT($1_name_coerce, $1_name_str, ObjectHandler::Object)
    QuantLib::Handle<QuantLib::YieldTermStructure> $1_name =
        QuantLibAddin::CoerceHandle<
            QuantLibAddin::YieldTermStructure,
            QuantLib::YieldTermStructure>()(
                $1_name_coerce, QuantLib::Handle<QuantLib::YieldTermStructure>());
%}

%typemap(rp_tm_cre_cnv) const std::vector<QuantLib::Date>& %{
    std::vector<ObjectHandler::property_t> $1_name_vec =
        ObjectHandler::vector::convert2<ObjectHandler::property_t>(valueObject->getProperty("$1_name"), "$1_name");
        std::vector<QuantLib::Date> $1_name =
            ObjectHandler::vector::convert2<QuantLib::Date>($1_name_vec, "$1_name");
%}

%typemap(rp_tm_cre_cnv) const std::vector<boost::shared_ptr<QuantLib::RateHelper> >& %{
    std::vector<std::string> $1_name_vec =
        ObjectHandler::vector::convert2<std::string>(valueObject->getProperty("$1_name"), "$1_name");
    for (std::vector<std::string>::const_iterator i = $1_name_vec.begin();
            i != $1_name_vec.end(); ++i)
        valueObject->processPrecedentID(*i);            
    std::vector<boost::shared_ptr<QuantLib::RateHelper> > $1_name =
        ObjectHandler::getLibraryObjectVector<QuantLibAddin::RateHelper, QuantLib::RateHelper>($1_name_vec);
%}

%typemap(rp_tm_cre_cnv) const std::vector<QuantLib::Handle<QuantLib::Quote> >& %{
    std::vector<ObjectHandler::property_t> $1_name_vec =
        ObjectHandler::vector::convert2<ObjectHandler::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    valueObject->processVariant($1_name_vec);
    std::vector<QuantLib::Handle<QuantLib::Quote> > $1_name =
        ObjectHandler::vector::convert2<QuantLib::Handle<QuantLib::Quote> >($1_name_vec, "$1_name");
%}
