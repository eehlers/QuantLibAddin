
#include <qlo/objmanual_ratehelpers.hpp>
//#include <qlo/conversions/convert2.hpp>

#include <ql/termstructures/yield/ratehelpers.hpp>
#include <ql/termstructures/yield/bondhelpers.hpp>
#include <ql/termstructures/yield/oisratehelper.hpp>

// Within each of the RateHelper classes we want to remember the ID
// of the associated Rate object.  So below we coerce that input
// into a string.  If the caller passed in a double instead of a
// Rate object then the coerce below will fail in which case we
// return an empty string.
std::string f(const reposit::property_t &p) {
    try {
        return reposit::convert2<std::string>(p);
    } catch(...) {
        return std::string();
    }
}

QuantLib::Real QuantLibAddin::RateHelper::quoteValue() {
    return libraryObject_->quote()->value();
}

QuantLib::Date QuantLibAddin::RateHelper::earliestDate() {
    return libraryObject_->earliestDate();
}

QuantLib::Date QuantLibAddin::RateHelper::latestDate() {
    return libraryObject_->latestDate();
}

QuantLibAddin::DepositRateHelper::DepositRateHelper(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::Quote>& rate,
        const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
        bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::DepositRateHelper(rate, iborIndex));
    quoteName_ = f(properties->getSystemProperty("Rate"));
}

QuantLibAddin::DepositRateHelper::DepositRateHelper(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::Quote>& quote,
        const QuantLib::Period& p,
        QuantLib::Natural fixingDays,
        const QuantLib::Calendar& calendar,
        QuantLib::BusinessDayConvention convention,
        bool endOfMonth,
        const QuantLib::DayCounter& dayCounter,
        bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::DepositRateHelper(quote,
                                    p,
                                    fixingDays,
                                    calendar,
                                    convention,
                                    endOfMonth,
                                    dayCounter));
    quoteName_ = f(properties->getSystemProperty("Rate"));
}

QuantLibAddin::FuturesRateHelper::FuturesRateHelper(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::Quote>& price,
        QuantLib::Futures::Type type,
        const QuantLib::Date& date,
        const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
        const QuantLib::Handle<QuantLib::Quote>& convAdj,
        bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::FuturesRateHelper(price, date, iborIndex,convAdj,type));
    quoteName_ = f(properties->getSystemProperty("Price"));
}

QuantLibAddin::SwapRateHelper::SwapRateHelper(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::Quote>& rate,
        const boost::shared_ptr<QuantLib::SwapIndex>& swapIndex,
        const QuantLib::Handle<QuantLib::Quote>& spread,
        const QuantLib::Period& forwardStart,
        const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,
        QuantLib::Pillar::Choice pillarChoice,
        QuantLib::Date customPillar,
        bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::SwapRateHelper(rate, swapIndex, spread, forwardStart,
        discount, pillarChoice, customPillar));
    quoteName_ = f(properties->getSystemProperty("Rate"));
}

QuantLibAddin::SwapRateHelper::SwapRateHelper(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::Quote>& rate,
        QuantLib::Natural settlementDays,
        const QuantLib::Period& p,
        const QuantLib::Calendar& cal,
        const QuantLib::Frequency& fixFreq,
        QuantLib::BusinessDayConvention fixConv,
        const QuantLib::DayCounter& fixDC,
        const boost::shared_ptr<QuantLib::IborIndex>& ibor,
        const QuantLib::Handle<QuantLib::Quote>& spread,
        const QuantLib::Period& forwardStart,
        const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,
        QuantLib::Pillar::Choice pillarChoice,
        QuantLib::Date customPillar,
        bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::SwapRateHelper(rate, p, cal, fixFreq, fixConv, fixDC,
        ibor, spread, forwardStart, discount, settlementDays, pillarChoice,
        customPillar));
    quoteName_ = f(properties->getSystemProperty("Rate"));
}

QuantLibAddin::FraRateHelper::FraRateHelper(
        const boost::shared_ptr<reposit::ValueObject>& properties,
        const QuantLib::Handle<QuantLib::Quote>& rate,
        QuantLib::Period periodToStart,
        const boost::shared_ptr<QuantLib::IborIndex>& iborIndex,
        QuantLib::Pillar::Choice pillarChoice,
        QuantLib::Date customPillar,
        bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::FraRateHelper(rate, periodToStart, iborIndex, pillarChoice, customPillar));
    quoteName_ = f(properties->getSystemProperty("Rate"));
}

QuantLibAddin::FraRateHelper::FraRateHelper(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::Quote>& rate,
            QuantLib::Period periodToStart,
            QuantLib::Natural lengthInMonths,
            QuantLib::Natural fixingDays,
            const QuantLib::Calendar& calendar,
            QuantLib::BusinessDayConvention convention,
            bool endOfMonth,
            const QuantLib::DayCounter& dayCounter,
            QuantLib::Pillar::Choice pillarChoice,
            QuantLib::Date customPillar,
            bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::RateHelper>(new
        QuantLib::FraRateHelper(rate, periodToStart, lengthInMonths, fixingDays,
        calendar, convention, endOfMonth, dayCounter, pillarChoice, customPillar));
    quoteName_ = f(properties->getSystemProperty("Rate"));
}

QuantLibAddin::OISRateHelper::OISRateHelper(
                    const boost::shared_ptr<reposit::ValueObject>& properties,
                    QuantLib::Natural settlementDays,
                    const QuantLib::Period& tenor,
                    const QuantLib::Handle<QuantLib::Quote>& fixedRate,
                    const boost::shared_ptr<QuantLib::OvernightIndex>& overnightIndex,
                    const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,
                    bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::OISRateHelper>(new
        QuantLib::OISRateHelper(settlementDays,
                                tenor,
                                fixedRate,
                                overnightIndex));
    quoteName_ = f(properties->getSystemProperty("FixedRate"));
}

QuantLibAddin::DatedOISRateHelper::DatedOISRateHelper(
                    const boost::shared_ptr<reposit::ValueObject>& properties,
                    const QuantLib::Date& startDate,
                    const QuantLib::Date& endDate,
                    const QuantLib::Handle<QuantLib::Quote>& fixedRate,
                    const boost::shared_ptr<QuantLib::OvernightIndex>& overnightIndex,
                    const QuantLib::Handle<QuantLib::YieldTermStructure>& discount,
                    bool permanent)
: RateHelper(properties, permanent) {
    libraryObject_ = boost::shared_ptr<QuantLib::DatedOISRateHelper>(new
        QuantLib::DatedOISRateHelper(startDate, endDate,
                                     fixedRate,
                                     overnightIndex));
    quoteName_ = f(properties->getSystemProperty("FixedRate"));
}

// helper class
namespace {

    struct RateHelperItem {
        bool isMainFutures;
        bool isSerialFutures;
        bool isDepo;
        std::string objectID;
        long priority;
        QuantLib::Date earliestDate;
        QuantLib::Date latestDate;
        QuantLib::Natural minDist;
        RateHelperItem(bool isMainFutures_inp,
                       bool isSerialFutures_inp,
                       bool isDepo_inp,
                       const std::string& objectID_inp,
                       long priority_inp,
                       const QuantLib::Date& earliestDate_inp,
                       const QuantLib::Date& latestDate_inp,
                       QuantLib::Natural minDist_inp)
        : isMainFutures(isMainFutures_inp), isSerialFutures(isSerialFutures_inp),
          isDepo(isDepo_inp), objectID(objectID_inp),
          priority(priority_inp),
          earliestDate(earliestDate_inp), latestDate(latestDate_inp),
          minDist(minDist_inp)
        {
            QL_REQUIRE(minDist>0, "zero minimum distance not allowed");
        }
    };

    class RateHelperPrioritySorter {
      public:
        // does h1 come before h2?
        bool operator()(const RateHelperItem& h1,
                        const RateHelperItem& h2) const {
            if (h1.latestDate > h2.latestDate)
                return false;
            if (h1.latestDate == h2.latestDate) {
                if (h1.priority > h2.priority) {
                    return false;
                } else if (h1.priority == h2.priority) {
                    return h1.objectID > h2.objectID;
                }
            }
            return true;
        }
    };
}

std::vector<std::string> QuantLibAddin::rateHelperSelection(
    const std::vector<boost::shared_ptr<QuantLibAddin::RateHelper> >& qlarhs,
    const std::vector<QuantLib::Natural>& priority,
    QuantLib::Natural nMainFutures,
    QuantLib::Natural nSerialFutures,
    QuantLib::Natural frontFuturesRollingDays,
    RateHelper::DepoInclusionCriteria depoInclusionCriteria,
    const std::vector<QuantLib::Natural>& minDist)
{
    // Checks
    QL_REQUIRE(!qlarhs.empty(), "no instrument given");
    QuantLib::Size nInstruments = qlarhs.size();
    QL_REQUIRE(priority.size()==nInstruments,
               "priority (" << priority.size() <<
               ") / instruments (" << nInstruments << ") size mismatch");
    QL_REQUIRE(minDist.size()==nInstruments || minDist.size()==1,
               "minDist (" << minDist.size() <<
               ") / instruments (" << nInstruments << ") mismatch");

    // RateHelperItem
    boost::shared_ptr<QuantLibAddin::RateHelper> qlarh;
    boost::shared_ptr<QuantLib::RateHelper> qlrh;
    std::vector<RateHelperItem> rhsAll;
    rhsAll.reserve(nInstruments);
    for (QuantLib::Size i=0; i<nInstruments; ++i) {
        qlarh = qlarhs[i];
        qlarh->getLibraryObject(qlrh);
        std::string qlarh_id = reposit::convert2<std::string>(
            qlarh->propertyValue("OBJECTID"));
        bool isFutures = bool(boost::dynamic_pointer_cast<QuantLibAddin::FuturesRateHelper>(qlarh));
        bool isMainFutures = false, isSerialFutures = false;
        if (isFutures) {
            isMainFutures = (qlrh->earliestDate().month() % 3 == 0);
            isSerialFutures = !isMainFutures;
        }
        bool isDepo = bool(boost::dynamic_pointer_cast<QuantLibAddin::DepositRateHelper>(qlarh));
        rhsAll.push_back(RateHelperItem(isMainFutures,
                                        isSerialFutures,
                                        isDepo,
                                        qlarh_id,
                                        priority[i],
                                        qlrh->earliestDate(),
                                        qlrh->latestDate(),
                                        minDist.size()==1 ? minDist[0] : minDist[i]));
    }

    // Preliminary sort of RateHelperItems according to
    // their latest date and priority
    std::sort(rhsAll.begin(), rhsAll.end(), RateHelperPrioritySorter());

    // Select input rate helpers according to:
    // expiration, maximum number of allowed Main Cycle and Serial Futures, Depo/Futures priorities
    QuantLib::Natural mainFuturesCounter = 0;
    QuantLib::Natural serialFuturesCounter = 0;
    QuantLib::Date evalDate = QuantLib::Settings::instance().evaluationDate();
    std::vector<RateHelperItem> rhs, rhsDepo;

    // Look for the front Futures, if any
    bool thereAreFutures = false;
    QuantLib::Date frontFuturesEarliestDate, frontFuturesLatestDate;
    if (nMainFutures>0 || nSerialFutures>0) {
        QuantLib::Size j=0;
        while (j<nInstruments) {
            if (nMainFutures>0 && rhsAll[j].isMainFutures &&
                    (rhsAll[j].earliestDate-frontFuturesRollingDays >= evalDate)) {
                thereAreFutures = true;
                frontFuturesEarliestDate = rhsAll[j].earliestDate;
                frontFuturesLatestDate = rhsAll[j].latestDate;
                break;
            }
            if (nSerialFutures>0 && rhsAll[j].isSerialFutures &&
                    (rhsAll[j].earliestDate-frontFuturesRollingDays >= evalDate)) {
                thereAreFutures = true;
                frontFuturesEarliestDate = rhsAll[j].earliestDate;
                frontFuturesLatestDate = rhsAll[j].latestDate;
                break;
            }
            ++j;
        }
    }

    // If there are NOT Futures, include all Depos
    if (!thereAreFutures)
        depoInclusionCriteria = RateHelper::AllDepos;

    // Start selection
    bool depoAfterFrontFuturesAlreadyIncluded = false;
    for (QuantLib::Size i=0; i<nInstruments; ++i) {
        if (rhsAll[i].earliestDate >= evalDate) {
            if (rhsAll[i].isDepo) {                 // Check Depo conditions
                switch (depoInclusionCriteria) {
                    case RateHelper::AllDepos:
                   // Include all depos
                        rhs.push_back(rhsAll[i]);
                        break;
                    case RateHelper::DeposBeforeFirstFuturesStartDate:
                    // Include only depos with maturity date before
                    // the front Futures start date
                        if (rhsAll[i].latestDate < frontFuturesEarliestDate)
                            rhs.push_back(rhsAll[i]);
                        break;
                    case RateHelper::DeposBeforeFirstFuturesStartDatePlusOne:
                    // Include only depos with maturity date before
                    // the front Futures start date + 1 more Futures
                        if (rhsAll[i].latestDate < frontFuturesEarliestDate) {
                            rhs.push_back(rhsAll[i]);
                        } else {
                            if (depoAfterFrontFuturesAlreadyIncluded == false) {
                                rhs.push_back(rhsAll[i]);
                                depoAfterFrontFuturesAlreadyIncluded = true;
                            }
                        }
                        break;
                    case RateHelper::DeposBeforeFirstFuturesExpiryDate:
                    // Include only depos with maturity date before
                    // the front Futures expiry date
                        if (rhsAll[i].latestDate < frontFuturesLatestDate)
                            rhs.push_back(rhsAll[i]);
                        break;
                    default:
                        QL_FAIL("unknown/illegal DepoInclusionCriteria");
                }
            } else if (rhsAll[i].isSerialFutures) {       // Check Serial Futures conditions
                if (serialFuturesCounter<nSerialFutures &&
                       (rhsAll[i].earliestDate-frontFuturesRollingDays >= evalDate)) {
                    ++serialFuturesCounter;
                    rhs.push_back(rhsAll[i]);
                }
            } else if (rhsAll[i].isMainFutures) {       // Check Main Cycle Futures conditions
                if (mainFuturesCounter<nMainFutures &&
                       (rhsAll[i].earliestDate-frontFuturesRollingDays >= evalDate)) {
                    ++mainFuturesCounter;
                    rhs.push_back(rhsAll[i]);
                }
            } else {                                // No conditions for other instruments
                rhs.push_back(rhsAll[i]);
            }
        }
    }

    std::vector<RateHelperItem>::iterator k;

    if (rhs.size()>1) {
        // Sort rate helpers according to their latest date and priority
        std::sort(rhs.begin(), rhs.end(), RateHelperPrioritySorter());

        // remove RateHelpers with near latestDate
        k = rhs.begin();
        QuantLib::Natural distance, minDistance;
        while (k != rhs.end()-1) {
            distance = static_cast<QuantLib::Natural>((k+1)->latestDate - k->latestDate);
            minDistance = std::max(k->minDist, (k+1)->minDist);
            if ( distance < minDistance) {
                if (k->priority <= (k+1)->priority)
                    k = rhs.erase(k);
                else
                    rhs.erase(k+1);
            } else ++k;
        }
    }

    std::vector<std::string> result;
    for (k = rhs.begin(); k != rhs.end(); ++k)
        result.push_back(k->objectID);
    return result;
}

namespace {

    class RateInspector
        : public QuantLib::AcyclicVisitor,
          public QuantLib::Visitor<QuantLib::DepositRateHelper>,
          public QuantLib::Visitor<QuantLib::FraRateHelper>,
          public QuantLib::Visitor<QuantLib::FuturesRateHelper>,
          public QuantLib::Visitor<QuantLib::SwapRateHelper>,
          public QuantLib::Visitor<QuantLib::OISRateHelper>,
          public QuantLib::Visitor<QuantLib::DatedOISRateHelper>,
          public QuantLib::Visitor<QuantLib::BMASwapRateHelper>,
          public QuantLib::Visitor<QuantLib::FixedRateBondHelper> {
        QuantLib::Rate rate_;
      public:
        QuantLib::Rate rate() const { return rate_; }
        void visit(QuantLib::DepositRateHelper& h) {
            rate_ = h.quote()->value();
        }
        void visit(QuantLib::FraRateHelper& h) {
            rate_ = h.quote()->value();
        }
        void visit(QuantLib::FuturesRateHelper& h) {
            QuantLib::Rate futureRate = 1.0 - h.quote()->value()/100.0;
            QuantLib::Rate convAdj = h.convexityAdjustment();
            // Convexity, as FRA/futures adjustment, has been used in the
            // past to take into account futures margining vs FRA.
            // Therefore, there's no requirement for it to be non-negative.
            rate_ = futureRate - convAdj;
        }
        void visit(QuantLib::SwapRateHelper& h) {
            rate_ = h.quote()->value();
        }
        void visit(QuantLib::OISRateHelper& h) {
            rate_ = h.quote()->value();
        }
        void visit(QuantLib::DatedOISRateHelper& h) {
            rate_ = h.quote()->value();
        }
        void visit(QuantLib::BMASwapRateHelper& h) {
            rate_ = h.quote()->value();
        }
        void visit(QuantLib::FixedRateBondHelper& h) {
            QL_FAIL("not implemented yet");
        }
    };
}

QuantLib::Real QuantLibAddin::rateHelperRate(
    const boost::shared_ptr<QuantLibAddin::RateHelper>& qlarh) {

    boost::shared_ptr<QuantLib::RateHelper> qlrh;
    qlarh->getLibraryObject(qlrh);

    RateInspector v;
    qlrh->accept(v);
    return v.rate();
}
