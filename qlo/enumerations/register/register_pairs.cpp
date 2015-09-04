
/*  
 Copyright (C) 2007 Cristina Duminuco
 Copyright (C) 2006, 2007, 2008 Ferdinando Ametrano
 Copyright (C) 2005, 2006, 2007 Eric Ehlers
 Copyright (C) 2006 Giorgio Facchinetti
 Copyright (C) 2006 Chiara Fornarola
 Copyright (C) 2006 Katiuscia Manzoni
 Copyright (C) 2005 Plamen Neykov
 
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

// This file was generated automatically by gensrc.py.  If you edit this file
// manually then your changes will be lost the next time gensrc runs.

// This source code file was generated from the following stub:
//      c:/Users/erik/Documents/repos/reposit/quantlib/QuantLibAddin/gensrc/stubs/stub.enum.pairs

//#if defined(HAVE_CONFIG_H)     // Dynamically created by configure
//    #include <qlo/config.hpp>
//#endif

#include <rp/enumerations/registry.hpp>
#include <qlo/enumerations/constructors/enumeratedpairs.hpp>

namespace QuantLibAddin {

    void registerEnumeratedCurves() {
    
        {
            reposit::Create<boost::shared_ptr<QuantLib::HistoricalForwardRatesAnalysis> > create;
            create.registerType(reposit::KeyPair("Discount", "BackwardFlat"), reinterpret_cast<void*>(DISCOUNT_BACKWARDFLAT_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("Discount", "ForwardFlat"), reinterpret_cast<void*>(DISCOUNT_FORWARDFLAT_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("Discount", "Linear"), reinterpret_cast<void*>(DISCOUNT_LINEAR_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("Discount", "LogLinear"), reinterpret_cast<void*>(DISCOUNT_LOGLINEAR_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("ForwardRate", "BackwardFlat"), reinterpret_cast<void*>(FORWARDRATE_BACKWARDFLAT_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("ForwardRate", "ForwardFlat"), reinterpret_cast<void*>(FORWARDRATE_FORWARDFLAT_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("ForwardRate", "Linear"), reinterpret_cast<void*>(FORWARDRATE_LINEAR_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("ForwardRate", "LogLinear"), reinterpret_cast<void*>(FORWARDRATE_LOGLINEAR_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("ZeroYield", "BackwardFlat"), reinterpret_cast<void*>(ZEROYIELD_BACKWARDFLAT_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("ZeroYield", "ForwardFlat"), reinterpret_cast<void*>(ZEROYIELD_FORWARDFLAT_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("ZeroYield", "Linear"), reinterpret_cast<void*>(ZEROYIELD_LINEAR_HistoricalForwardRatesAnalysis));
            create.registerType(reposit::KeyPair("ZeroYield", "LogLinear"), reinterpret_cast<void*>(ZEROYIELD_LOGLINEAR_HistoricalForwardRatesAnalysis));
        }

        {
            reposit::Create<boost::shared_ptr<QuantLib::YieldTermStructure> > create;
            create.registerType(reposit::KeyPair("Discount", "BackwardFlat"), reinterpret_cast<void*>(DISCOUNT_BACKWARDFLAT_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "CubicNaturalSpline"), reinterpret_cast<void*>(DISCOUNT_CUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "ForwardFlat"), reinterpret_cast<void*>(DISCOUNT_FORWARDFLAT_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "FritschButlandCubic"), reinterpret_cast<void*>(DISCOUNT_FritschButlandCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "FritschButlandLogCubic"), reinterpret_cast<void*>(DISCOUNT_FritschButlandLogCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "KrugerCubic"), reinterpret_cast<void*>(DISCOUNT_KrugerCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "KrugerLogCubic"), reinterpret_cast<void*>(DISCOUNT_KrugerLogCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "Linear"), reinterpret_cast<void*>(DISCOUNT_LINEAR_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "LogCubicNaturalSpline"), reinterpret_cast<void*>(DISCOUNT_LOGCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "LogLinear"), reinterpret_cast<void*>(DISCOUNT_LOGLINEAR_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "LogParabolic"), reinterpret_cast<void*>(DISCOUNT_LogParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "MonotonicCubicNaturalSpline"), reinterpret_cast<void*>(DISCOUNT_MONOTONICCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "MonotonicLogCubicNaturalSpline"), reinterpret_cast<void*>(DISCOUNT_MONOTONICLOGCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "MonotonicLogParabolic"), reinterpret_cast<void*>(DISCOUNT_MonotonicLogParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "MonotonicParabolic"), reinterpret_cast<void*>(DISCOUNT_MonotonicParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("Discount", "Parabolic"), reinterpret_cast<void*>(DISCOUNT_Parabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "BackwardFlat"), reinterpret_cast<void*>(FORWARDRATE_BACKWARDFLAT_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "CubicNaturalSpline"), reinterpret_cast<void*>(FORWARDRATE_CUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "ForwardFlat"), reinterpret_cast<void*>(FORWARDRATE_FORWARDFLAT_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "FritschButlandCubic"), reinterpret_cast<void*>(FORWARDRATE_FritschButlandCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "FritschButlandLogCubic"), reinterpret_cast<void*>(FORWARDRATE_FritschButlandLogCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "KrugerCubic"), reinterpret_cast<void*>(FORWARDRATE_KrugerCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "KrugerLogCubic"), reinterpret_cast<void*>(FORWARDRATE_KrugerLogCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "Linear"), reinterpret_cast<void*>(FORWARDRATE_LINEAR_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "LogCubicNaturalSpline"), reinterpret_cast<void*>(FORWARDRATE_LOGCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "LogLinear"), reinterpret_cast<void*>(FORWARDRATE_LOGLINEAR_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "LogParabolic"), reinterpret_cast<void*>(FORWARDRATE_LogParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "MonotonicCubicNaturalSpline"), reinterpret_cast<void*>(FORWARDRATE_MONOTONICCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "MonotonicLogCubicNaturalSpline"), reinterpret_cast<void*>(FORWARDRATE_MONOTONICLOGCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "MonotonicLogParabolic"), reinterpret_cast<void*>(FORWARDRATE_MonotonicLogParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "MonotonicParabolic"), reinterpret_cast<void*>(FORWARDRATE_MonotonicParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ForwardRate", "Parabolic"), reinterpret_cast<void*>(FORWARDRATE_Parabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "BackwardFlat"), reinterpret_cast<void*>(ZEROYIELD_BACKWARDFLAT_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "CubicNaturalSpline"), reinterpret_cast<void*>(ZEROYIELD_CUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "ForwardFlat"), reinterpret_cast<void*>(ZEROYIELD_FORWARDFLAT_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "FritschButlandCubic"), reinterpret_cast<void*>(ZEROYIELD_FritschButlandCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "FritschButlandLogCubic"), reinterpret_cast<void*>(ZEROYIELD_FritschButlandLogCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "KrugerCubic"), reinterpret_cast<void*>(ZEROYIELD_KrugerCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "KrugerLogCubic"), reinterpret_cast<void*>(ZEROYIELD_KrugerLogCubic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "Linear"), reinterpret_cast<void*>(ZEROYIELD_LINEAR_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "LogCubicNaturalSpline"), reinterpret_cast<void*>(ZEROYIELD_LOGCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "LogLinear"), reinterpret_cast<void*>(ZEROYIELD_LOGLINEAR_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "LogParabolic"), reinterpret_cast<void*>(ZEROYIELD_LogParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "MonotonicCubicNaturalSpline"), reinterpret_cast<void*>(ZEROYIELD_MONOTONICCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "MonotonicLogCubicNaturalSpline"), reinterpret_cast<void*>(ZEROYIELD_MONOTONICLOGCUBICNATURALSPLINE_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "MonotonicLogParabolic"), reinterpret_cast<void*>(ZEROYIELD_MonotonicLogParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "MonotonicParabolic"), reinterpret_cast<void*>(ZEROYIELD_MonotonicParabolic_PiecewiseYieldCurve));
            create.registerType(reposit::KeyPair("ZeroYield", "Parabolic"), reinterpret_cast<void*>(ZEROYIELD_Parabolic_PiecewiseYieldCurve));
        }

    }

}

