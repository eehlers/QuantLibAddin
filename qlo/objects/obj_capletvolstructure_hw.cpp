
#include <qlo/objects/obj_capletvolstructure.hpp>

#include <ql/termstructures/volatility/optionlet/constantoptionletvol.hpp>
#include <ql/termstructures/volatility/optionlet/spreadedoptionletvol.hpp>
#include <ql/termstructures/volatility/capfloor/capfloortermvolcurve.hpp>
#include <ql/termstructures/volatility/capfloor/capfloortermvolsurface.hpp>
#include <ql/termstructures/volatility/optionlet/strippedoptionletadapter.hpp>
#include <ql/termstructures/volatility/optionlet/optionletstripper1.hpp>
#include <ql/termstructures/volatility/optionlet/optionletstripper2.hpp>
#include <ql/termstructures/volatility/optionlet/strippedoptionlet.hpp>

QuantLibAddin::OptionletStripper1::OptionletStripper1(
                    const boost::shared_ptr<reposit::ValueObject>& properties,
                    const boost::shared_ptr<QuantLib::CapFloorTermVolSurface>& s,
                    const boost::shared_ptr<QuantLib::IborIndex>& index,
                    QuantLib::Rate switchStrike,
                    QuantLib::Real accuracy,
                    QuantLib::Natural maxIterations,
                    QuantLib::VolatilityType type,
                    QuantLib::Real shift,
                    bool permanent)
: OptionletStripper(properties, permanent)
{
    libraryObject_ = boost::shared_ptr<QuantLib::OptionletStripper1>(new
        QuantLib::OptionletStripper1(s,
                                     index,
                                     switchStrike,
                                     accuracy,
                                     maxIterations,
                                     QuantLib::Handle<QuantLib::YieldTermStructure>(),
                                     type,
                                     shift));
}
