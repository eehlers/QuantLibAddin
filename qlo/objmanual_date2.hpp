/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2009, 2015 Ferdinando Ametrano
 Copyright (C) 2015 Maddalena Zanzi

 This file is part of QuantLib, a free-software/open-source library
 for financial quantitative analysts and developers - http://quantlib.org/

 QuantLib is free software: you can redistribute it and/or modify it
 under the terms of the QuantLib license.  You should have received a
 copy of the license along with this program; if not, please email
 <quantlib-dev@lists.sf.net>. The license is also available online at
 <http://quantlib.org/license.shtml>.

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
*/

#ifndef qla_date_hpp
#define qla_date_hpp

#include <ql/time/date.hpp>
#include <ql/time/frequency.hpp>

#include <vector>

namespace QuantLib {
    class Period;
}

namespace QuantLibAddin {

    // to be removed using coercion
    QuantLib::Period periodFromFrequency(QuantLib::Frequency f);

    // to be removed using coercion
    QuantLib::Frequency frequencyFromPeriod(const QuantLib::Period& p);

    // it is not a dummy function!
    // e.g. it returns "11M" when the input is "1Y-1M"
    QuantLib::Period periodEquivalent(const QuantLib::Period& p);

    QuantLib::Date IMMdate(
        const std::string& immCode,
        const QuantLib::Date &referenceDate);

    std::vector<QuantLib::Date> IMMNextDates(const QuantLib::Date& d,
                                               const std::vector<bool>& mainCycle);

    std::vector<std::string> IMMNextCodes(const QuantLib::Date& d,
                                            const std::vector<bool>& mainCycle);
    std::vector<QuantLib::Date> ASXNextDates(const QuantLib::Date& d,
                                               const std::vector<bool>& mainCycle);

    std::vector<std::string> ASXNextCodes(const QuantLib::Date& d,
                                            const std::vector<bool>& mainCycle);
    std::vector<QuantLib::Date> ECBKnownDates();

    std::string IMMcode(const QuantLib::Date& immDate);
    std::string IMMnextCode(const QuantLib::Date& RefDate = QuantLib::Date(),
                                bool MainCycle = true);

    std::string ECBcode(const QuantLib::Date& ecbDate);
    std::string ECBnextCode(const QuantLib::Date& RefDate = QuantLib::Date());
    QuantLib::Date ECBdate(const std::string& ecbCode,
                         const QuantLib::Date& referenceDate = QuantLib::Date());
    QuantLib::Date ECBnextDate(const QuantLib::Date& date = QuantLib::Date());

}

#endif
