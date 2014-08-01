
// rp_ser_* - serialization

//%typemap(rp_ser_cnv) YYY %{
//    QuantLib::Date $1_name =
//        ObjectHandler::convert2<$1_type>(
//            valueObject->getProperty("$1_name"), "$1_name");
//%}

