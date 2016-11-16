
%group(Payoffs);

%insert(obj_hpp) %{
#include <ql/instruments/payoffs.hpp>
#include <ql/instruments/stickyratchet.hpp>
%}

namespace QuantLib {

    class Payoff /*: std::unary_function<Real,Real>*/ {
      public:

        //! Returns the type (e.g. Vanilla, CashOrNothing, etc.) for the given Payoff object.
        virtual std::string name() const;

        //! Returns the description (e.g. CashOrNothing, strike 32.2, cash payoff 2.5) for the given Payoff object.
        virtual std::string description() const;

        //! Returns the payoff value given an underlying reference level for the given Payoff object.
        %rename(value) operator();
        virtual QuantLib::Real operator()(
            QuantLib::Real Underlying     //!< Underlying reference level.
        ) const;
    };

    class TypePayoff : public Payoff {
      public:

        //! Returns the option-type (e.g. Call, Put) for the given Payoff object.
        %rename2(optionType, PayoffOptionType);
        Option::Type optionType() const;
    };

    class StrikedTypePayoff : public TypePayoff {
      public:

        %override2(StrikedTypePayoff);
        StrikedTypePayoff(
              const std::string& PayoffID,                                          //!< Payoff ID (e.g. Vanilla, PercentageStrike, AssetOrNothing, CashOrNothing, Gap, SuperShare).
              const QuantLib::Option::Type& OptionType,                             //!< Option type.
              const QuantLib::Real Strike,                                          //!< Strike.
              const QuantLib::Real ThirdParameter=QuantLib::Null<QuantLib::Real>()  //!< The 3rd paramenter for the payoff definition of CashOrNothing (cash), Gap (determines the size of the payoff), SuperFund (second strike).
        );

        //! Returns the strike for the given Payoff object.
        %rename2(strike, PayoffStrike);
        QuantLib::Real strike() const;

%insert(rp_class) %{
        QuantLib::Real thirdParameter() const;
%}
    };

    class DoubleStickyRatchetPayoff : public Payoff {
      public:

        DoubleStickyRatchetPayoff(
            Real Type1,             //!< Sticky (type1=1) or Ratchet (type1=-1) payoff.
            Real Type2,             //!< Strike type (type2=1 for Min, type2=-1 for Max, type2=0 for single sticky/ratchet).
            Real Gearing1,          //!< Gearing 1 (for strike 1).
            Real Gearing2,          //!< Gearing 2 (for strike 2).
            Real Gearing3,          //!< Gearing 3 (for forward rate 3).
            Real Spread1,           //!< Spread 1 (for strike 1).
            Real Spread2,           //!< Spread 2 (for strike 2).
            Real Spread3,           //!< Spread 3 (for forward rate 3).
            Real InitialValue1,     //!< Initial value for strike 1 (forward rate or coupon/accrualFactor).
            Real InitialValue2,     //!< Initial value for strike 2 (forward rate or coupon/accrualFactor).
            Real AccrualFactor      //!< Accrual factor.
        );
%insert(rp_class) %{
      protected:
        RP_OBJ_CTOR(DoubleStickyRatchetPayoff, Payoff);
%}
    };

    class RatchetPayoff : public DoubleStickyRatchetPayoff {
      public:

         RatchetPayoff(
            Real Gearing1,          //!< Gearing 1 (for strike 1).
            Real Gearing2,          //!< Gearing 2 (for strike 2).
            Real Spread1,           //!< Spread 1 (for strike 1).
            Real Spread2,           //!< Spread 2 (for strike 2).
            Real InitialValue,      //!< Initial value for strike (forward rate or coupon/accrualFactor).
            Real AccrualFactor      //!< Accrual factor.
        );
    };

    class StickyPayoff : public DoubleStickyRatchetPayoff {
      public:

         StickyPayoff(
            Real Gearing1,          //!< Gearing 1 (for strike 1).
            Real Gearing2,          //!< Gearing 2 (for strike 2).
            Real Spread1,           //!< Spread 1 (for strike 1).
            Real Spread2,           //!< Spread 2 (for strike 2).
            Real InitialValue,      //!< Initial value for strike (forward rate or coupon/accrualFactor).
            Real AccrualFactor      //!< Accrual factor.
        );
    };

    class RatchetMaxPayoff : public DoubleStickyRatchetPayoff {
      public:

         RatchetMaxPayoff(
            Real Gearing1,          //!< Gearing 1 (for strike 1).
            Real Gearing2,          //!< Gearing 2 (for strike 2).
            Real Gearing3,          //!< Gearing 3 (for forward rate 3).
            Real Spread1,           //!< Spread 1 (for strike 1).
            Real Spread2,           //!< Spread 2 (for strike 2).
            Real Spread3,           //!< Spread 3 (for forward rate 3).
            Real InitialValue1,     //!< Initial value for strike 1 (forward rate or coupon/accrualFactor).
            Real InitialValue2,     //!< Initial value for strike 2 (forward rate or coupon/accrualFactor).
            Real AccrualFactor      //!< Accrual factor.
        );
    };

    class RatchetMinPayoff : public DoubleStickyRatchetPayoff {
      public:
         RatchetMinPayoff(
            Real Gearing1,          //!< Gearing 1 (for strike 1).
            Real Gearing2,          //!< Gearing 2 (for strike 2).
            Real Gearing3,          //!< Gearing 3 (for forward rate 3).
            Real Spread1,           //!< Spread 1 (for strike 1).
            Real Spread2,           //!< Spread 2 (for strike 2).
            Real Spread3,           //!< Spread 3 (for forward rate 3).
            Real InitialValue1,     //!< Initial value for strike 1 (forward rate or coupon/accrualFactor).
            Real InitialValue2,     //!< Initial value for strike 2 (forward rate or coupon/accrualFactor).
            Real AccrualFactor      //!< Accrual factor.
        );
    };

    class StickyMaxPayoff : public DoubleStickyRatchetPayoff {
      public:

         StickyMaxPayoff(
            Real Gearing1,          //!< Gearing 1 (for strike 1).
            Real Gearing2,          //!< Gearing 2 (for strike 2).
            Real Gearing3,          //!< Gearing 3 (for forward rate 3).
            Real Spread1,           //!< Spread 1 (for strike 1).
            Real Spread2,           //!< Spread 2 (for strike 2).
            Real Spread3,           //!< Spread 3 (for forward rate 3).
            Real InitialValue1,     //!< Initial value for strike 1 (forward rate or coupon/accrualFactor).
            Real InitialValue2,     //!< Initial value for strike 2 (forward rate or coupon/accrualFactor).
            Real AccrualFactor      //!< Accrual factor.
        );
    };

    class StickyMinPayoff : public DoubleStickyRatchetPayoff {
      public:
         StickyMinPayoff(
            Real Gearing1,          //!< Gearing 1 (for strike 1).
            Real Gearing2,          //!< Gearing 2 (for strike 2).
            Real Gearing3,          //!< Gearing 3 (for forward rate 3).
            Real Spread1,           //!< Spread 1 (for strike 1).
            Real Spread2,           //!< Spread 2 (for strike 2).
            Real Spread3,           //!< Spread 3 (for forward rate 3).
            Real InitialValue1,     //!< Initial value for strike 1 (forward rate or coupon/accrualFactor).
            Real InitialValue2,     //!< Initial value for strike 2 (forward rate or coupon/accrualFactor).
            Real AccrualFactor      //!< Accrual factor.
        );
    };
}

namespace QuantLibAddin {

    %noctor(StrikedTypePayoff);
    %noexport(StrikedTypePayoff);
    class StrikedTypePayoff : public TypePayoff {
      public:

        //! Returns the third parameter of a StrikedType payoff.
        %rename2(thirdParameter, PayoffThirdParameter);
        QuantLib::Real thirdParameter() const;
    };
}
