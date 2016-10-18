
// BEGIN buffer b_lib_grp_hpp


#ifndef obj_assetswap_hpp
#define obj_assetswap_hpp

#include <string>
#include <rp/libraryobject.hpp>
#include <rp/valueobject.hpp>
#include <boost/shared_ptr.hpp>
#include <ql/instruments/assetswap.hpp>
#include <qlo/obj_instruments.hpp>

// FIXME get rid of this:
using namespace QuantLib;

namespace QuantLibAddin {

    class AssetSwap : 
        public Instrument {
    public:
        AssetSwap(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            bool payBondCoupon,
            boost::shared_ptr< QuantLib::Bond > const &bond,
            QuantLib::Real bondCleanPrice,
            boost::shared_ptr< QuantLib::IborIndex > const &iborIndex,
            QuantLib::Spread spread,
            QuantLib::Schedule const &floatSchedule,
            QuantLib::DayCounter const &floatingDayCount,
            bool parAssetSwap,
            // END   typemap rp_tm_default
            bool permanent)
        : Instrument(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::Instrument>(new QuantLib::AssetSwap(
                // BEGIN typemap rp_tm_default
                payBondCoupon,
                bond,
                bondCleanPrice,
                iborIndex,
                spread,
                floatSchedule,
                floatingDayCount,
                parAssetSwap
                // END   typemap rp_tm_default
            ));
        }
        std::vector<std::vector<reposit::property_t> > bondLegAnalysis(
                                                    const QuantLib::Date& d) {
            return Swap::legAnalysis(0, d);
        }

        std::vector<std::vector<reposit::property_t> > floatingLegAnalysis(
                                                    const QuantLib::Date& d) {
            return Swap::legAnalysis(1, d);
        }
    };

} // namespace QuantLibAddin

#endif

// END buffer b_lib_grp_hpp

