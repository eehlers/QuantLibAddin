
#include <qlo/objects/obj_math.hpp>
#include <ql/math/distributions/normaldistribution.hpp>

QuantLib::Matrix QuantLibAddin::getCovariance(std::vector<double> vols,
                                      const QuantLib::Matrix& corr,
                                      double tol) 
{
    return QuantLib::getCovariance(vols.begin(), vols.end(), corr, tol);
}


double QuantLibAddin::normDist(double x,
                     double mean,
                     double stdDev,
                     bool cumulative) {
    if (cumulative) {
        return QuantLib::CumulativeNormalDistribution(mean, stdDev)(x);
    } else {
        return QuantLib::NormalDistribution(mean, stdDev)(x);
    }
}

double QuantLibAddin::normSDist(double x) {
    return QuantLib::CumulativeNormalDistribution(0.0, 1.0)(x);
}

double QuantLibAddin::normInv(double prob,
                    double mean,
                    double stdDev) {
    return QuantLib::InverseCumulativeNormal(mean, stdDev)(prob);
}

double QuantLibAddin::normSInv(double prob) {
    return QuantLib::InverseCumulativeNormal(0.0, 1.0)(prob);
}
