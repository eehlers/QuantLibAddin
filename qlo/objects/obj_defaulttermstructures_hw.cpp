
#include <qlo/objects/obj_defaulttermstructures.hpp>

#include <ql/termstructures/credit/flathazardrate.hpp>
#include <ql/termstructures/credit/interpolatedhazardratecurve.hpp>

#include <ql/math/interpolations/bilinearinterpolation.hpp>
#include <ql/math/interpolations/bicubicsplineinterpolation.hpp>
#include <ql/math/interpolations/backwardflatinterpolation.hpp>
#include <ql/experimental/credit/basecorrelationstructure.hpp>

#include <ql/math/solver1d.hpp>
#include <ql/math/solvers1d/brent.hpp>

namespace {
    class HRObjectiveF : public std::unary_function<QuantLib::Real, QuantLib::Real> {
        const QuantLib::Real targetValue_;
        const std::vector<QuantLib::Date> d_;
        const QuantLib::DayCounter dc_;
    public:
        HRObjectiveF(const QuantLib::Real Prob,
                     const std::vector<QuantLib::Date>& t,
                     const QuantLib::DayCounter& dc)
        : targetValue_(Prob), d_(t), dc_(dc) { /*QL_REQUIRE(d_.size() == 2, "Needs two dates exactly.");*/ }
        QuantLib::Real operator()(const QuantLib::Real x)const {
            std::vector<QuantLib::Real> hrs(2, x);
            QuantLib::InterpolatedHazardRateCurve<QuantLib::BackwardFlat> tstCurve(d_, hrs, dc_);
            return tstCurve.defaultProbability(d_[0], d_[1], true) - targetValue_;
        }
    };
}

QuantLib::Real QuantLibAddin::probabilityToHR(
    QuantLib::Probability pdef,
    QuantLib::Date const &d,
    QuantLib::DayCounter const &dc) {

        std::vector<QuantLib::Date> tenors;
        tenors.push_back(QuantLib::Settings::instance().evaluationDate());
        tenors.push_back(d);
            
        HRObjectiveF f(pdef, tenors, dc);
        QuantLib::Brent solver;
        solver.setMaxEvaluations(100);
        QuantLib::Real guess  = 0.5;
        QuantLib::Real minVal = QL_EPSILON;
        QuantLib::Real maxVal = 100.;
        QuantLib::Real accuracy = 1.0e-6;
        return solver.solve(f, accuracy, guess, minVal, maxVal);
}