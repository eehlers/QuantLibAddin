
%group(Leg);

%insert(obj_hpp) %{
#include <ql/types.hpp>
#include <ql/compounding.hpp>
#include <ql/cashflows/cashflows.hpp>

namespace QuantLib {
    class FloatingRateCouponPricer;
    class CapFloor;
    class Swap;
}

namespace QuantLibAddin {
    class FloatingRateCouponPricer;
}
%}

namespace QuantLib {

    %noctor(CashFlows);
    %noexport(CashFlows);
    class CashFlows {
      public:

        //! Returns the start (i.e. first accrual) date for the given Leg object.
        %rename2(startDate, LegStartDate);
        static Date startDate(
            const Leg& ObjectId             //!< ID of existing QuantLib::Leg object.
        );

        //! Returns the maturity (i.e. last payment) date for the given Leg object.
        %rename2(maturityDate, LegMaturityDate);
        static Date maturityDate(
            const Leg& ObjectId             //!< ID of existing QuantLib::Leg object.
        );

        //! Returns TRUE if the Leg is expired.
        %rename2(isExpired, LegIsExpired);
        static bool isExpired(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the previous cash flow date.
        %rename2(previousCashFlowDate, LegPreviousCashFlowDate);
        static Date previousCashFlowDate(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the next cash flow date.
        %rename2(nextCashFlowDate, LegNextCashFlowDate);
        static Date nextCashFlowDate(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the previous cash flow amount.
        %rename2(previousCashFlowAmount, LegPreviousCashFlowAmount);
        static Real previousCashFlowAmount(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the next cash flow amount.
        %rename2(nextCashFlowAmount, LegNextCashFlowAmount);
        static Real nextCashFlowAmount(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the previous coupon rate. Depending on (the Leg and) the given date it can be historic, deterministic or expected in a stochastic sense. When the current date is used the coupon is the last paid one.
        %rename2(previousCouponRate, LegPreviousCouponRate);
        static Rate previousCouponRate(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the next coupon rate. Depending on (the Leg and) the given date it can be historic, deterministic or expected in a stochastic sense. When the current date is used the coupon is the already-fixed not-yet-paid one.
        %rename2(nextCouponRate, LegNextCouponRate);
        static Rate nextCouponRate(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the nominal for the current coupon of the given Leg.
        %rename2(nominal, LegNominal);
        static Real nominal(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the accrual start date for the current coupon of the given Leg.
        %rename2(accrualStartDate, LegAccrualStartDate);
        static Date accrualStartDate(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the accrual end date for the current coupon of the given Leg.
        %rename2(accrualEndDate, LegAccrualEndDate);
        static Date accrualEndDate(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the reference period start date for the current coupon of the given Leg.
        %rename2(referencePeriodStart, LegReferencePeriodStart);
        static Date referencePeriodStart(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the reference period end date for the current coupon of the given Leg.
        %rename2(referencePeriodEnd, LegReferencePeriodEnd);
        static Date referencePeriodEnd(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the total accrual period for the current coupon of the given Leg.
        %rename2(accrualPeriod, LegAccrualPeriod);
        static Time accrualPeriod(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the total number of accrual days for the current coupon of the given Leg.
        %rename2(accrualDays, LegAccrualDays);
        static BigInteger accrualDays(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the accrued period for the current coupon of the given Leg.
        %rename2(accruedPeriod, LegAccruedPeriod);
        static Time accruedPeriod(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the accrued days for the current coupon of the given Leg.
        %rename2(accruedDays, LegAccruedDays);
        static BigInteger accruedDays(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the accrued amount for the given Leg.
        %rename2(accruedAmount, LegAccruedAmount);
        static Real accruedAmount(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date()      //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
        );

        //! Returns the net present value for the given Leg object.
        %rename2(npv, LegNPV);
        static Real npv(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            const DiscountCurve& discountCurve,//!< Discounting YieldTermStructure object ID.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
        );

        //! Returns the net present value for the given Leg object.
        %rename2(bps, LegBPS);
        static Real bps(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            const YieldTermStructure& discountCurve,//!< Discounting YieldTermStructure object ID.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
        );

        //! Returns the at-the-money rate for the given Leg object, i.e. the fixed rate for which an equivalent vector of fixed-rate cash flows would have the same NPV.
        %rename2(atmRate, LegAtmRate);
        static Rate atmRate(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            const YieldTermStructure& discountCurve,//!< Discounting YieldTermStructure object ID.
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date(),            //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
            Real NPV = Null<Real>()         //!< 
        );

// FIXME this overload does not get generated.
//        //! Returns the net present value for the given Leg object.
//        %rename2(npv, LegNPVFromYield);
//        static Real npv(
//            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
//            Rate Yield,                     //!< Yield (a.k.a. IRR).
//            const DayCounter& DayCounter=QuantLib::ActualActual(QuantLib::ActualActual::ISDA),//!< DayCounter ID.
//            Compounding Compounding=QuantLib::Compounding(QuantLib::Compounded),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
//            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
//            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
//            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
//            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
//        );

        //! Returns the basis point sensitivity for the given Leg object.
        %rename2(bps, LegBPSFromYield);
        static Real bps(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            const /*Interest*/Rate& Yield,  //!< Yield (a.k.a. IRR).
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
        );

        //! Returns the Internal rate of return for the given Leg object.
        %rename2(yield, LegYield);
        static Rate yield(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            Real NPV,                       //!< Net present (dirty) value.
            const DayCounter& DayCounter=QuantLib::ActualActual(QuantLib::ActualActual::ISMA),//!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Compounded),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date(),            //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
            Real Accuracy = 1.0e-10,        //!< Tolerance.
            Size MaxIterations = 100,       //!< Max number of iterations.
            Rate Guess = 0.05               //!< Guess.
        );

        //! Returns the Cash-flow duration for the given Leg object.
        %rename2(duration, LegDuration);
        static Time duration(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            Rate Yield,                     //!< Yield (a.k.a. IRR).
            const DayCounter& DayCounter=QuantLib::ActualActual(QuantLib::ActualActual::ISMA),//!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Compounded),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Duration::Type DurationType=QuantLib::Duration::Type(QuantLib::Duration::Modified),    //!< Duration type (Simple, Macaulay, or Modified).
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
        );

        //! Returns the Cash-flow convexity for the given Leg object.
        %rename2(convexity, LegConvexity);
        static Real convexity(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            Rate Yield,                     //!< Yield (a.k.a. IRR).
            const DayCounter& DayCounter=QuantLib::ActualActual(QuantLib::ActualActual::ISDA),//!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Compounded),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
        );

        //! Returns the basisPointValue for the given Leg object.
        %rename2(basisPointValue, LegBasisPointValue);
        static Real basisPointValue(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            Rate Yield,                     //!< Yield (a.k.a. IRR).
            const DayCounter& DayCounter=QuantLib::ActualActual(QuantLib::ActualActual::ISDA),//!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Compounded),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
        );

        //! Returns the yieldValueBasisPoint for the given Leg object.
        %rename2(yieldValueBasisPoint, LegYieldValueBasisPoint);
        static Real yieldValueBasisPoint(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            Rate Yield,                     //!< Yield (a.k.a. IRR).
            const DayCounter& DayCounter=QuantLib::ActualActual(QuantLib::ActualActual::ISDA),//!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Compounded),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
        );

// FIXME this overload does not get generated.
//        //! Returns the net present value for the given Leg object.
//        %rename2(npv, LegNPVFromZSpread);
//        static Real npv(
//            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
//            const boost::shared_ptr<YieldTermStructure>& DiscountCurve,//!< Discounting YieldTermStructure object ID.
//            Spread ZSpread,                 //!< Z-spread.
//            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),//!< DayCounter ID.
//            Compounding Compounding=QuantLib::Compounding(QuantLib::Compounded),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
//            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
//            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
//            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
//            Date NpvDate=Date()             //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
//        );

        //! Returns the z-spread for the given Leg object.
        %rename2(zSpread, LegZSpread);
        static Spread zSpread(
            const Leg& ObjectId,            //!< ID of existing QuantLib::Leg object.
            Real NPV,                       //!< Net present (dirty) value.
            const boost::shared_ptr<YieldTermStructure>& DiscountCurve,//!< Discounting YieldTermStructure object ID.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),//!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Continuous),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            bool IncludeSettlDate=true,     //!< TRUE if cashflows paid at the settlement date must be taken into account.
            Date SettlementDate=Date(),     //!< Cashflows before this date are not taken into account. If missing the current EvaluationDate is used.
            Date NpvDate=Date(),            //!< All cashflows are discounted to this date. If missing it is assumed equal to the settlement date.
            Real Accuracy = 1.0e-10,        //!< Tolerance.
            Size MaxIterations = 100,       //!< Max number of iterations.
            Rate Guess = 0.0                //!< Guess.
        );
    };

    class Leg {
      public:

        Leg(
            const std::vector<QuantLib::Real>& Amounts, //!< List of cash to be received/paid.
            const std::vector<QuantLib::Date>& Dates,   //!< Payment dates corresponding to amounts.
            bool ToBeSorted=true                        //!< TRUE if the CashFlows must be sorted by ascending dates.
        );

// FIXME this depends on CapFloor which is not yet implemented.
//        %rename(LegFromCapFloor) Leg;
//        Leg(
//            const boost::shared_ptr<QuantLib::CapFloor>& CapFloor   //!< CapFloor object ID.
//        );

// FIXME this depends on Swap which is not yet implemented.
//        %rename(LegFromSwap) Leg;
//        Leg(
//            const boost::shared_ptr<QuantLib::Swap>& Swap,  //!< Swap object ID.
//            QuantLib::Size LegNumber    //!< Zero based leg number (e.g. use 0 for the first leg, 1 for the second leg, etc.).
//        );

%insert(rp_class) %{
// FIXME this depends on couponvectors which is not yet implemented.
//        void setCouponPricers(
//            const std::vector<boost::shared_ptr<QuantLibAddin::FloatingRateCouponPricer> > &FloatingRateCouponPricer //!< FloatingRate coupon pricer object ID.
//        );

        std::vector<std::vector<reposit::property_t> > flowAnalysis(
            const QuantLib::Date& AfterDate=QuantLib::Date()     //!< Shows only cashflows after given date.
        ) const;

        RP_LIB_CTOR(Leg, QuantLib::Leg);
%}
    };

    class MultiPhaseLeg : public Leg {
      public:

        MultiPhaseLeg(
            const std::vector<boost::shared_ptr<QuantLibAddin::Leg> >& LegIDs, //!< Leg object IDs, one for each phase.
            bool ToBeSorted=true                                //!< TRUE if the CashFlows must be sorted by ascending dates.
        );
    };

    class InterestRate {
      public:

        InterestRate(
            QuantLib::Rate Rate,               //!< Rate.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),//!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Simple),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual)//!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
        );

        //! Returns the rate in the given InterestRate object.
        Rate rate() const;

        //! Returns the DayCounter in the given InterestRate object.
        const DayCounter& dayCounter() const;

        //! Returns the Compounding in the given InterestRate object.
        Compounding compounding() const;

        //! Returns the Frequency in the given InterestRate object.
        Frequency frequency() const;

        //! Returns the discount factor between two dates based on the given InterestRate object.
        DiscountFactor discountFactor(
            const Date& StartDate,                  //!< Compounding period start.
            const Date& EndDate,                    //!< Compounding period end.
            const Date& RefPeriodStart = Date(),    //!< Reference period start date needed by some daycounter.
            const Date& RefPeriodEnd = Date()       //!< Reference period end date needed by some daycounter.
        ) const;

        //! Returns the discount factor between two dates based on the given InterestRate object.
        Real compoundFactor(
            const Date& StartDate,                  //!< Compounding period start.
            const Date& EndDate,                    //!< Compounding period end.
            const Date& RefPeriodStart = Date(),    //!< Reference period start date needed by some daycounter.
            const Date& RefPeriodEnd = Date()       //!< Reference period end date needed by some daycounter.
        ) const;

        InterestRate equivalentRate(
            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),        //!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Simple),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),      //!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            const Date& StartDate,                  //!< Compounding period start.
            const Date& EndDate,                    //!< Compounding period end.
            const Date& RefPeriodStart = Date(),    //!< Reference period start date needed by some daycounter.
            const Date& RefPeriodEnd = Date()       //!< Reference period end date needed by some daycounter.
        ) const;

        static InterestRate impliedRate(
            Real Compound,                          //!< Compound factor used to calculate the implicit rate.
            const DayCounter& DayCounter=QuantLib::Actual365Fixed(),        //!< DayCounter ID.
            Compounding Compounding=QuantLib::Compounding(QuantLib::Simple),//!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency Frequency=QuantLib::Frequency(QuantLib::Annual),      //!< Frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            const Date& StartDate,                  //!< Compounding period start.
            const Date& EndDate,                    //!< Compounding period end.
            const Date& RefPeriodStart = Date(),    //!< Reference period start date needed by some daycounter.
            const Date& RefPeriodEnd = Date()       //!< Reference period end date needed by some daycounter.
        ) const;
    };
}

namespace QuantLibAddin {

    %noctor(Leg);
    %noexport(Leg);
    class Leg {
      public:

// FIXME this depends on couponvectors which is not yet implemented.
//        //! Set the coupon pricer at the given Leg object.
//        void setCouponPricers(
//            const std::vector<boost::shared_ptr<QuantLibAddin::FloatingRateCouponPricer> > &FloatingRateCouponPricer //!< FloatingRate coupon pricer object ID.
//        );

        //! Returns the flow analysis for the given Leg object.
        std::vector<std::vector<reposit::property_t> > flowAnalysis(
            const QuantLib::Date& AfterDate=Date()     //!< Shows only cashflows after given date.
        ) const;
    };
}
