
#include <qlo/objects/obj_instruments.hpp>
#include <ql/instrument.hpp>

QuantLib::Real QuantLibAddin::Instrument::results(const std::string& tag) const {
    return libraryObject_->result<QuantLib::Real>(tag);
}
