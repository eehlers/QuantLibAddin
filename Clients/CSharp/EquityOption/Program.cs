
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

// This program partially replicates the behavior of the following QuantLib C++ example program:
//     QuantLib/Examples/EquityOption/EquityOption.cpp
// Instead of directly calling the QuantLib C++ library, this program calls a QuantLibAddin DLL
// which has been wrapped for use by C#.  The DLL has the same interface as the Excel addin.

namespace EquityOption
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine("Equity Option");
                QuantLibAddin.Export.qlInitializeAddin();
                string qlv = QuantLibAddin.Export.qlVersion();
                Console.WriteLine("QuantLib version = " + qlv);
                StringBuilder calendar = new StringBuilder("TARGET");
                int todaysDate = 35930;//(15, May, 1998);
                int settlementDate = 35932;//(17, May, 1998);
                QuantLibAddin.Export.qlSettingsSetEvaluationDate(todaysDate);

                // our options
                StringBuilder type = new StringBuilder("Put");
                double underlying = 36;
                double strike = 40;
                double dividendYield = 0.00;
                double riskFreeRate = 0.06;
                double volatility = 0.20;
                int maturity = 36297;//(17, May, 1999);
                StringBuilder dayCounter = new StringBuilder("Actual/365 (Fixed)");

                Console.WriteLine("Option type = " + type);
                Console.WriteLine("Maturity = " + maturity);
                Console.WriteLine("Underlying price = " + underlying);
                Console.WriteLine("Strike = " + strike);
                Console.WriteLine("Risk-free interest rate = " + riskFreeRate);
                Console.WriteLine("Dividend yield = " + dividendYield);
                Console.WriteLine("Volatility = " + volatility);
                Console.WriteLine();

                int Trigger = 0;
                bool Overwrite = true;
                bool Permanent = false;
                StringBuilder europeanExerciseID = new StringBuilder("europeanExercise");
                QuantLibAddin.Export.qlEuropeanExercise(Trigger, europeanExerciseID, Overwrite, Permanent, maturity);

                StringBuilder underlyingID = new StringBuilder("underlying");
                QuantLibAddin.Export.qlSimpleQuote(Trigger, underlyingID, Overwrite, Permanent, underlying);

                // bootstrap the yield/dividend/vol curves
                StringBuilder flatTermStructureID = new StringBuilder("flatTermStructure");
                QuantLibAddin.Export.qlFlatForward(Trigger, flatTermStructureID, Overwrite, Permanent, settlementDate, riskFreeRate, dayCounter);
                StringBuilder flatDividendTSID = new StringBuilder("flatDividendTS");
                QuantLibAddin.Export.qlFlatForward(Trigger, flatDividendTSID, Overwrite, Permanent, settlementDate, dividendYield, dayCounter);
                StringBuilder flatVolTSID = new StringBuilder("flatVolTS");
                QuantLibAddin.Export.qlBlackConstantVol(Trigger, flatVolTSID, Overwrite, Permanent, settlementDate, calendar, volatility, dayCounter);
                StringBuilder bsmProcessID = new StringBuilder("bsmProcess");
                QuantLibAddin.Export.qlBlackScholesMertonProcess(Trigger, bsmProcessID, Overwrite, Permanent, underlyingID, flatDividendTSID, flatTermStructureID, flatVolTSID);

                // options
                StringBuilder payoffID = new StringBuilder("payoff");
                QuantLibAddin.Export.qlPlainVanillaPayoff(Trigger, payoffID, Overwrite, Permanent, type, strike);
                StringBuilder europeanOptionID = new StringBuilder("europeanOption");
                QuantLibAddin.Export.qlVanillaOption(Trigger, europeanOptionID, Overwrite, Permanent, payoffID, europeanExerciseID);

                // Analytic formulas:

                // Black-Scholes for European
                StringBuilder engineID = new StringBuilder("engine");
                QuantLibAddin.Export.qlAnalyticEuropeanEngine(Trigger, engineID, Overwrite, Permanent, bsmProcessID);
                QuantLibAddin.Export.qlInstrumentSetPricingEngine(Trigger, europeanOptionID, engineID);
                double npv = QuantLibAddin.Export.qlInstrumentNPV(Trigger, europeanOptionID);

                Console.WriteLine("Method                             European       Bermudan       American       ");
                Console.WriteLine("Black-Scholes                      " + npv + "    N/A            N/A            ");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }
    }
}
