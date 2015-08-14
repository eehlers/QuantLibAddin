
#include <qlo/conversions/convert2.hpp>
#include <qlo/conversions/cnv_tmpl.hpp>

#include <ql/utilities/dataparsers.hpp>

#include <boost/algorithm/string/case_conv.hpp>

template<> 
QuantLib::Date ObjectHandler::convert2<QuantLib::Date, ObjectHandler::property_t>(const ObjectHandler::property_t& c) {
    return convertDate(c);
}

QuantLib::Period f(const std::string &p_inp) {
    std::string p = boost::algorithm::to_upper_copy(p_inp);
    if ("SW"==p)
        return 1*QuantLib::Weeks;
    else {
        QuantLib::Period pp = QuantLib::PeriodParser::parse(p);
        pp.normalize();
        return pp;
    }
}
