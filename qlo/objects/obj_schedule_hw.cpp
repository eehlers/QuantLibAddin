
#include <qlo/objects/obj_schedule.hpp>
#include <ql/time/schedule.hpp>

QuantLibAddin::Schedule::Schedule(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            boost::shared_ptr< QuantLib::Schedule > const &OriginalSchedule,
            QuantLib::Date const &TruncationDate,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::Schedule>(properties, permanent) {
        libraryObject_ = boost::shared_ptr<QuantLib::Schedule>(new
            QuantLib::Schedule(OriginalSchedule->until(TruncationDate)));
}
