using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace BermudanSwaption
{
    class Program
    {
        const int Trigger = 0;
        const bool Overwrite = true;
        const bool Permanent = false;

        // Number of swaptions to be calibrated to...

        const int numRows = 5;
        const int numCols = 5;

        static int[] swapLengths = {
            1, 2, 3, 4, 5};
        static double[] swaptionVols = {
          0.1490, 0.1340, 0.1228, 0.1189, 0.1148,
          0.1290, 0.1201, 0.1146, 0.1108, 0.1040,
          0.1149, 0.1112, 0.1070, 0.1010, 0.0957,
          0.1047, 0.1021, 0.0980, 0.0951, 0.1270,
          0.1000, 0.0950, 0.0900, 0.1230, 0.1160};

        // QuantLibAddin returns an IntPtr which points to an array.
        // The array is guaranteed to have size >= 1.
        // The 0th element contains the size of the rest of the array.
        static int[] intPtrToIntArray(IntPtr p) {
            // Determine the size of the array.
            int[] temp = new int[1];
            Marshal.Copy(p, temp, 0, 1);
            int len = temp[0];
            // Extract the array.
            int[] temp2 = new int[len + 1];
            Marshal.Copy(p, temp2, 0, len + 1);
            int[] ret = new int[len];
            for (int i = 0; i < len; i++)
                ret[i] = temp2[i + 1];
            QuantLibAddin.Export.qlReleaseMemory(p);
            return ret;
        }

        // In the QuantLibAddin interface, function qlCalendarAdvance() is a "loop" function.
        // That means it accepts a list of inputs, executes once per item, and returns a list of outputs.
        // That behavior is useful in Excel but less so in C#.
        // The permanent solution will be to use an "any" datatype to hold a list.
        // For now we provide a wrapper which accepts a single value and returns a single value.
        static int calendarAdvance(StringBuilder calendar, int d, string period, StringBuilder c)
        {
            // Create a list of size one to hold the input value.
            string[] periods = new string[1];
            periods[0] = period;
            // Call the function.
            IntPtr p = QuantLibAddin.Export.qlCalendarAdvance(
                Trigger, calendar, d,
                1, periods, c, false);
            // The return value is an array where the 0th element specifies the size.
            // Ensure that the array contains a single value.
            int[] temp = new int[1];
            Marshal.Copy(p, temp, 0, 1);
            if (1 != temp[0])
                throw new System.InvalidOperationException("array size != 1");
            // Now extract the single value and return it.
            int[] retArray = new int[2];
            Marshal.Copy(p, retArray, 0, 2);
            QuantLibAddin.Export.qlReleaseMemory(p);
            return retArray[1];
        }

        static void calibrateModel(StringBuilder model, List<StringBuilder> helpers)
        {

            StringBuilder omID = new StringBuilder("om");
            QuantLibAddin.Export.qlLevenbergMarquardt(
                Trigger, omID, Overwrite, Permanent);

            StringBuilder ecID = new StringBuilder("ec");
            QuantLibAddin.Export.qlEndCriteria(
                Trigger, ecID, Overwrite, Permanent,
                400, 100, 0.00000001, 0.00000001, 0.00000001);

            List<String> temp = new List<String>();
            for (int i = 0; i < helpers.Count; i++)
                temp.Add(helpers[i].ToString());

            QuantLibAddin.Export.qlCalibratedModelCalibrate(
                Trigger, model, temp.Count, temp.ToArray(), omID, ecID);

            // Output the implied Black volatilities
            for (int i = 0; i < numRows; i++)
            {
                int j = numCols - i - 1; // 1x5, 2x4, 3x3, 4x2, 5x1
                int k = i * numCols + j;

                StringBuilder swaptionHelperID =
                    new StringBuilder("swaptionHelper" + i);
                double npv = QuantLibAddin.Export.qlSwaptionHelperModelValue(
                    Trigger, swaptionHelperID);
                double implied =
                    QuantLibAddin.Export.qlCalibrationHelperImpliedVolatility(
                    Trigger, swaptionHelperID, npv, 1e-4, 1000, 0.05, 0.50);
                double diff = implied - swaptionVols[k];

                Console.WriteLine((i + 1) + "x" + swapLengths[j]
                          + ": model " + implied
                          + ", market " + swaptionVols[k]
                          + " (" + diff + ")");
            }
        }

        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine("Bermudan Swaption");

                QuantLibAddin.Export.qlInitializeAddin();
                string qlv = QuantLibAddin.Export.qlVersion();
                Console.WriteLine("QuantLib version = " + qlv);

                StringBuilder calendar = new StringBuilder("TARGET");
                int todaysDate = 37302;     // 15 Feb 2002
                int settlementDate = 37306; // 19 Feb 2002
                QuantLibAddin.Export.qlSettingsSetEvaluationDate(todaysDate);

                // flat yield term structure impling 1x5 swap at 5%
                double flatRate = 0.04875825;
                StringBuilder flatRateID = new StringBuilder("flatRate");
                QuantLibAddin.Export.qlSimpleQuote(
                    Trigger, flatRateID, Overwrite, Permanent, flatRate);

                StringBuilder dayCounter =
                    new StringBuilder("Actual/365 (Fixed)");
                StringBuilder flatForwardID = new StringBuilder("flatForward");
                QuantLibAddin.Export.qlFlatForward(
                    Trigger, flatForwardID, Overwrite, Permanent,
                    settlementDate, flatRate, dayCounter);

                StringBuilder rhTermStructureID =
                    new StringBuilder("rhTermStructure");
                QuantLibAddin.Export.qlRelinkableHandleYieldTermStructure(
                    Trigger, rhTermStructureID, Overwrite, Permanent,
                    flatForwardID);

                // Define the ATM/OTM/ITM swaps
                StringBuilder fixedLegFrequency =
                    new StringBuilder("Annual");
                StringBuilder fixedLegConvention =
                    new StringBuilder("Unadjusted");
                StringBuilder floatingLegConvention =
                    new StringBuilder("Modified Following");
                StringBuilder fixedLegDayCounter =
                    new StringBuilder("30/360 (Eurobond Basis)");
                StringBuilder floatingLegFrequency =
                    new StringBuilder("Semiannual");
                StringBuilder type = new StringBuilder("Payer");
                double dummyFixedRate = 0.03;

                StringBuilder tenor6M =
                    new StringBuilder("6M");
                StringBuilder indexSixMonthsID =
                    new StringBuilder("indexSixMonths");
                QuantLibAddin.Export.qlEuribor(
                    Trigger, indexSixMonthsID, Overwrite, Permanent,
                    tenor6M, rhTermStructureID);
                StringBuilder indexSixMonthsTenor =
                //    QuantLibAddin.Export.qlInterestRateIndexTenor(
                //        Trigger, indexSixMonthsID);
                // The above function is not yet implemented so for the moment the value is hard-coded.
                    new StringBuilder("6M");
                string indexSixMonthsDayCounter =
                    QuantLibAddin.Export.qlInterestRateIndexDayCounter(
                        Trigger, indexSixMonthsID);
                StringBuilder indexSixMonthsDayCounter2 = new StringBuilder(indexSixMonthsDayCounter);

                int startDate = calendarAdvance(calendar, settlementDate, "1Y", floatingLegConvention);
                int maturity = calendarAdvance(calendar, startDate, "5Y", floatingLegConvention);

                StringBuilder fixedScheduleID =
                    new StringBuilder("fixedSchedule");
                StringBuilder oneYear = new StringBuilder("1Y");
                StringBuilder forward = new StringBuilder("Forward");
                QuantLibAddin.Export.qlSchedule(
                    Trigger, fixedScheduleID, Overwrite, Permanent,
                    startDate, maturity, oneYear, calendar,
                    fixedLegConvention, fixedLegConvention, forward,
                    false, 0, 0);
                StringBuilder floatScheduleID =
                    new StringBuilder("floatSchedule");
                StringBuilder sixMonth = new StringBuilder("6M");
                QuantLibAddin.Export.qlSchedule(
                    Trigger, floatScheduleID, Overwrite, Permanent,
                    startDate, maturity, sixMonth, calendar,
                    floatingLegConvention, floatingLegConvention, forward,
                    false, 0, 0);

                StringBuilder swapID = new StringBuilder("swap");
                QuantLibAddin.Export.qlVanillaSwap(
                    Trigger, swapID, Overwrite, Permanent,
                    type, 1000, fixedScheduleID, dummyFixedRate,
                    fixedLegDayCounter, floatScheduleID,
                    indexSixMonthsID, 0, indexSixMonthsDayCounter2);

                StringBuilder pricingEngineID =
                    new StringBuilder("pricingEngine");
                QuantLibAddin.Export.qlDiscountingSwapEngine(
                    Trigger, pricingEngineID, Overwrite, Permanent, rhTermStructureID,
                    false, 0, 0);
                QuantLibAddin.Export.qlInstrumentSetPricingEngine(
                    Trigger, swapID, pricingEngineID);

                double fixedATMRate =
                    QuantLibAddin.Export.qlVanillaSwapFairRate(Trigger, swapID);
                double fixedOTMRate = fixedATMRate * 1.2;
                double fixedITMRate = fixedOTMRate * 0.8;

                StringBuilder atmSwapID = new StringBuilder("atmSwap");
                QuantLibAddin.Export.qlVanillaSwap(
                    Trigger, atmSwapID, Overwrite, Permanent,
                    type, 1000, fixedScheduleID, fixedATMRate,
                    fixedLegDayCounter, floatScheduleID,
                    indexSixMonthsID, 0, indexSixMonthsDayCounter2);
                StringBuilder otmSwapID = new StringBuilder("otmSwap");
                QuantLibAddin.Export.qlVanillaSwap(
                    Trigger, otmSwapID, Overwrite, Permanent,
                    type, 1000, fixedScheduleID, fixedOTMRate,
                    fixedLegDayCounter, floatScheduleID,
                    indexSixMonthsID, 0, indexSixMonthsDayCounter2);
                StringBuilder itmSwapID = new StringBuilder("itmSwap");
                QuantLibAddin.Export.qlVanillaSwap(
                    Trigger, itmSwapID, Overwrite, Permanent,
                    type, 1000, fixedScheduleID, fixedITMRate,
                    fixedLegDayCounter, floatScheduleID,
                    indexSixMonthsID, 0, indexSixMonthsDayCounter2);

                // defining the swaptions to be used in model calibration
                List<StringBuilder> swaptionMaturities =
                    new List<StringBuilder>();
                swaptionMaturities.Add(new StringBuilder("1Y"));
                swaptionMaturities.Add(new StringBuilder("2Y"));
                swaptionMaturities.Add(new StringBuilder("3Y"));
                swaptionMaturities.Add(new StringBuilder("4Y"));
                swaptionMaturities.Add(new StringBuilder("5Y"));

                List<StringBuilder> swaptions = new List<StringBuilder>();

                for (int i = 0; i < numRows; i++)
                {
                    int j = numCols - i - 1; // 1x5, 2x4, 3x3, 4x2, 5x1
                    int k = i * numCols + j;

                    StringBuilder volID = new StringBuilder("vol" + i);
                    QuantLibAddin.Export.qlSimpleQuote(
                        Trigger, volID, Overwrite, Permanent, swaptionVols[k]);

                    StringBuilder swaptionHelperID =
                        new StringBuilder("swaptionHelper" + i);
                    QuantLibAddin.Export.qlSwaptionHelper(
                        Trigger,
                        swaptionHelperID,
                        Overwrite,
                        Permanent,
                        swaptionMaturities[i],
                        swaptionMaturities[j],
                        volID,
                        indexSixMonthsID,
                        indexSixMonthsTenor,
                        indexSixMonthsDayCounter2,
                        indexSixMonthsDayCounter2,
                        rhTermStructureID);
                    swaptions.Add(swaptionHelperID);
                }

                // defining the models
                StringBuilder modelG2ID = new StringBuilder("modelG2");
                QuantLibAddin.Export.qlG2Model(
                    Trigger, modelG2ID, Overwrite, Permanent,
                    rhTermStructureID);

                StringBuilder modelHWID = new StringBuilder("modelHW");
                QuantLibAddin.Export.qlHullWhite(
                    Trigger, modelHWID, Overwrite, Permanent,
                    rhTermStructureID);

                // model calibrations

                Console.WriteLine("G2 (analytic formulae) calibration");
                for (int i = 0; i < swaptions.Count; i++)
                {
                    StringBuilder engineID = new StringBuilder("g2engine" + i);
                    QuantLibAddin.Export.qlG2SwaptionEngine(
                        Trigger, engineID, Overwrite, Permanent,
                        modelG2ID, 6.0, 16);

                    StringBuilder swaptionHelperID =
                        new StringBuilder("swaptionHelper" + i);
                    QuantLibAddin.Export.qlCalibrationHelperSetPricingEngine(
                        Trigger, swaptionHelperID, engineID);
                }

                calibrateModel(modelG2ID, swaptions);
                //std::cout << "calibrated to:\n"
                //          << "a     = " << modelG2->params()[0] << ", "
                //          << "sigma = " << modelG2->params()[1] << "\n"
                //          << "b     = " << modelG2->params()[2] << ", "
                //          << "eta   = " << modelG2->params()[3] << "\n"
                //          << "rho   = " << modelG2->params()[4]
                //          << std::endl << std::endl;

                Console.WriteLine("Hull-White (analytic formulae) calibration");
                for (int i = 0; i < swaptions.Count; i++)
                {
                    StringBuilder engineID = new StringBuilder("hwengine" + i);
                    QuantLibAddin.Export.qlJamshidianSwaptionEngine(
                        Trigger, engineID, Overwrite, Permanent, modelHWID);

                    StringBuilder swaptionHelperID =
                        new StringBuilder("swaptionHelper" + i);
                    QuantLibAddin.Export.qlCalibrationHelperSetPricingEngine(
                        Trigger, swaptionHelperID, engineID);
                }

                calibrateModel(modelHWID, swaptions);
                //std::cout << "calibrated to:\n"
                //          << "a = " << modelHW->params()[0] << ", "
                //          << "sigma = " << modelHW->params()[1]
                //          << std::endl << std::endl;

                // ATM Bermudan swaption pricing

                Console.WriteLine("Payer bermudan swaption struck at " +
                    fixedATMRate + " (ATM)");

                IntPtr accrualStartDatesPtr = QuantLibAddin.Export.qlTemp1(
                    swapID);
                int[] accrualStartDates = intPtrToIntArray(accrualStartDatesPtr);

                StringBuilder bermudanExerciseID =
                    new StringBuilder("bermudanExercise");
                QuantLibAddin.Export.qlBermudanExercise(
                    Trigger, bermudanExerciseID, Overwrite, Permanent,
                    5, accrualStartDates.ToArray());

                StringBuilder bermudanSwaptionID =
                    new StringBuilder("bermudanSwaption");
                QuantLibAddin.Export.qlSwaption(
                    Trigger, bermudanSwaptionID, Overwrite, Permanent,
                    atmSwapID, bermudanExerciseID);

                // Do the pricing for each model

                StringBuilder engineG2ID = new StringBuilder("engineG2");
                QuantLibAddin.Export.qlTreeSwaptionEngine(
                    Trigger, engineG2ID, Overwrite, Permanent, modelG2ID, 50);
                QuantLibAddin.Export.qlInstrumentSetPricingEngine(
                    Trigger, bermudanSwaptionID, engineG2ID);
                Console.WriteLine("G2 (tree): " +
                    QuantLibAddin.Export.qlInstrumentNPV(
                        Trigger, bermudanSwaptionID));

                StringBuilder engineHWID = new StringBuilder("engineHW");
                QuantLibAddin.Export.qlTreeSwaptionEngine(
                    Trigger, engineHWID, Overwrite, Permanent, modelHWID, 50);
                QuantLibAddin.Export.qlInstrumentSetPricingEngine(
                    Trigger, bermudanSwaptionID, engineHWID);
                Console.WriteLine("HW (tree): " +
                    QuantLibAddin.Export.qlInstrumentNPV(
                        Trigger, bermudanSwaptionID));
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }
    }
}
