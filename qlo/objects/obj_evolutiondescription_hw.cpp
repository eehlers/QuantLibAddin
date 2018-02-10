
// BEGIN buffer b_lib_grp_cpp


#include <qlo/objects/obj_evolutiondescription.hpp>


#include <ql/models/marketmodels/multiproduct.hpp>
#include <ql/models/marketmodels/evolutiondescription.hpp>

QuantLibAddin::EvolutionDescription::EvolutionDescription(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::MarketModelMultiProduct const &Product,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::EvolutionDescription>(properties, permanent) {
    const QuantLib::EvolutionDescription& ev = Product.evolution();
    libraryObject_ = boost::shared_ptr<QuantLib::EvolutionDescription>(new QuantLib::EvolutionDescription(
                // BEGIN typemap rp_tm_default
                ev
                // END   typemap rp_tm_default
    ));
}


// END buffer b_lib_grp_cpp

