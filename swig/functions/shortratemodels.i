
%group(Short Rate Models);

%insert(obj_hpp) %{
#include <qlo/objects/obj_termstructures.hpp>

#include <ql/models/shortrate/onefactormodels/hullwhite.hpp>
#include <ql/models/shortrate/twofactormodels/g2.hpp>
%}

namespace QuantLib {

    class ShortRateModel /*: public CalibratedModel*/ {};
    class OneFactorAffineModel : public ShortRateModel {};
    class TwoFactorModel : public ShortRateModel {};

    class Vasicek : public OneFactorAffineModel {
      public:
        Vasicek(
            Rate R0 = 0.05,     //!< Initial value.
            Real A = 0.1,       //!< Mean reverting speed.
            Real B = 0.05,      //!< Short-rate limit value.
            Real Sigma = 0.01,  //!< Volatility.
            Real Lambda = 0.0   //!< Risk premium.
        );

        //! Returns mean reverting speed a, with dr(t) = a(b-r(t))dt + sigma dW(t)..
        Real a() const;

        //! Returns short-rate limit value b, with dr(t) = a(b-r(t))dt + sigma dW(t)..
        Real b() const;

        //! Returns the risk premium..
        Real lambda() const;

        //! Returns the volatility sigma, with dr(t) = a(b-r(t))dt + sigma dW(t)..
        Real sigma() const;
    };

    class HullWhite : public /*Vasicek, public TermStructureConsistentModel*/OneFactorAffineModel {
      public:

        HullWhite(
            const Handle<YieldTermStructure>& YieldCurve,   //!< YieldTermStructure object ID.
            Real A = 0.1,                                   //!< a.
            Real Sigma = 0.01                               //!< Volatility.
        );

        //! Returns Futures convexity bias (ForwardRate = FuturesImpliedRate - ConvexityBias) calculated as in G. Kirikos, D. Novak, 'Convexity Conundrums', Risk Magazine, March 1997.
        %rename2(convexityBias, FuturesConvexityBias);
        static Rate convexityBias(
            Real FuturesPrice,  //!< Futures price (e.g. 94.56).
            Time T1,            //!< Maturity date of the futures contract in years(e.g. 5.0).
            Time T2,            //!< Maturity of the underlying Libor deposit in years (e.g. 5.25).
            Real Sigma,         //!< Hull-White volatility (e.g. 0.015).
            Real A              //!< Hull-White mean reversion.
        );
    };

    class G2 : public TwoFactorModel/*,
               public AffineModel,
               public TermStructureConsistentModel*/ {
      public:
        %rename(ModelG2) G2;
        G2(
            const Handle<YieldTermStructure>& YieldCurve,   //!< YieldTermStructure object ID.
            Real A = 0.1,                                   //!< Drift of x(t) dynamics with r(t)= x(t) + y(t).
            Real Sigma = 0.01,                              //!< Volatility of x(t) dynamics with r(t)= x(t) + y(t).
            Real B = 0.1,                                   //!< Drift of y(t) dynamics with r(t)= x(t) + y(t).
            Real Eta = 0.01,                                //!< Volatility of y(t) dynamics with r(t)= x(t) + y(t).
            Real Correlation = -0.75                        //!< Correlation between x(t) and y(t).
        );

        //! Returns the drift of x(t) dynamics with r(t) = x(t) + y(t).
        %rename2(a, ModelG2A);
        Real a() const;

        //! Returns the volatility of x(t) dynamics with r(t) = x(t) + y(t).
        %rename2(sigma, ModelG2Sigma);
        Real sigma() const;

        //! Returns the drift of y(t) dynamics with r(t) = x(t) + y(t).
        %rename2(b, ModelG2B);
        Real b() const;

        //! Returns the volatility of y(t) dynamics with r(t) = x(t) + y(t).
        %rename2(eta, ModelG2Eta);
        Real eta() const;

        //! Returns the correlation between x(t) and y(t) with r(t) = x(t) + y(t).
        %rename2(rho, ModelG2Rho);
        Real rho() const;
    };
}

