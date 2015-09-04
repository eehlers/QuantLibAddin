
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
//      c:/Users/erik/Documents/repos/reposit/quantlib/QuantLibAddin/gensrc/stubs/stub.enum.classes

//#if defined(HAVE_CONFIG_H)     // Dynamically created by configure
//    #include <qlo/config.hpp>
//#endif

#include <qlo/enumerations/constructors/enumeratedclasses.hpp>
#include <qlo/enumerations/factories/conundrumpricerfactory.hpp>
#include <qlo/enumerations/factories/iborcouponpricersfactory.hpp>
#include <qlo/enumerations/factories/interpolationsfactory.hpp>
#include <qlo/enumerations/factories/payoffsfactory.hpp>
#include <qlo/enumerations/factories/pricingenginesfactory.hpp>

namespace QuantLibAddin {

    void registerEnumeratedClasses() {
    
        //{
        //    reposit::Create<reposit::PricingEngineConstructor1> create;
        //    create.registerType("AB", reinterpret_cast<void*>(AB_Engine));
        //    create.registerType("AC", reinterpret_cast<void*>(AC_Engine));
        //    create.registerType("ACGAPA", reinterpret_cast<void*>(ACGAPA_Engine));
        //    create.registerType("ADA", reinterpret_cast<void*>(ADA_Engine));
        //    create.registerType("ADE", reinterpret_cast<void*>(ADE_Engine));
        //    create.registerType("ADGAPA", reinterpret_cast<void*>(ADGAPA_Engine));
        //    create.registerType("AE", reinterpret_cast<void*>(AE_Engine));
        //    create.registerType("AP", reinterpret_cast<void*>(AP_Engine));
        //    create.registerType("BAWA", reinterpret_cast<void*>(BAWA_Engine));
        //    create.registerType("BSA", reinterpret_cast<void*>(BSA_Engine));
        //    create.registerType("I", reinterpret_cast<void*>(I_Engine));
        //    create.registerType("PE", reinterpret_cast<void*>(PE_Engine));
        //    create.registerType("SE", reinterpret_cast<void*>(SE_Engine));
        //}

        //{
        //    reposit::Create<reposit::PricingEngineConstructor2> create;
        //    create.registerType("AEQPB", reinterpret_cast<void*>(AEQPB_Engine));
        //    create.registerType("CRR", reinterpret_cast<void*>(CRR_Engine));
        //    create.registerType("FDA", reinterpret_cast<void*>(FDA_Engine));
        //    create.registerType("FDB", reinterpret_cast<void*>(FDB_Engine));
        //    create.registerType("FDE", reinterpret_cast<void*>(FDE_Engine));
        //    create.registerType("JOSHI", reinterpret_cast<void*>(JOSHI_Engine));
        //    create.registerType("JR", reinterpret_cast<void*>(JR_Engine));
        //    create.registerType("LR", reinterpret_cast<void*>(LR_Engine));
        //    create.registerType("TIAN", reinterpret_cast<void*>(TIAN_Engine));
        //    create.registerType("TRI", reinterpret_cast<void*>(TRI_Engine));
        //}

        {
            reposit::Create<boost::shared_ptr<QuantLib::CmsCouponPricer> > create;
            create.registerType("ConundrumByBlack", reinterpret_cast<void*>(CONUNDRUM_BY_BLACK_Pricer));
            create.registerType("ConundrumByNumericalIntegration", reinterpret_cast<void*>(CONUNDRUM_BY_NUMERICAL_INTEGRATION_Pricer));
        }

        {
            reposit::Create<boost::shared_ptr<QuantLib::IborCouponPricer> > create;
            create.registerType("DummyIborByBlack", reinterpret_cast<void*>(IBOR_BY_BLACK_Pricer));
            create.registerType("IborByBlack", reinterpret_cast<void*>(IBOR_BY_BLACK_Pricer));
        }

        {
            reposit::Create<boost::shared_ptr<QuantLib::Interpolation> > create;
            create.registerType("Abcd", reinterpret_cast<void*>(ABCD_Interpolation));
            create.registerType("BackwardFlat", reinterpret_cast<void*>(BACKWARDFLAT_Interpolation));
            create.registerType("CubicNaturalSpline", reinterpret_cast<void*>(CUBICNATURALSPLINE_Interpolation));
            create.registerType("ForwardFlat", reinterpret_cast<void*>(FORWARDFLAT_Interpolation));
            create.registerType("FritschButlandCubic", reinterpret_cast<void*>(FritschButlandCubic_Interpolation));
            create.registerType("FritschButlandLogCubic", reinterpret_cast<void*>(FritschButlandLogCubic_Interpolation));
            create.registerType("KrugerCubic", reinterpret_cast<void*>(KrugerCubic_Interpolation));
            create.registerType("KrugerLogCubic", reinterpret_cast<void*>(KrugerLogCubic_Interpolation));
            create.registerType("Linear", reinterpret_cast<void*>(LINEAR_Interpolation));
            create.registerType("LogCubicNaturalSpline", reinterpret_cast<void*>(LOGCUBICNATURALSPLINE_Interpolation));
            create.registerType("LogLinear", reinterpret_cast<void*>(LOGLINEAR_Interpolation));
            create.registerType("LogParabolic", reinterpret_cast<void*>(LogParabolic_Interpolation));
            create.registerType("MonotonicCubicNaturalSpline", reinterpret_cast<void*>(MONOTONICCUBICNATURALSPLINE_Interpolation));
            create.registerType("MonotonicLogCubicNaturalSpline", reinterpret_cast<void*>(MONOTONICLOGCUBICNATURALSPLINE_Interpolation));
            create.registerType("MonotonicLogParabolic", reinterpret_cast<void*>(MonotonicLogParabolic_Interpolation));
            create.registerType("MonotonicParabolic", reinterpret_cast<void*>(MonotonicParabolic_Interpolation));
            create.registerType("Parabolic", reinterpret_cast<void*>(Parabolic_Interpolation));
        }

        {
            reposit::Create<boost::shared_ptr<QuantLib::Interpolation2D> > create;
            create.registerType("BiCubic", reinterpret_cast<void*>(BICUBICSPLINE));
            create.registerType("BiLinear", reinterpret_cast<void*>(BILINEAR_Interpolation));
        }

        {
            reposit::Create<boost::shared_ptr<QuantLib::Payoff> > create;
            create.registerType("AssetOrNothing", reinterpret_cast<void*>(ASSETORNOTHING_Payoff));
            create.registerType("CashOrNothing", reinterpret_cast<void*>(CASHORNOTHING_Payoff));
            create.registerType("Gap", reinterpret_cast<void*>(GAP_Payoff));
            create.registerType("PercentageStrike", reinterpret_cast<void*>(PERCENTAGESTRIKE_Payoff));
            create.registerType("PlainVanilla", reinterpret_cast<void*>(VANILLA_Payoff));
            create.registerType("SuperFund", reinterpret_cast<void*>(SUPERFUND_Payoff));
            create.registerType("SuperShare", reinterpret_cast<void*>(SUPERSHARE_Payoff));
            create.registerType("Vanilla", reinterpret_cast<void*>(VANILLA_Payoff));
        }

    }

}

