
#ifndef obj_quote_hpp
#define obj_quote_hpp

#include <string>
#include <rp/libraryobject.hpp>
#include <rp/valueobject.hpp>
#include <boost/shared_ptr.hpp>
#include <ql/quotes/simplequote.hpp>
#include <ql/quotes/lastfixingquote.hpp>
#include <ql/quotes/futuresconvadjustmentquote.hpp>
#include <ql/quotes/forwardswapquote.hpp>
#include <ql/math/comparison.hpp>

namespace QuantLibAddin {


    // BEGIN typemap rp_tm_default bool
    bool
    // END   typemap rp_tm_default
    close(
        // BEGIN typemap rp_tm_default
        double x,
        double y
        // END   typemap rp_tm_default
    );

    class Quote : public reposit::LibraryObject<QuantLib::Quote> {
        protected:
            Quote(
                const boost::shared_ptr<reposit::ValueObject>& properties,
                bool permanent)
            : reposit::LibraryObject<QuantLib::Quote>(properties, permanent) {}
    public:
        double value() { return libraryObject_->value(); }
        bool isValid() { return libraryObject_->isValid(); }
    };

    class SimpleQuote : 
        public Quote {
    public:
        SimpleQuote(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Real Value,
            QuantLib::Real tickValue,
            // END   typemap rp_tm_default
            bool permanent);
        QuantLib::Real setValue(QuantLib::Real value);
    private:
        boost::shared_ptr<QuantLib::SimpleQuote> simpleQuote_;
    };


    class ForwardSwapQuote : 
        public Quote {
    public:
        ForwardSwapQuote(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            boost::shared_ptr< QuantLib::SwapIndex > const &swapIndex,
            QuantLib::Handle< QuantLib::Quote > const &spread,
            QuantLib::Period const &fwdStart,
            // END   typemap rp_tm_default
            bool permanent)
        : Quote(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new QuantLib::ForwardSwapQuote(
                // BEGIN typemap rp_tm_default
                swapIndex,
                spread,
                fwdStart
                // END   typemap rp_tm_default
            ));
        }
    };


    class LastFixingQuote : 
        public Quote {
    public:
        LastFixingQuote(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            boost::shared_ptr< QuantLib::Index > const &index,
            // END   typemap rp_tm_default
            bool permanent)
        : Quote(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new QuantLib::LastFixingQuote(
                // BEGIN typemap rp_tm_default
                index
                // END   typemap rp_tm_default
            ));
        }
    };


    class FuturesConvAdjustmentQuote : 
        public Quote {
    public:
        FuturesConvAdjustmentQuote(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            boost::shared_ptr< QuantLib::IborIndex > const &index,
            std::string const &immCode,
            QuantLib::Handle< QuantLib::Quote > const &futuresQuote,
            QuantLib::Handle< QuantLib::Quote > const &volatility,
            QuantLib::Handle< QuantLib::Quote > const &meanReversion,
            // END   typemap rp_tm_default
            bool permanent)
        : Quote(properties, permanent) {
            libraryObject_ = boost::shared_ptr<QuantLib::Quote>(new QuantLib::FuturesConvAdjustmentQuote(
                // BEGIN typemap rp_tm_default
                index,
                immCode,
                futuresQuote,
                volatility,
                meanReversion
                // END   typemap rp_tm_default
            ));
        }
    };


    class CompositeQuote : 
        public Quote {
    public:
        CompositeQuote(
            const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Handle< QuantLib::Quote > const &element1,
            QuantLib::Handle< QuantLib::Quote > const &element2,
            std::string const &op,
            // END   typemap rp_tm_default
            bool permanent);
    };

} // namespace QuantLibAddin

#endif

///* -*- mode: c++; tab-width: 4; indent-tabs-mode: nil; c-basic-offset: 4 -*- */
//
///*
// Copyright (C) 2007 Ferdinando Ametrano
// Copyright (C) 2006 Francois du Vignaud
// Copyright (C) 2006 Giorgio Facchinetti
// Copyright (C) 2007 Eric Ehlers
//
// This file is part of QuantLib, a free-software/open-source library
// for financial quantitative analysts and developers - http://quantlib.org/
//
// QuantLib is free software: you can redistribute it and/or modify it
// under the terms of the QuantLib license.  You should have received a
// copy of the license along with this program; if not, please email
// <quantlib-dev@lists.sf.net>. The license is also available online at
// <http://quantlib.org/license.shtml>.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.  See the license for more details.
//*/
//
//#ifndef qla_quotes_hpp
//#define qla_quotes_hpp
//
//#include <qlo/quote.hpp>
//
//#include <ql/option.hpp>
//#include <ql/types.hpp>
//#include <ql/experimental/risk/sensitivityanalysis.hpp>
//
//namespace QuantLib {
//    class Index;
//    class IborIndex;
//    class SwapIndex;
//    class Quote;
//    class SimpleQuote;
//    class Date;
//    class CapsStripper2;
//    class Period;
//
//    template <class T>
//    class Handle;
//}
//
//namespace QuantLibAddin {
//
//    class SimpleQuote : public Quote {
//      public:
//        SimpleQuote(const boost::shared_ptr<reposit::ValueObject>& properties,
//                    QuantLib::Real value,
//                    QuantLib::Real tickValue,
//                    bool permanent);
//        QuantLib::Real tickValue() const;
//        void setTickValue(QuantLib::Real tickValue);
//        // it wraps underlying QuantLib::SimpleQuote method
//        // in order to make SimpleQuote serializable in a stateful way
//        QuantLib::Real setValue(QuantLib::Real value);
//    private:
//        boost::shared_ptr<QuantLib::SimpleQuote> simpleQuote_;
//    };
//
//    class ForwardValueQuote : public Quote {
//      public:
//        ForwardValueQuote(const boost::shared_ptr<reposit::ValueObject>& properties,
//                          const boost::shared_ptr<QuantLib::IborIndex>&,
//                          const QuantLib::Date& fixingDate,
//                          bool permanent);
//    };
//
//    class ForwardSwapQuote : public Quote {
//      public:
//        ForwardSwapQuote(const boost::shared_ptr<reposit::ValueObject>& properties,
//                         const boost::shared_ptr<QuantLib::SwapIndex>& swapIndex,
//                         const QuantLib::Handle<QuantLib::Quote>& spread,
//                         const QuantLib::Period& fwdStart,
//                         bool permanent);
//    };
//
//    class ImpliedStdDevQuote : public Quote {
//      public:
//        ImpliedStdDevQuote(const boost::shared_ptr<reposit::ValueObject>& properties,
//                           QuantLib::Option::Type optionType,
//                           const QuantLib::Handle<QuantLib::Quote>& forward,
//                           const QuantLib::Handle<QuantLib::Quote>& price,
//                           QuantLib::Real strike,
//                           QuantLib::Real guess,
//                           QuantLib::Real accuracy,
//                           bool permanent);
//    };
//
//    class EurodollarFuturesImpliedStdDevQuote : public Quote {
//      public:
//        EurodollarFuturesImpliedStdDevQuote(
//                        const boost::shared_ptr<reposit::ValueObject>& properties,
//                        const QuantLib::Handle<QuantLib::Quote>& forward,
//                        const QuantLib::Handle<QuantLib::Quote>& callPrice,
//                        const QuantLib::Handle<QuantLib::Quote>& putPrice,
//                        QuantLib::Real strike,
//                        QuantLib::Real guess,
//                        QuantLib::Real accuracy,
//                        bool permanent);
//    };
//
//     class FuturesConvAdjustmentQuote : public Quote {
//      public:
//        FuturesConvAdjustmentQuote(
//                    const boost::shared_ptr<reposit::ValueObject>& properties,
//                    const boost::shared_ptr<QuantLib::IborIndex>& index,
//                    const std::string& immCode,
//                    const QuantLib::Handle<QuantLib::Quote>& futuresQuote,
//                    const QuantLib::Handle<QuantLib::Quote>& volatility,
//                    const QuantLib::Handle<QuantLib::Quote>& meanReversion,
//                    bool permanent);
//    };
//
//     class CompositeQuote : public Quote {
//      public:
//        CompositeQuote(
//                    const boost::shared_ptr<reposit::ValueObject>& properties,
//                    const QuantLib::Handle<QuantLib::Quote>& element1,
//                    const QuantLib::Handle<QuantLib::Quote>& element2,
//                    const std::string& op,
//                    bool permanent);
//    };
//
//    class LastFixingQuote : public Quote {
//      public:
//        LastFixingQuote(const boost::shared_ptr<reposit::ValueObject>& p,
//                        const boost::shared_ptr<QuantLib::Index>& index,
//                        bool permanent);
//    };
//
//    std::vector<std::vector<QuantLib::Real> >
//    bucketAnalysis(const std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >&,
//                   const std::vector<boost::shared_ptr<QuantLib::Instrument> >&,
//                   const std::vector<QuantLib::Real>& quant,
//                   QuantLib::Real shift,
//                   QuantLib::SensitivityAnalysis type);
//
//    inline std::vector<QuantLib::Real>
//    bucketAnalysisDelta(const QuantLib::Handle<QuantLib::SimpleQuote>& quote,
//                        const std::vector<QuantLib::Handle<QuantLib::Quote> >& parameters,
//                        QuantLib::Real shift,
//                        QuantLib::SensitivityAnalysis type) {
//        std::vector<QuantLib::Real> deltaVector;
//        std::vector<QuantLib::Real> gammaVector;
//        std::vector<QuantLib::Real> refVals;
//        QuantLib::bucketAnalysis(deltaVector, gammaVector, refVals,
//                                 quote, parameters, shift, type);
//        return deltaVector;
//    }
//
//    std::vector<std::vector<QuantLib::Real> >
//    bucketAnalysisDelta2(const std::vector<QuantLib::Handle<QuantLib::Quote> >& quotes,
//                         const std::vector<QuantLib::Handle<QuantLib::Quote> >& parameters,
//                         QuantLib::Real shift,
//                         QuantLib::SensitivityAnalysis type);
//}
//
//#endif
