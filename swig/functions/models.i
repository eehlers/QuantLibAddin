
%group(models);
%groupCaption(Models);

%insert(models_library_hpp) %{
#include <ql/models/shortrate/calibrationhelpers/swaptionhelper.hpp>
#include <ql/models/shortrate/onefactormodels/hullwhite.hpp>
#include <ql/models/shortrate/twofactormodels/g2.hpp>
%}

%insert(models_addin_cpp) %{
#include <qlo/obj_pricingengines.hpp>
#include <qlo/objmanual_quotes.hpp>
#include <qlo/objmanual_indexes.hpp>
#include <qlo/obj_termstructures.hpp>
#include <qlo/obj_math.hpp>
%}

namespace QuantLib {

    class CalibrationHelper {
      public:
        %generate(c#, setPricingEngine);
        //! Set the priging engine for the given CalibrationHelper object.
        void setPricingEngine(
            const boost::shared_ptr<PricingEngine>& engine  //!< PricingEngine object ID.
        );
        %generate(c#, impliedVolatility);
        //! Retrieve the implied volatility for the given CalibrationHelper object.
        Volatility impliedVolatility(
            Real targetValue,           //!< target value.
            Real accuracy,              //!< accuracy.
            Size maxEvaluations,        //!< max evaluations.
            Volatility minVol,          //!< min vol.
            Volatility maxVol           //!< max vol.
        );
    };

    class SwaptionHelper : public CalibrationHelper {
      public:
        %generate(c#, SwaptionHelper);
        SwaptionHelper(
            const Period& maturity,                                 //!< option tenor as Period (e.g. '5Y').
            const Period& length,                                   //!< option length.
            const Handle<Quote>& volatility,                        //!< volatility quote.
            const boost::shared_ptr<IborIndex>& index,              //!< IborIndex object ID.
            const Period& fixedLegTenor,                            //!< fixed leg tenor.
            const DayCounter& fixedLegDayCounter,                   //!< fixed leg day-counter.
            const DayCounter& floatingLegDayCounter,                //!< floating leg day-counter.
            const Handle<YieldTermStructure>& termStructure         //!< YieldTermStructure object ID.
            /*,CalibrationHelper::CalibrationErrorType errorType
                = CalibrationHelper::RelativePriceError,
            const Real strike = Null<Real>(),
            const Real nominal = 1.0,
            const Real shift = 0.0*/
        );
        %generate(c#, modelValue);
        //! Retrieve the model value for the given SwaptionHelper object.
        Real modelValue();
    };

    class CalibratedModel {
      public:
        %generate(c#, calibrate);
        //! calibrate a model.
        virtual void calibrate(
            const std::vector<boost::shared_ptr<CalibrationHelper> >& x,    //!< vector of calibration-helpers.
            OptimizationMethod& method,                                     //!< OptimizationMethod object ID.
            const EndCriteria& endCriteria                                  //!< EndCriteria object ID.
            /*,const Constraint& constraint = Constraint(),
            const std::vector<Real>& weights = std::vector<Real>(),
            const std::vector<bool>& fixParameters = std::vector<bool>()*/
        );
    };

    class ShortRateModel : public CalibratedModel {};
    class OneFactorAffineModel : public ShortRateModel {};
    class TwoFactorModel : public ShortRateModel {};

    class HullWhite : public /*Vasicek, public TermStructureConsistentModel*/OneFactorAffineModel {
      public:
        %generate(c#, HullWhite);
        HullWhite(
            const Handle<YieldTermStructure>& termStructure     //!< YieldTermStructure object ID.
            /*,Real a = 0.1, Real sigma = 0.01*/
        );
    };

    class G2 : public TwoFactorModel/*,
               public AffineModel,
               public TermStructureConsistentModel*/ {    
      public:
        %generate(c#, G2);
        %rename(G2Model) G2;
        G2(
            const Handle<YieldTermStructure>& termStructure     //!< YieldTermStructure object ID.
            /*,Real a = 0.1, Real sigma = 0.01, Real b = 0.1, Real eta = 0.01, Real rho = -0.75*/
        );
    };
}

