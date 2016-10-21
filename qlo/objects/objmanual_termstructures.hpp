
// BEGIN buffer b_lib_grp_hpp


#ifndef obj_termstructures_hpp
#define obj_termstructures_hpp

#include <string>
#include <rp/libraryobject.hpp>
#include <rp/valueobject.hpp>
#include <boost/shared_ptr.hpp>
#include <ql/termstructures/yield/flatforward.hpp>
#include <ql/termstructures/yield/discountcurve.hpp>
#include <ql/termstructures/yield/zerocurve.hpp>
#include <ql/termstructures/yield/forwardspreadedtermstructure.hpp>
#include <ql/termstructures/yield/impliedtermstructure.hpp>
#include <ql/termstructures/yield/forwardcurve.hpp>
#include <ql/termstructures/interpolatedcurve.hpp>
//#include <qlo/objects/termstructures/yieldtermstructures.hpp>

// FIXME get rid of this:
using namespace QuantLib;

namespace QuantLibAddin {

    // BEGIN typemap rp_tm_lib_cls
    RP_LIB_CLASS(Extrapolator, QuantLib::Extrapolator);
    // END   typemap rp_tm_lib_cls

    RP_OBJ_CLASS(TermStructure, Extrapolator);
    RP_OBJ_CLASS(YieldTermStructure, TermStructure);
    RP_OBJ_CLASS(DefaultProbabilityTermStructure, TermStructure);
    RP_OBJ_CLASS(CorrelationTermStructure, TermStructure);
    //RP_OBJ_CLASS(InflationTermStructure, TermStructure);
    RP_OBJ_CLASS(VolatilityTermStructure, TermStructure);
    //RP_OBJ_CLASS(BlackAtmVolCurve, VolatilityTermStructure);
    //RP_OBJ_CLASS(BlackVolSurface, BlackAtmVolCurve);
    //RP_OBJ_CLASS(InterestRateVolSurface, BlackVolSurface);
    //RP_OBJ_CLASS(BlackVolTermStructure, VolatilityTermStructure);
    RP_OBJ_CLASS(SwaptionVolatilityStructure, VolatilityTermStructure);
    //RP_OBJ_CLASS(SwaptionVolatilityDiscrete, SwaptionVolatilityStructure);
    //RP_OBJ_CLASS(SwaptionVolatilityCube, SwaptionVolatilityDiscrete);
    //RP_OBJ_CLASS(OptionletVolatilityStructure, VolatilityTermStructure);
    //RP_OBJ_CLASS(CapFloorTermVolatilityStructure, VolatilityTermStructure);

    class DiscountCurve : 
        public YieldTermStructure {
    public:
        DiscountCurve(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Date > const &dates,
            std::vector< QuantLib::DiscountFactor > const &dfs,
            QuantLib::DayCounter const &dayCounter,
            // END   typemap rp_tm_default
            bool permanent)
        : YieldTermStructure(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::YieldTermStructure>(new QuantLib::DiscountCurve(
                // BEGIN typemap rp_tm_default
                dates,
                dfs,
                dayCounter
                // END   typemap rp_tm_default
            ));
        }
    };


    class ZeroCurve : 
        public YieldTermStructure {
    public:
        ZeroCurve(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Date > const &dates,
            std::vector< QuantLib::Rate > const &zeroRates,
            QuantLib::DayCounter const &dayCounter,
            // END   typemap rp_tm_default
            bool permanent)
        : YieldTermStructure(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::YieldTermStructure>(new QuantLib::ZeroCurve(
                // BEGIN typemap rp_tm_default
                dates,
                zeroRates,
                dayCounter
                // END   typemap rp_tm_default
            ));
        }
    };


    class ForwardCurve : 
        public YieldTermStructure {
    public:
        ForwardCurve(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            std::vector< QuantLib::Date > const &dates,
            std::vector< QuantLib::Rate > const &forwardRates,
            QuantLib::DayCounter const &dayCounter,
            // END   typemap rp_tm_default
            bool permanent)
        : YieldTermStructure(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::YieldTermStructure>(new QuantLib::ForwardCurve(
                // BEGIN typemap rp_tm_default
                dates,
                forwardRates,
                dayCounter
                // END   typemap rp_tm_default
            ));
        }
    };


    class FlatForward : 
        public YieldTermStructure {
    public:
        FlatForward(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Natural nDays,
            QuantLib::Calendar const &calendar,
            QuantLib::Handle< QuantLib::Quote > const &forward,
            QuantLib::DayCounter const &dayCounter,
            QuantLib::Compounding compounding,
            QuantLib::Frequency frequency,
            // END   typemap rp_tm_default
            bool permanent)
        : YieldTermStructure(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::YieldTermStructure>(new QuantLib::FlatForward(
                // BEGIN typemap rp_tm_default
                nDays,
                calendar,
                forward,
                dayCounter,
                compounding,
                frequency
                // END   typemap rp_tm_default
            ));
        }
    };


    class ForwardSpreadedTermStructure : 
        public YieldTermStructure {
    public:
        ForwardSpreadedTermStructure(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::YieldTermStructure > const &hYTS,
            QuantLib::Handle< QuantLib::Quote > const &spread,
            // END   typemap rp_tm_default
            bool permanent)
        : YieldTermStructure(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::YieldTermStructure>(new QuantLib::ForwardSpreadedTermStructure(
                // BEGIN typemap rp_tm_default
                hYTS,
                spread
                // END   typemap rp_tm_default
            ));
        }
    };


    class ImpliedTermStructure : 
        public YieldTermStructure {
    public:
        ImpliedTermStructure(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::YieldTermStructure > const &hYTS,
            QuantLib::Date const &referenceDate,
            // END   typemap rp_tm_default
            bool permanent)
        : YieldTermStructure(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::YieldTermStructure>(new QuantLib::ImpliedTermStructure(
                // BEGIN typemap rp_tm_default
                hYTS,
                referenceDate
                // END   typemap rp_tm_default
            ));
        }
    };


    //class InterpolatedYieldCurve : 
    //    public YieldTermStructure {
    //public:
    //    InterpolatedYieldCurve(
    //        const boost::shared_ptr<reposit::ValueObject>& properties,
    //        // BEGIN typemap rp_tm_default
    //        std::vector< QuantLib::Date > const &dates,
    //        std::vector< QuantLib::Real > const &data,
    //        QuantLib::Calendar const &calendar,
    //        QuantLib::DayCounter const &dayCounter,
    //        std::vector< QuantLib::Handle< QuantLib::Quote > > const &jumps,
    //        std::vector< QuantLib::Date > const &jumpDates,
    //        std::string const &traitsID,
    //        std::string const &interpolatorID,
    //        QuantLib::MixedInterpolation::Behavior const behavior,
    //        Size const n,
    //        // END   typemap rp_tm_default
    //        bool permanent)
    //    : YieldTermStructure(properties, permanent) {
    //        libraryObject_ = boost::shared_ptr<QuantLibAddin::YieldTermStructure>(new QuantLibAddin::InterpolatedYieldCurve(
    //            // BEGIN typemap rp_tm_default
    //            dates,
    //            data,
    //            calendar,
    //            dayCounter,
    //            jumps,
    //            jumpDates,
    //            traitsID,
    //            interpolatorID,
    //            behavior,
    //            n
    //            // END   typemap rp_tm_default
    //        ));
    //    }
    //};

} // namespace QuantLibAddin

#endif

// END buffer b_lib_grp_hpp

