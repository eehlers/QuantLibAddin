
// rp_ser_* - serialization
// These typemaps generate source code for the serialization create functions.
// At present the default behavior is adequate.

//%typemap(rp_tm_cre_cnv) YYY %{
//    QuantLib::Date $1_name =
//        ObjectHandler::convert2<$1_type>(
//            valueObject->getProperty("$1_name"), "$1_name");
//%}

%typemap(rp_tm_cre_cnv) QuantLib::Period %{
        std::string $1_name_cpp =
            ObjectHandler::convert2<std::string>(valueObject->getProperty("$1_name_cpp"));
        QuantLib::Period $1_name;
        QuantLibAddin::cppToLibrary($1_name_cpp, $1_name);
%}
