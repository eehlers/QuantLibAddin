/* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */

/*
 Copyright (C) 2006, 2010 Ferdinando Ametrano
 Copyright (C) 2007 Eric Ehlers
 Copyright (C) 2016 Stefano Fondi

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

#ifndef qla_capletvolstructure_hpp
#define qla_capletvolstructure_hpp

#include <qlo/objects/objmanual_termstructures.hpp>

#include <ql/types.hpp>
#include <ql/time/businessdayconvention.hpp>
#include <ql/termstructures/volatility/volatilitytype.hpp>

namespace QuantLib {
    class Period;
    class SmileSection;
    class IborIndex;
    class Calendar;
    class DayCounter;
    class Quote;
    class Date;

    template <class T>
    class Handle;

    class CapFloorTermVolSurface;
    class CapFloorTermVolCurve;
    class OptionletStripper1;
    class OptionletStripper2;
    class StrippedOptionletAdapter;
    class StrippedOptionlet;
    class StrippedOptionletBase;
}

namespace QuantLibAddin {
    

    // OptionletVolatilityStructures

    class ConstantOptionletVolatility : public OptionletVolatilityStructure {
      public:
        ConstantOptionletVolatility(
                        const boost::shared_ptr<reposit::ValueObject>&,
                        QuantLib::Natural settlementDays,
                        const QuantLib::Calendar& cal,
                        QuantLib::BusinessDayConvention bdc,
                        const QuantLib::Handle<QuantLib::Quote>& volatility,
                        const QuantLib::DayCounter& dayCounter,
                        QuantLib::VolatilityType type,
                        QuantLib::Real shift,
                        bool permanent);
    };
      
    class SpreadedOptionletVolatility : public OptionletVolatilityStructure {
      public:
        SpreadedOptionletVolatility(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            const QuantLib::Handle<QuantLib::OptionletVolatilityStructure>&,
            const QuantLib::Handle<QuantLib::Quote>&,
            bool permanent);

    };

    class StrippedOptionletAdapter : public OptionletVolatilityStructure {
      public:
        StrippedOptionletAdapter(
                    const boost::shared_ptr<reposit::ValueObject>&,
                    const boost::shared_ptr<QuantLib::StrippedOptionletBase>&,
                    bool permanent);
    };

    // OptionletStrippers

    RP_LIB_CLASS(StrippedOptionletBase, QuantLib::StrippedOptionletBase);

    class StrippedOptionlet : public StrippedOptionletBase {
      public:
        StrippedOptionlet(
        const boost::shared_ptr<reposit::ValueObject>&,
        QuantLib::Natural settlementDays,
        const QuantLib::Calendar& calendar,
        QuantLib::BusinessDayConvention businessDayConvention,
        const boost::shared_ptr<QuantLib::IborIndex>& index,
        const std::vector<QuantLib::Date>& optionletDates,
        const std::vector<QuantLib::Rate>& strikes,
        const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >&,
        const QuantLib::DayCounter& dc,
        QuantLib::VolatilityType type,
        QuantLib::Real shift,
        bool permanent);
    };

    RP_OBJ_CLASS(OptionletStripper, StrippedOptionletBase);

    class OptionletStripper1 : public OptionletStripper {
      public:
        OptionletStripper1(
                    const boost::shared_ptr<reposit::ValueObject>&,
                    const boost::shared_ptr<QuantLib::CapFloorTermVolSurface>&,
                    const boost::shared_ptr<QuantLib::IborIndex>& index,
                    QuantLib::Rate switchStrike,
                    QuantLib::Real accuracy,
                    QuantLib::Natural maxIterations,
                    QuantLib::VolatilityType type,
                    QuantLib::Real shift,
                    bool permanent);
    };

    class OptionletStripper2 : public OptionletStripper {
      public:
        OptionletStripper2(
                    const boost::shared_ptr<reposit::ValueObject>&,
                    const boost::shared_ptr<QuantLib::OptionletStripper1>&,
                    const QuantLib::Handle<QuantLib::CapFloorTermVolCurve>&,
                    bool permanent);
    };

    // CapFloorTermVolatilityStructures

    class CapFloorTermVolCurve : public CapFloorTermVolatilityStructure {
      public:
        CapFloorTermVolCurve(
                      const boost::shared_ptr<reposit::ValueObject>&,
                      QuantLib::Natural settlementDays,
                      const QuantLib::Calendar& calendar,
                      QuantLib::BusinessDayConvention bdc,
                      const std::vector<QuantLib::Period>& optionTenors,
                      const std::vector<QuantLib::Handle<QuantLib::Quote> >&,
                      const QuantLib::DayCounter& dayCounter,
                      bool permanent);
    };

    class CapFloorTermVolSurface : public CapFloorTermVolatilityStructure {
      public:
        CapFloorTermVolSurface(
          const boost::shared_ptr<reposit::ValueObject>&,
          QuantLib::Natural settlementDays,
          const QuantLib::Calendar& calendar,
          QuantLib::BusinessDayConvention bdc,
          const std::vector<QuantLib::Period>& optionTenors,
          const std::vector<QuantLib::Rate>& strikes,
          const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >&,
          const QuantLib::DayCounter& dc,
          bool permanent);
    };

}

#endif
