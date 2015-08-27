
#ifndef obj_piecewiseyieldcurve_hpp
#define obj_piecewiseyieldcurve_hpp

#include <string>
#include <oh/libraryobject.hpp>
#include <oh/valueobject.hpp>
#include <boost/shared_ptr.hpp>

// FIXME this #include is required by create_piecewiseyieldcurve.cpp
#include <qlo/objmanual_ratehelpers.hpp>
//#include <qlo/obj_termstructures.hpp>
#include <qlo/yieldtermstructures.hpp>
//#include <ql/instruments/payoffs.hpp>
#include <ql/time/calendar.hpp>
#include <ql/termstructures/yield/ratehelpers.hpp>
#include <ql/termstructures/yield/piecewiseyieldcurve.hpp>

namespace QuantLibAddin {

    class PiecewiseYieldCurve : public YieldTermStructure {
    public:
        PiecewiseYieldCurve(
            const boost::shared_ptr<ObjectHandler::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Natural nDays,
            QuantLib::Calendar const &calendar,
            std::vector< boost::shared_ptr< QuantLib::RateHelper > > const &qlrhs,
            QuantLib::DayCounter const &dayCounter,
            std::vector< QuantLib::Handle< QuantLib::Quote > > const &jumps,
            std::vector< QuantLib::Date > const &jumpDates,
            QuantLib::Real accuracy,
            std::string const &traitsID,
            std::string const &interpolatorID,
            // END   typemap rp_tm_default
            bool permanent);

 //       const std::vector<QuantLib::Time>& times() const;

 //       const std::vector<QuantLib::Date>& dates() const;

        const std::vector<QuantLib::Real>& data() const;

 //       //const std::vector<QuantLib::Real>& improvements() const;

 //       //QuantLib::Size iterations() const;

 //       InterpolatedYieldCurvePair interpolatedYieldCurvePair() const {
 //           return pair_;
 //       }

 //       const std::vector<QuantLib::Time>& jumpTimes() const;

 //       const std::vector<QuantLib::Date>& jumpDates() const;

	private:
		InterpolatedYieldCurvePair pair_;

    };

} // namespace QuantLibAddin

#endif

