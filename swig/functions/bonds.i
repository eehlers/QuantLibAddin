
%group(bonds);
%groupCaption(Bonds);
%groupFunctionWizard(QuantLib - Financial);
%override;

%insert(bonds_addin_cpp) %{
#include <qlo/obj_schedule.hpp>
#include <qlo/obj_termstructures.hpp>
#include <qlo/objmanual_leg.hpp>
#include <qlo/objmanual_couponvectors.hpp>
#include <qlo/indexes/iborindex.hpp>
#include <qlo/indexes/swapindex.hpp>
#include <ql/pricingengines/bond/bondfunctions.hpp>
%}

namespace QuantLib {

    class Bond : public Instrument {
      public:
        //! Returns the number of settlement days of the bond.
        Natural settlementDays() const;
        //! Returns the calendar of the bond, e.g. TARGET.
        const Calendar& calendar() const;
        //! Returns the notionals of the bond.
        const std::vector<Real>& notionals() const;
        //! Returns the notional of the bond at a given date.
        virtual Real notional(
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        ) const;
        //! Returns the maturity date of the bond.
        Date maturityDate() const;
        //! Returns the issue date of the bond.
        Date issueDate() const;
        //! Returns TRUE if the given Bond is tradable at the given settlement date. The current bond settlement is used if no date is given.
        bool isTradable(
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        ) const;
        //! Returns the settlement date of the bond.
        Date settlementDate(
            Date EvaluationDate = Date()    //!< The current global Settings::EvaluationDate is used if no specific date is given.
        ) const;
        //! Returns the clean price for the given bond.
        Real cleanPrice() const;
    };
    
    struct BondFunctions {
    
        // Date inspectors
        
        //! Returns the start (i.e. first accrual) date for the given Bond object.
        %rename2(startDate, bondStartDate);
        static Date startDate(
            const Bond& ObjectId            //!< id of existing QuantLib::Bond object
        );
        
        // CashFlow inspectors
        
        //! Returns the previous cash flow date.
        %rename2(previousCashFlowDate, bondPreviousCashFlowDate);
        static Date previousCashFlowDate(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the next cash flow date.
        %rename2(nextCashFlowDate, bondNextCashFlowDate);
        static Date nextCashFlowDate(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the previous cash flow amount.
        %rename2(previousCashFlowAmount, bondPreviousCashFlowAmount);
        static Real previousCashFlowAmount(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the next cash flow amount.
        %rename2(nextCashFlowAmount, bondNextCashFlowAmount);
        static Real nextCashFlowAmount(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );

        // Coupon inspectors
        
        //! Returns the previous coupon rate. Depending on (the Bond and) the given date it can be historic, deterministic or expected in a stochastic sense. When the bond settlement date is used the coupon is the last paid one.
        %rename2(previousCouponRate, bondPreviousCouponRate);
        static Rate previousCouponRate(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the next coupon rate. Depending on (the Bond and) the given date it can be historic, deterministic or expected in a stochastic sense. When the bond settlement date is used the coupon is the already-fixed not-yet-paid one.
        %rename2(nextCouponRate, bondNextCouponRate);
        static Rate nextCouponRate(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the accrual start date for the current coupon of the given bond.
        %rename2(accrualStartDate, bondAccrualStartDate);
        static Date accrualStartDate(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the accrual end date for the current coupon of the given bond.
        %rename2(accrualEndDate, bondAccrualEndDate);
        static Date accrualEndDate(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the reference period start date for the current coupon of the given bond.
        %rename2(referencePeriodStart, bondReferencePeriodStart);
        static Date referencePeriodStart(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the reference period end date for the current coupon of the given bond.
        %rename2(referencePeriodEnd, bondReferencePeriodEnd);
        static Date referencePeriodEnd(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the total accrual period for the current coupon of the given bond. The current bond settlement is used if no date is given.
        %rename2(accrualPeriod, bondAccrualPeriod);
        static Time accrualPeriod(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the total number of accrual days for the current coupon of the given bond. The current bond settlement is used if no date is given.
        %rename2(accrualDays, bondAccrualDays);
        static BigInteger accrualDays(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the accrued period for the current coupon of the given bond. The current bond settlement is used if no date is given.
        %rename2(accruedPeriod, bondAccruedPeriod);
        static Time accruedPeriod(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the accrued days for the current coupon of the given bond. The current bond settlement is used if no date is given.
        %rename2(accruedDays, bondAccruedDays);
        static BigInteger accruedDays(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the accrued amount for the given bond. The current bond settlement is used if no date is given.
        %rename2(accruedAmount, bondAccruedAmount);
        static Real accruedAmount(
            const Bond& ObjectId,           //!< id of existing QuantLib::Bond object
            Date SettlementDate = Date()    //!< The current bond settlement date is used if no specific date is given.
        );

        // YieldTermStructure functions

        //! Returns the bond clean price implied by the given YieldTermStructure and settlement date.
        %rename2(cleanPrice, bondCleanPriceFromYieldTermStructure);
        static Real cleanPrice(
            const Bond& ObjectId,                   //!< id of existing QuantLib::Bond object
            const YieldTermStructure& YieldCurve,   //!< discounting YieldTermStructure object ID.
            Date SettlementDate = Date()            //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the basis point sensitivity implied by the given YieldTermStructure and settlement date.
        %rename2(bps, bondBpsFromYieldTermStructure);
        static Real bps(
            const Bond& ObjectId,                   //!< id of existing QuantLib::Bond object
            const YieldTermStructure& YieldCurve,   //!< discounting YieldTermStructure object ID.
            Date SettlementDate = Date()            //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the ATM rate implied by the given YieldTermStructure, settlement date, and clean price.
        %rename2(atmRate, bondAtmRateFromYieldTermStructure);
        static Rate atmRate(
            const Bond& ObjectId,                   //!< id of existing QuantLib::Bond object
            const YieldTermStructure& YieldCurve,   //!< discounting YieldTermStructure object ID.
            Date SettlementDate = Date(),           //!< The current bond settlement date is used if no specific date is given.
            Real cleanPrice = Null<Real>()          //!< clean price.
        );

        // Yield (a.k.a. Internal Rate of Return, i.e. IRR) functions

        //! Returns the bond clean price implied by the given yield and settlement date.
        %rename2(cleanPrice, bondCleanPriceFromYield);
        static Real cleanPrice(
            const Bond& ObjectId,                                           //!< id of existing QuantLib::Bond object
            Rate Yield,                                                     //!< bond yield.
            const DayCounter& dayCounter=ActualActual(ActualActual::ISDA),  //!< Yield DayCounter ID.
            Compounding compounding=Compounding(Compounded),                //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency=Frequency(Annual),                          //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Date SettlementDate=Date()                                      //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the bond dirty price implied by the given yield and settlement date.
        %rename2(dirtyPrice, bondDirtyPriceFromYield);
        static Real dirtyPrice(
            const Bond& ObjectId,                                           //!< id of existing QuantLib::Bond object
            Rate Yield,                                                     //!< bond yield.
            const DayCounter& dayCounter=ActualActual(ActualActual::ISDA),  //!< Yield DayCounter ID.
            Compounding compounding=Compounding(Compounded),                //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency=Frequency(Annual),                          //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Date SettlementDate=Date()                                      //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the basis point sensitivity implied by the given yield and settlement date.
        %rename2(bps, bondBpsFromYield);
        static Real bps(
            const Bond& ObjectId,                                           //!< id of existing QuantLib::Bond object
            Rate Yield,                                                     //!< bond yield.
            const DayCounter& dayCounter=ActualActual(ActualActual::ISDA),  //!< Yield DayCounter ID.
            Compounding compounding=Compounding(Compounded),                //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency=Frequency(Annual),                          //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Date SettlementDate=Date()                                      //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the yield for the given bond corresponding to the given clean price and settlement date.
        %rename2(yield, bondYieldFromCleanPrice);
        static Rate yield(
            const Bond& ObjectId,                                           //!< id of existing QuantLib::Bond object
            Real cleanPrice,                                                //!< clean price.
            const DayCounter& dayCounter=ActualActual(ActualActual::ISDA),  //!< Yield DayCounter ID.
            Compounding compounding=Compounding(Compounded),                //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency=Frequency(Annual),                          //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Date SettlementDate = Date(),                                   //!< The current bond settlement date is used if no specific date is given.
            Real Accuracy = 1.0e-10,                                        //!< tolerance.
            Size MaxIterations = 100,                                       //!< max number of iterations.
            Rate Guess = 0.05                                               //!< guess.
        );
        //! Returns the duration implied by the given yield and settlement date.
        %rename2(duration, bondDurationFromYield);
        static Time duration(
            const Bond& ObjectId,                                           //!< id of existing QuantLib::Bond object
            Rate Yield,                                                     //!< bond yield.
            const DayCounter& dayCounter=ActualActual(ActualActual::ISDA),  //!< Yield DayCounter ID.
            Compounding compounding=Compounding(Compounded),                //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency=Frequency(Annual),                          //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Duration::Type type = Duration::Modified,                       //!< Duration type (Simple, Macaulay, or Modified).
            Date SettlementDate = Date()                                    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the convexity implied by the given yield and settlement date.
        %rename2(convexity, bondConvexityFromYield);
        static Real convexity(
            const Bond& ObjectId,                                           //!< id of existing QuantLib::Bond object
            Rate Yield,                                                     //!< bond yield.
            const DayCounter& dayCounter=ActualActual(ActualActual::ISDA),  //!< Yield DayCounter ID.
            Compounding compounding=Compounding(Compounded),                //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency=Frequency(Annual),                          //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Date SettlementDate = Date()                                    //!< The current bond settlement date is used if no specific date is given.
        );

        // Z-spread functions
        //! Returns the bond clean price implied by the given Z-Spread, discount curve, and settlement date.
        %rename2(cleanPrice, bondCleanPriceFromZSpread);
        static Real cleanPrice(
            const Bond& ObjectId,                                           //!< id of existing QuantLib::Bond object
            const boost::shared_ptr<YieldTermStructure>& YieldCurve,        //!< discounting YieldTermStructure object ID.
            Spread zSpread,                                                 //!< the Z-spread.
            const DayCounter& dayCounter=ActualActual(ActualActual::ISDA),  //!< Yield DayCounter ID.
            Compounding compounding=Compounding(Compounded),                //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency=Frequency(Annual),                          //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Date SettlementDate = Date()                                    //!< The current bond settlement date is used if no specific date is given.
        );
        //! Returns the z-spread for the given bond corresponding to the given clean price and settlement date.
        %rename2(zSpread, bondZSpreadFromCleanPrice);
        static Spread zSpread(
            const Bond& ObjectId,                                           //!< id of existing QuantLib::Bond object
            Real cleanPrice,                                                //!< clean price.
            const boost::shared_ptr<YieldTermStructure>& YieldCurve,        //!< discounting YieldTermStructure object ID.
            const DayCounter& dayCounter=ActualActual(ActualActual::ISDA),  //!< Yield DayCounter ID.
            Compounding compounding=Compounding(Compounded),                //!< Interest rate coumpounding rule (Simple:1+rt, Compounded:(1+r)^t, Continuous:e^{rt}).
            Frequency frequency=Frequency(Annual),                          //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
            Date SettlementDate = Date(),                                   //!< The current bond settlement date is used if no specific date is given.
            Real Accuracy = 1.0e-10,                                        //!< tolerance.
            Size MaxIterations = 100,                                       //!< max number of iterations.
            Rate Guess = 0.05                                               //!< guess.
        );
    };
}    

namespace QuantLibAddin {

    class Bond : public Instrument {
      public:
        //! Returns the bond description string.
        const std::string& description();
        //! Returns the bond currency.
        std::string currency();
        //! Returns the redemption amount of the bond.
        QuantLib::Real redemptionAmount();
        //! Returns the redemption payment date of the bond.
        QuantLib::Date redemptionDate();
        //! Set the coupon pricer at the given Bond object.
        void setCouponPricer(
            const boost::shared_ptr<QuantLib::FloatingRateCouponPricer> &FloatingRateCouponPricer                   //!< FloatingRate coupon pricer object ID.
        );
        //! Set the coupon pricer at the given Bond object.
        void setCouponPricers(
            const std::vector<boost::shared_ptr<QuantLib::FloatingRateCouponPricer> > &FloatingRateCouponPricer     //!< FloatingRate coupon pricer object ID.
        );
        //! Returns the bond cash flow analysis.
        std::vector<std::vector<reposit::property_t> > flowAnalysis(
            const QuantLib::Date& AfterDate                     //!< Shows only cashflows after given date
        );
        Bond(
            const std::string& Description,                     //!< Bond description string. Autogenerated if null
            const QuantLib::Currency& Currency,                 //!< bond Currency.
            QuantLib::Natural SettlementDays,                   //!< settlement days.
            const QuantLib::Calendar& calendar,                 //!< holiday calendar (e.g. TARGET).
            QuantLib::Real FaceAmount,                          //!< Face nominal amount.
            const QuantLib::Date& Maturity,                     //!< maturity date.
            const QuantLib::Date& IssueDate=QuantLib::Date(),   //!< issue date: the bond can't be traded until then.
            const QuantLib::Leg& LegID                          //!< coupon vector Leg object ID.
        );
    };

    class ZeroCouponBond : public Bond {
      public:
        ZeroCouponBond(
            const std::string& Description,                                                 //!< Bond description string. Autogenerated if null
            const QuantLib::Currency& Currency,                                             //!< bond Currency.
            QuantLib::Natural SettlementDays,                                               //!< settlement days.
            const QuantLib::Calendar& calendar,                                             //!< holiday calendar (e.g. TARGET).
            QuantLib::Real FaceAmount,                                                      //!< Face nominal amount.
            const QuantLib::Date& Maturity,                                                 //!< maturity date.
            QuantLib::BusinessDayConvention PaymentBDC=BusinessDayConvention(Following),    //!< payment business day convention.
            QuantLib::Real Redemption=100.0,                                                //!< Redemption value.
            const QuantLib::Date& IssueDate=QuantLib::Date()                                //!< issue date: the bond can't be traded until then.
        );
    };

    class FixedRateBond : public Bond {
      public:
        FixedRateBond(
            const std::string& Description,                                                 //!< Bond description string. Autogenerated if null
            const QuantLib::Currency& Currency,                                             //!< bond Currency.
            QuantLib::Natural SettlementDays,                                               //!< settlement days.
            QuantLib::Real FaceAmount,                                                      //!< Face nominal amount.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                        //!< Schedule object ID.
            const std::vector<QuantLib::Rate>& Coupons,                                     //!< simple annual compounding coupon rates.
            const QuantLib::DayCounter& dayCounter,                                         //!< Payment DayCounter ID.
            QuantLib::BusinessDayConvention PaymentBDC=BusinessDayConvention(Following),    //!< payment business day convention.
            QuantLib::Real Redemption=100.0,                                                //!< Redemption value.
            const QuantLib::Date& IssueDate=QuantLib::Date(),                               //!< issue date: the bond can't be traded until then.
            const QuantLib::Calendar& PaymentCalendar                                       //!< payment holiday calendar (e.g. TARGET).
        );
        %rename(FixedRateBond2) FixedRateBond;
        FixedRateBond(
            const std::string& Description,                                                 //!< Bond description string. Autogenerated if null
            const QuantLib::Currency& Currency,                                             //!< bond Currency.
            QuantLib::Natural SettlementDays,                                               //!< settlement days.
            QuantLib::Real FaceAmount,                                                      //!< Face nominal amount.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                        //!< Schedule object ID.
            const std::vector<boost::shared_ptr<QuantLib::InterestRate> >& coupons,         //!< coupon InterestRate IDs.
            QuantLib::BusinessDayConvention PaymentBDC=BusinessDayConvention(Following),    //!< payment business day convention.
            QuantLib::Real Redemption=100.0,                                                //!< Redemption value.
            const QuantLib::Date& IssueDate=QuantLib::Date(),                               //!< issue date: the bond can't be traded until then.
            const QuantLib::Calendar& PaymentCalendar                                       //!< payment holiday calendar (e.g. TARGET).
        );
    };

    class FloatingRateBond : public Bond {
      public:
        FloatingRateBond(
            const std::string& Description,                                                 //!< Bond description string. Autogenerated if null
            const QuantLib::Currency& Currency,                                             //!< bond Currency.
            QuantLib::Natural SettlementDays,                                               //!< settlement days.
            QuantLib::BusinessDayConvention PaymentBDC/*=BusinessDayConvention(Following)*/,//!< payment business day convention.
            QuantLib::Real FaceAmount,                                                      //!< Face nominal amount.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                        //!< Schedule object ID.
            QuantLib::Natural FixingDays=QuantLib::Null<QuantLib::Natural>(),               //!< fixing days (e.g. 2).
            bool IsInArrears=false,                                                         //!< TRUE if the fixing is in arrears.
            const QuantLib::DayCounter& dayCounter,                                         //!< Payment DayCounter ID.
            const std::vector<QuantLib::Rate>& Floors=std::vector<QuantLib::Rate>(),        //!< floor strikes.
            const std::vector<QuantLib::Real>& Gearings,                                    //!< floating rate gearings.
            const boost::shared_ptr<QuantLib::IborIndex>& index,                            //!< floating rate index.
            const std::vector<QuantLib::Spread>& spreads,                                   //!< floating rate spreads.
            const std::vector<QuantLib::Rate>& caps=std::vector<QuantLib::Rate>(),          //!< cap strikes.
            QuantLib::Real Redemption=100.0,                                                //!< Redemption value.
            const QuantLib::Date& IssueDate=QuantLib::Date()                                //!< issue date: the bond can't be traded until then.
        );
    };

    class CmsRateBond : public Bond {
      public:
        CmsRateBond(
            const std::string& Description,                                                 //!< Bond description string. Autogenerated if null
            const QuantLib::Currency& Currency,                                             //!< bond Currency.
            QuantLib::Natural SettlementDays,                                               //!< settlement days.
            QuantLib::BusinessDayConvention PaymentBDC/*=BusinessDayConvention(Following)*/,//!< payment business day convention.
            QuantLib::Real FaceAmount,                                                      //!< Face nominal amount.
            const boost::shared_ptr<QuantLib::Schedule>& ScheduleID,                        //!< Schedule object ID.
            QuantLib::Natural FixingDays/*=QuantLib::Null<QuantLib::Natural>()*/,           //!< fixing days (e.g. 2).
            bool IsInArrears=false,                                                         //!< TRUE if the fixing is in arrears.
            const QuantLib::DayCounter& dayCounter,                                         //!< Payment DayCounter ID.
            const std::vector<QuantLib::Rate>& Floors/*=std::vector<QuantLib::Rate>()*/,    //!< floor strikes.
            const std::vector<QuantLib::Real>& Gearings,                                    //!< floating rate gearings.
            const boost::shared_ptr<QuantLib::SwapIndex>& index,                            //!< floating rate index.
            const std::vector<QuantLib::Spread>& spreads,                                   //!< floating rate spreads.
            const std::vector<QuantLib::Rate>& caps=std::vector<QuantLib::Rate>(),          //!< cap strikes.
            QuantLib::Real Redemption=100.0,                                                //!< Redemption value.
            const QuantLib::Date& IssueDate=QuantLib::Date()                                //!< issue date: the bond can't be traded until then.
        );
    };

    //! filters the Bond object IDs of the still alive Bonds.
    std::vector<std::string> bondAlive(
        const std::vector<boost::shared_ptr<Bond> >& bonds,     //!< vector of Bond IDs.
        QuantLib::Date& refDate=QuantLib::Date()                //!< reference date at which evaluate alive bonds. The current evaluation date is used if no specific date is given.
    );

    //! returns the first maturity-matching Bond object ID.
    std::string bondMaturityLookup(
        const std::vector<boost::shared_ptr<Bond> >& bonds,     //!< vector of Bond IDs.
        const QuantLib::Date& maturity                          //!< maturity date to look up Bonds for.
    );

    //! sorts the Bond object IDs by maturity.
    std::vector<std::string> bondMaturitySort(
        const std::vector<boost::shared_ptr<Bond> >& bonds      //!< vector of Bond IDs.
    );
}

