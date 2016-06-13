
%group(date);
%groupCaption(Date);
%override;

namespace QuantLibAddin {

    //! Returns the period equivalent to the input (e.g. 11M for 1Y-1M).
    QuantLib::Period periodEquivalent(
        const QuantLib::Period& p               //!< input period (e.g. 1Y-1M).
        );

    //! returns the delivery dates for the next contracts listed in the International Money Market section of the Chicago Mercantile Exchange.
    std::vector<QuantLib::Date> IMMNextDates(
        const QuantLib::Date& d,                //!< date with respect to which the calculations are performed.
        const std::vector<bool>& mainCycle      //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );

    //! returns the codes for the next contracts listed in the International Money Market section of the Chicago Mercantile Exchange.
    std::vector<std::string> IMMNextCodes(
        const QuantLib::Date& RefDate,          //!< date with respect to which the calculations are performed.
        const std::vector<bool>& mainCycle      //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
    );

    //! returns the delivery dates for the next contracts listed in the Australian Securities Exchange.
    std::vector<QuantLib::Date> ASXNextDates(
        const QuantLib::Date& d,                //!< date with respect to which the calculations are performed.
        const std::vector<bool>& mainCycle      //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
    );

    //! returns the codes for the next contracts listed in the Australian Securities Exchange.
    std::vector<std::string> ASXNextCodes(
        const QuantLib::Date& d,                //!< date with respect to which the calculations are performed.
        const std::vector<bool>& mainCycle      //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
    );

    //! returns all the known ECB maintenance period start dates.
    std::vector<QuantLib::Date> ECBKnownDates();
}

namespace QuantLib {

    class Date {
    public:
        //! returns TRUE if a date is the last day of its month.
        static bool isEndOfMonth(
            const Date& d                       //!< date.
        );
    };

    struct IMM {
        %loop(date, immCode);
        //! returns the IMM date corresponding to the given IMM code (e.g. Wednesday, March 18th, 2015 for H5).
        static Date date(
            const std::string& immCode,         //!< 2 letter IMM code (e.g. H6).
            const Date& referenceDate           //!< date with respect to which the calculations are performed.
        );

        %loop(code, immDate);
        //! returns the code corresponding to a given IMM date (e.g. H5 for Wednesday, March 18th, 2015). It fails if the input date is not an IMM date.
        static std::string code(
            const Date& immDate                 //!< IMM date.
        );

        //! returns the code for the first contract listed in the International Money Market section of the Chicago Mercantile Exchange.
        static std::string nextCode(
            const Date& d,                      //!< date with respect to which the calculations are performed.
            bool mainCycle                      //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );
    };

    struct ECB {
        //! returns the ECB maintenance period start date for the given ECB code.
        static Date date(
            const std::string& ecbCode,         //!< 5 letter ECB code (e.g. MAR10).
            const Date& referenceDate           //!< date with respect to which the calculations are performed.
        );

        //! returns the code corresponding to a given ECB date (e.g. MAR10 for Wednesday, March xxth, 2010). It fails if the input date is not an ECB date.
        static std::string code(
            const Date& ecbDate                 //!< ECB date.
        );

        //! returns the next ECB maintenance period start date following the given date.
        static Date nextDate(
            const Date& d                       //!< date with respect to which the calculations are performed.
        );

        //! returns the code for the first ECB date.
        static std::string nextCode(
            const Date& d                       //!< date with respect to which the calculations are performed.
        );
    };

    struct ASX {
        %loop(isASXcode, date);
        //! returns whether or not the given date is an ASX date.
        static bool isASXdate(
            const Date& date,                   //!< date.
            bool mainCycle                      //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );

        %loop(isASXcode, code);
        //! returns whether or not the given code is an ASX code.
        static bool isASXcode(
            const std::string& code,            //!< 2 letter string (e.g. M5).
            bool mainCycle                      //!< FALSE to consider all futures (serial ones included), not just the main March/June/September/December (H, M, U, Z) cycle.
        );

        //! returns the code corresponding to a given ASX date (e.g. H5 for Friday, March 13th, 2015). It fails if the input date is not an ASX date.
        static std::string code(
            const Date& asxDate                 //!< ASX date.
        );

        //! returns the ASX date corresponding to the given ASX code (e.g. Friday, March 13th, 2015 for H5)).
        static Date date(
            const std::string& asxCode,         //!< 2 letter ASX code (e.g. M5).
            const Date& referenceDate           //!< date with respect to which the calculations are performed.
        );

        //! returns the delivery date for the first contract listed in the Australian Securities Exchange.
        static Date nextDate(
            const Date& refDate,                //!< date with respect to which the calculations are performed.
            bool mainCycle                      //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );

        //! returns the code for the first contract listed in the Australian Securities Exchange.
        static std::string nextCode(
            const Date& refDate,                //!< date with respect to which the calculations are performed.
            bool mainCycle                      //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );
    };
}

