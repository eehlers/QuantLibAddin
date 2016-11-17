
// BEGIN buffer b_lib_grp_cpp

#include <qlo/objects/obj_smilesection.hpp>

#include <ql/termstructures/volatility/interpolatedsmilesection.hpp>
#include <ql/termstructures/volatility/sabrinterpolatedsmilesection.hpp>
#include <ql/experimental/volatility/sabrvolsurface.hpp>
#include <ql/math/interpolations/sabrinterpolation.hpp>
#include <ql/termstructures/volatility/flatsmilesection.hpp>
#include <ql/quotes/simplequote.hpp>

QuantLibAddin::SabrInterpolatedSmileSection::SabrInterpolatedSmileSection(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Date& optionDate,
        const QuantLib::Handle<QuantLib::Quote>& forward,
        const std::vector<QuantLib::Rate>& strikes,
        bool hasFloatingStrikes,
        const QuantLib::Handle<QuantLib::Quote>& atmVolatility,
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& volHandles,
        QuantLib::Real alpha,
        QuantLib::Real beta,
        QuantLib::Real nu,
        QuantLib::Real rho,
        bool isAlphaFixed,
        bool isBetaFixed,
        bool isNuFixed,
        bool isRhoFixed,
        bool vegaWeighted,
        const boost::shared_ptr<QuantLib::EndCriteria> &endCriteria,
        const boost::shared_ptr<QuantLib::OptimizationMethod> &method,
        const QuantLib::DayCounter& dc,
        bool permanent): SmileSection(properties, permanent) {

       std::vector<QuantLib::Handle<QuantLib::Quote> > temp(volHandles.size());
       for(QuantLib::Size i = 0; i<temp.size(); ++i)
            temp[i] = volHandles[i];

       libraryObject_ = 
       boost::shared_ptr<QuantLib::SabrInterpolatedSmileSection>(
        new QuantLib::SabrInterpolatedSmileSection(optionDate,
                                               forward,
                                               strikes,
                                               hasFloatingStrikes,
                                               atmVolatility,
                                               temp,
                                               alpha,
                                               beta,
                                               nu,
                                               rho,
                                               isAlphaFixed,
                                               isBetaFixed,
                                               isNuFixed,
                                               isRhoFixed,
                                               vegaWeighted,
                                               endCriteria,
                                               method,
                                               dc));    
}


QuantLibAddin::SabrSmileSection::SabrSmileSection(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Time expiry,
        const std::vector<QuantLib::Rate>& strikes,
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& stdDevs,
        const QuantLib::Handle<QuantLib::Quote>& forward,
        QuantLib::Real alpha,
        QuantLib::Real beta,
        QuantLib::Real nu,
        QuantLib::Real rho,
        bool isAlphaFixed,
        bool isBetaFixed,
        bool isNuFixed,
        bool isRhoFixed,
        bool vegaWeighted,
        const boost::shared_ptr<QuantLib::EndCriteria> &endCriteria,
        const boost::shared_ptr<QuantLib::OptimizationMethod> &method,
        bool permanent) : SmileSection(properties, permanent) {

    boost::shared_ptr<QuantLib::OptimizationMethod> method_ = method;
    if (!method)
        method_ = boost::shared_ptr<QuantLib::OptimizationMethod>(new
                        QuantLib::Simplex(0.01));

    boost::shared_ptr<QuantLib::EndCriteria> endCriteria_ = endCriteria;
    if (!endCriteria)
        QuantLib::EndCriteria endCriteria(60000, 100, 1e-8, 1e-8, 1e-8);

    QuantLib::SABR sabr(
                            expiry, forward->value(), alpha, beta,
                            nu, rho, isAlphaFixed, isBetaFixed, isNuFixed, 
                            isRhoFixed, vegaWeighted, endCriteria, method);
    
    std::vector<QuantLib::Handle<QuantLib::Quote> > temp(stdDevs.size());
    for(QuantLib::Size i = 0; i<temp.size(); ++i)
        temp[i] = stdDevs[i];
    QuantLib::InterpolatedSmileSection<QuantLib::SABR>* 
        genericInterpolatedSmileSection = new
            QuantLib::InterpolatedSmileSection<QuantLib::SABR>(
                expiry, strikes, temp, forward, sabr);

    libraryObject_ = boost::shared_ptr<
        QuantLib::InterpolatedSmileSection<QuantLib::SABR> >(
            genericInterpolatedSmileSection);
}


QuantLibAddin::InterpolatedSmileSection::InterpolatedSmileSection(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Date& optionDate,
        const std::vector<QuantLib::Rate>& s,
        const std::vector<QuantLib::Handle<QuantLib::Quote> >& stdDevs,
        const QuantLib::Handle<QuantLib::Quote>& atmLevel,
        const QuantLib::DayCounter& dc,
        QuantLib::VolatilityType type,
        QuantLib::Real shift,
        bool permanent) : SmileSection(properties, permanent)
{
    std::vector<QuantLib::Handle<QuantLib::Quote> > temp(stdDevs.size());
    for(QuantLib::Size i = 0; i<temp.size(); ++i)
        temp[i] = stdDevs[i];
    libraryObject_ = boost::shared_ptr<QuantLib::SmileSection>(new
        QuantLib::InterpolatedSmileSection<QuantLib::Linear>(
        optionDate, s, temp, atmLevel, dc, QuantLib::Linear(), QuantLib::Date(), type, shift));
}


QuantLibAddin::SmileSectionFromSabrVolSurface::SmileSectionFromSabrVolSurface(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::SabrVolSurface>& sabrVol,
        const QuantLib::Time& time,
        bool permanent): SmileSection(properties, permanent) {
       
         libraryObject_ = sabrVol->smileSection(time,true);  
}

// END buffer b_lib_grp_cpp

