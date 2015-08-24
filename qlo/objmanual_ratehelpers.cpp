
#include <qlo/objmanual_ratehelpers.hpp>
#include <qlo/conversions/convert2.hpp>

// Within each of the RateHelper classes we want to remember the ID
// of the associated Rate object.  So below we coerce that input
// into a string.  If the caller passed in a double instead of a
// Rate object then the coerce below will fail in which case we
// return an empty string.
std::string f(const ObjectHandler::property_t &p) {
    try {
        return ObjectHandler::convert2<std::string>(p);
    } catch(...) {
        return std::string();
    }
}

QuantLib::Date QuantLibAddin::RateHelper::earliestDate() {
    return libraryObject_->earliestDate();
}

QuantLib::Date QuantLibAddin::RateHelper::latestDate() {
    return libraryObject_->latestDate();
}

QuantLibAddin::FuturesRateHelper::FuturesRateHelper(
        const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::Quote>& price,
        QuantLib::Futures::Type type,
        const QuantLib::Date& date,
        const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
        const QuantLib::Handle<QuantLib::Quote>& convAdj,
        bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::FuturesRateHelper(price, date, iborIndex,convAdj,type));
    quoteName_ = f(properties->getSystemProperty("Price"));
}


QuantLibAddin::FraRateHelper::FraRateHelper(
        const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::Quote>& rate,
        QuantLib::Period periodToStart,
        const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
        bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::FraRateHelper(rate, periodToStart, iborIndex));
    quoteName_ = f(properties->getSystemProperty("Rate"));
}


QuantLibAddin::OISRateHelper::OISRateHelper(
                    const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
                    QuantLib::Natural settlementDays,
                    const QuantLib::Period& tenor,
                    const QuantLib::Handle<QuantLib::Quote>& fixedRate,
                    const boost::shared_ptr<QuantLib::OvernightIndex>& overnightIndex,
                    const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,
                    bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::OISRateHelper>(new
        QuantLib::OISRateHelper(settlementDays,
                                tenor,
                                fixedRate,
                                overnightIndex));
    quoteName_ = f(properties->getSystemProperty("FixedRate"));
}

QuantLibAddin::DatedOISRateHelper::DatedOISRateHelper(
                    const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
                    const QuantLib::Date& startDate,
                    const QuantLib::Date& endDate,
                    const QuantLib::Handle<QuantLib::Quote>& fixedRate,
                    const boost::shared_ptr<QuantLib::OvernightIndex>& overnightIndex,
                    const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,
                    bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::DatedOISRateHelper>(new
        QuantLib::DatedOISRateHelper(startDate, endDate,
                                     fixedRate,
                                     overnightIndex));
    quoteName_ = f(properties->getSystemProperty("FixedRate"));
}