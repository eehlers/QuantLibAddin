
%group(models);

%insert(models_library_hpp) %{
#include <ql/models/shortrate/calibrationhelpers/swaptionhelper.hpp>
#include <ql/models/shortrate/onefactormodels/hullwhite.hpp>
#include <ql/models/shortrate/twofactormodels/g2.hpp>
%}

%insert(models_addin_cpp) %{
#include <qlo/obj_pricingengines.hpp>
#include <qlo/objmanual_quote.hpp>
#include <qlo/objmanual_indexes.hpp>
#include <qlo/obj_termstructures.hpp>
#include <qlo/obj_math.hpp>
%}

namespace QuantLib {

    class CalibrationHelper {
      public:
        %generate(c#, setPricingEngine);
        void setPricingEngine(const boost::shared_ptr<PricingEngine>& engine);
        %generate(c#, impliedVolatility);
        Volatility impliedVolatility(Real targetValue,
                             Real accuracy,
                             Size maxEvaluations,
                             Volatility minVol,
                             Volatility maxVol);
    };

    class SwaptionHelper : public CalibrationHelper {
      public:
        %generate(c#, SwaptionHelper);
        SwaptionHelper(const Period& maturity,
                       const Period& length,
                       const Handle<Quote>& volatility,
                       const boost::shared_ptr<IborIndex>& index,
                       const Period& fixedLegTenor,
                       const DayCounter& fixedLegDayCounter,
                       const DayCounter& floatingLegDayCounter,
                       const Handle<YieldTermStructure>& termStructure/*,
                       CalibrationHelper::CalibrationErrorType errorType
                                      = CalibrationHelper::RelativePriceError,
                       const Real strike = Null<Real>(),
                       const Real nominal = 1.0,
                       const Real shift = 0.0*/);
        %generate(c#, modelValue);
        Real modelValue();
    };

    class CalibratedModel {
      public:
        %generate(c#, calibrate);
        virtual void calibrate(
                const std::vector<boost::shared_ptr<CalibrationHelper> >& x,
                OptimizationMethod& method,
                const EndCriteria& endCriteria/*,
                const Constraint& constraint = Constraint(),
                const std::vector<Real>& weights = std::vector<Real>(),
                const std::vector<bool>& fixParameters = std::vector<bool>()*/);
    };

    class ShortRateModel : public CalibratedModel {};
    class OneFactorAffineModel : public ShortRateModel {};
    class TwoFactorModel : public ShortRateModel {};

    class HullWhite : public /*Vasicek, public TermStructureConsistentModel*/OneFactorAffineModel {
      public:
        %generate(c#, HullWhite);
        HullWhite(const Handle<YieldTermStructure>& termStructure/*,
                  Real a = 0.1, Real sigma = 0.01*/);
    };

    class G2 : public TwoFactorModel/*,
               public AffineModel,
               public TermStructureConsistentModel*/ {    
      public:
        %generate(c#, G2);
        %rename(G2Model) G2;
        G2(const Handle<YieldTermStructure>& termStructure/*,
           Real a = 0.1, Real sigma = 0.01, Real b = 0.1, Real eta = 0.01, Real rho = -0.75*/);
    };
}

