
%group(date);
%groupCaption(Date);
%override;

namespace QuantLibAddin {

    //! returns a Period from a given Frequency (e.g. 6M from SemiAnnual).
    QuantLib::Period periodFromFrequency(
        const QuantLib::Frequency &Frequency                            //!< frequency (e.g. Annual, Semiannual, Every4Month, Quarterly, Bimonthly, Monthly).
    );

    %loop(frequencyFromPeriod, Period);
    //! returns a Frequency from a given Period (e.g. SemiAnnual from 6M).
    QuantLib::Frequency frequencyFromPeriod(
        const QuantLib::Period &Period                                  //!< period(s) to advance (e.g. 2D for two days , 3W for three weeks, 6M for six months, 1Y for one year).
    );

    //! Returns TRUE if the first period is less than the second.
    bool periodLessThan(
        const QuantLib::Period &Period1,                                //!< left hand side.
        const QuantLib::Period &Period2                                 //!< right hand side.
    );

    //! Returns the period equivalent to the input (e.g. 11M for 1Y-1M).
    QuantLib::Period periodEquivalent(
        const QuantLib::Period &Period                                  //!< input period (e.g. 1Y-1M).
    );

    //! returns the codes for the next contracts listed in the International Money Market section of the Chicago Mercantile Exchange.
    std::vector<std::string> IMMNextCodes(
        const QuantLib::Date& RefDate=QuantLib::Date(),                 //!< date with respect to which the calculations are performed.
        const std::vector<bool>& MainCycle=std::vector<bool>(40, true)  //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
    );

    //! returns the delivery dates for the next contracts listed in the International Money Market section of the Chicago Mercantile Exchange.
    std::vector<QuantLib::Date> IMMNextDates(
        const QuantLib::Date& RefDate=QuantLib::Date(),                 //!< date with respect to which the calculations are performed.
        const std::vector<bool>& MainCycle=std::vector<bool>(40, true)  //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
    );

    //! returns the codes for the next contracts listed in the Australian Securities Exchange.
    std::vector<std::string> ASXNextCodes(
        const QuantLib::Date& RefDate=QuantLib::Date(),                 //!< date with respect to which the calculations are performed.
        const std::vector<bool>& MainCycle=std::vector<bool>(40, true)  //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
    );

    //! returns the delivery dates for the next contracts listed in the Australian Securities Exchange.
    std::vector<QuantLib::Date> ASXNextDates(
        const QuantLib::Date& RefDate=QuantLib::Date(),                 //!< date with respect to which the calculations are performed.
        const std::vector<bool>& MainCycle=std::vector<bool>(40, true)  //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
    );

    //! returns all the known ECB maintenance period start dates.
    std::vector<QuantLib::Date> ECBKnownDates();
}

namespace QuantLib {

    class Date {
    public:
        //! returns the earliest date allowed in QuantLib.
        static Date minDate();
        
        //! returns the latest date allowed in QuantLib.
        static Date maxDate();
        
        %loop(isLeap, Year);
        //! returns TRUE if a year is leap.
        static bool isLeap(
            Year Year                       //!< year (e.g. 2006).
        );
        
        %loop(endOfMonth, Date);
        //! returns the last day of the month to which the given date belongs.
        static Date endOfMonth(
            const Date& Date                //!< date.
        );
        
        %loop(isEndOfMonth, Date);
        //! returns TRUE if a date is the last day of its month.
        static bool isEndOfMonth(
            const Date& Date                //!< date.
        );
        
        %loop(nextWeekday, Date);
        //! Returns the next given weekday following or equal to the given date (e.g., the Friday following Tuesday, January 15th, 2002 was January 18th, 2002).
        static Date nextWeekday(
            const Date& Date,               //!< date.
            Weekday Weekday                 //!< Weekday (e.g. Wednesday, or Wed).
        );
        
        //! Returns the n-th given weekday in the given month and year (e.g., the 4th Thursday of March, 1998 was March 26th, 1998).
        static Date nthWeekday(
            Size Nth,                       //!< ordinal number (greater than zero, less than 6).
            Weekday Weekday,                //!< Weekday (e.g. Wednesday, or Wed).
            Month Month,                    //!< Month (e.g. January, or Jan, or '1').
            Year Year                       //!< year (e.g. 2007).
        );
    };

    struct IMM {
        %loop(isIMMdate, Date);
        //! returns whether or not the given date is an IMM date.
        static bool isIMMdate(
            const Date& Date,               //!< date.
            bool MainCycle=true             //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );
        
        %loop(isIMMcode, Code);
        //! returns whether or not the given code is an IMM code.
        static bool isIMMcode(
            const std::string& Code,        //!< 2 letter string (e.g. H6).
            bool MainCycle=true             //!< FALSE to consider all futures (serial ones included), not just the main March/June/September/December (H, M, U, Z) cycle.
        );

        %loop(code, IMMdate);
        //! returns the code corresponding to a given IMM date (e.g. H5 for Wednesday, March 18th, 2015). It fails if the input date is not an IMM date.
        static std::string code(
            const Date& IMMdate             //!< IMM date.
        );

        //! returns the code for the first contract listed in the International Money Market section of the Chicago Mercantile Exchange.
        static std::string nextCode(
            const Date& RefDate=Date(),     //!< date with respect to which the calculations are performed.
            bool MainCycle=true             //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );
    
        %loop(date, IMMcode);
        //! returns the IMM date corresponding to the given IMM code (e.g. Wednesday, March 18th, 2015 for H5).
        static Date date(
            const std::string& IMMcode,     //!< 2 letter IMM code (e.g. H6).
            const Date& RefDate=Date()      //!< date with respect to which the calculations are performed.
        );
        
        //! returns the delivery date for the first contract listed in the International Money Market section of the Chicago Mercantile Exchange.
        static Date nextDate(
            const Date& RefDate=Date(),     //!< date with respect to which the calculations are performed.
            bool MainCycle=true             //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );
    };

    struct ASX {
        %loop(isASXcode, Date);
        //! returns whether or not the given date is an ASX date.
        static bool isASXdate(
            const Date& Date,               //!< date.
            bool MainCycle=true             //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );

        %loop(isASXcode, Code);
        //! returns whether or not the given code is an ASX code.
        static bool isASXcode(
            const std::string& Code,        //!< 2 letter string (e.g. M5).
            bool MainCycle=true             //!< FALSE to consider all futures (serial ones included), not just the main March/June/September/December (H, M, U, Z) cycle.
        );

        %loop(code, ASXdate);
        //! returns the code corresponding to a given ASX date (e.g. H5 for Friday, March 13th, 2015). It fails if the input date is not an ASX date.
        static std::string code(
            const Date& ASXdate             //!< ASX date.
        );

        //! returns the code for the first contract listed in the Australian Securities Exchange.
        static std::string nextCode(
            const Date& RefDate=Date(),     //!< date with respect to which the calculations are performed.
            bool MainCycle=true             //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );

        %loop(date, ASXcode);
        //! returns the ASX date corresponding to the given ASX code (e.g. Friday, March 13th, 2015 for H5)).
        static Date date(
            const std::string& ASXcode,     //!< 2 letter ASX code (e.g. M5).
            const Date& RefDate=Date()      //!< date with respect to which the calculations are performed.
        );

        //! returns the delivery date for the first contract listed in the Australian Securities Exchange.
        static Date nextDate(
            const Date& RefDate=Date(),     //!< date with respect to which the calculations are performed.
            bool MainCycle=true             //!< TRUE to consider the main March/June/September/December (H, M, U, Z) cycle only.
        );
    };
    
    struct ECB {
        //! add an ECB date to the list of known ECB dates.
        static void addDate(
            const Date& Date                 //!< to be added to the list of known ECB dates.
        );
        
        //! remove an ECB date from the list of known ECB dates.
        static void removeDate(
            const Date& Date                //!< to be removed from the list of known ECB dates.
        );
        
        //! returns the ECB maintenance period start date for the given ECB code.
        static Date date(
            const std::string& ECBcode,     //!< 5 letter ECB code (e.g. MAR10).
            const Date& RefDate=Date()      //!< date with respect to which the calculations are performed.
        );
        
        %rename(date2) date;
        //! returns the ECB maintenance period start date in the given month/year.
        static Date date(
            Month Month,                    //!< month (e.g. January, or Jan, or '1').
            Year Year                       //!< year (e.g. 2010).
        );

        //! returns the code corresponding to a given ECB date (e.g. MAR10 for Wednesday, March xxth, 2010). It fails if the input date is not an ECB date.
        static std::string code(
            const Date& ECBdate             //!< ECB date.
        );

        //! returns the next ECB maintenance period start date following the given date.
        static Date nextDate(
            const Date& Date=Date()         //!< date with respect to which the calculations are performed.
        );

        %rename(nextDate2) nextDate;
        //! returns the next ECB maintenance period start date following the given date.
        static Date nextDate(
            const std::string& Code,        //!< 5 letter ECB code (e.g. MAR10).
            const Date& Date=Date()         //!< date with respect to which the calculations are performed.
        );

        //! returns all the known ECB maintenance period start dates following the given date.
        static std::vector<Date> nextDates(
            const Date& Date=Date()         //!< date with respect to which the calculations are performed.
        );
        
        %loop(isECBdate, Date);
        //! returns whether or not the given date is an ECB maintenance period start date.
        static bool isECBdate(
            const Date& Date                //!< date.
        );
        
        %loop(isECBcode, Code);
        //! returns whether or not the given code is an ECB code.
        static bool isECBcode(
            const std::string& Code         //!< 5 letter ECB code (e.g. MAR10).
        );

        //! returns the code for the first ECB date.
        static std::string nextCode(
            const Date& RefDate=Date()      //!< date with respect to which the calculations are performed.
        );
        
        %rename(nextCode2) nextCode;
        //! returns the code for the next ECB date.
        static std::string nextCode(
            const std::string& Code         //!< 5 letter ECB code (e.g. MAR10).
        );
    };
}

