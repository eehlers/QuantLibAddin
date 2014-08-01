
// rp_ser_* - serialization
// These typemaps generate source code for the serialization create functions.
// At present the default behavior is adequate.

//%typemap(rp_ser_cnv) YYY %{
//    QuantLib::Date $1_name =
//        ObjectHandler::convert2<$1_type>(
//            valueObject->getProperty("$1_name"), "$1_name");
//%}

