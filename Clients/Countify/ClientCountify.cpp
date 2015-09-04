
#include <iostream>
#include <iomanip>
#include "AddinCfy/init.hpp"

#include <oh/ohdefines.hpp>
#if defined BOOST_MSVC
#include <oh/auto_link.hpp>
#include <ql/auto_link.hpp>
#endif

int main() {
    try {
        std::cout << "hi" << std::endl;
        initializeAddin();
//        std::cout << "ql version=" << QuantLibAddinCpp::qlVersion() << std::endl;
//        std::cout << QuantLibAddinCpp::qlClose(1, 2) << std::endl;
//        QuantLibAddinCpp::qlSimpleQuote("quote", 1);
//        std::cout << QuantLibAddinCpp::qlSimpleQuoteValue("quote") << std::endl;
//        std::cout << QuantLibAddinCpp::qlDateToString("40024") << std::endl;
//        std::cout << QuantLibAddinCpp::qlDateIsEndOfMonth(40025L) << std::endl;
//        QuantLibAddinCpp::qlSettingsSetEvaluationDate(41841L);
//
//        // **************EquityOption.cpp
//        // set up dates
//        std::string calendar = "TARGET";
//        long todaysDate = 35930;//(15, May, 1998);
//        long settlementDate = 35932;//(17, May, 1998);
//        QuantLibAddinCpp::qlSettingsSetEvaluationDate(todaysDate);
//
//        // our options
//        std::string type = "Put";
//        double underlying = 36;
//        double strike = 40;
//        double dividendYield = 0.00;
//        double riskFreeRate = 0.06;
//        double volatility = 0.20;
//        long maturity = 36297;//(17, May, 1999);
//        std::string dayCounter = "Actual/365 (Fixed)";
//
//        std::cout << "Option type = "  << type << std::endl;
//        std::cout << "Maturity = "        << maturity << std::endl;
//        std::cout << "Underlying price = "        << underlying << std::endl;
//        std::cout << "Strike = "                  << strike << std::endl;
//        std::cout << "Risk-free interest rate = " << riskFreeRate
//                  << std::endl;
//        std::cout << "Dividend yield = " << dividendYield
//                  << std::endl;
//        std::cout << "Volatility = " << volatility
//                  << std::endl;
//        std::cout << std::endl;
//        std::string method;
//        std::cout << std::endl;
//
//        // write column headings
//        int widths[] = { 35, 14, 14, 14 };
//        std::cout << std::setw(widths[0]) << std::left << "Method"
//                  << std::setw(widths[1]) << std::left << "European"
//                  << std::setw(widths[2]) << std::left << "Bermudan"
//                  << std::setw(widths[3]) << std::left << "American"
//                  << std::endl;
//
//        QuantLibAddinCpp::qlEuropeanExercise("europeanExercise", maturity);
//
//        QuantLibAddinCpp::qlSimpleQuote("underlying", underlying);
//
//        // bootstrap the yield/dividend/vol curves
//        QuantLibAddinCpp::qlFlatForward("flatTermStructure", settlementDate, riskFreeRate, dayCounter);
//        QuantLibAddinCpp::qlFlatForward("flatDividendTS", settlementDate, dividendYield, dayCounter);
//        QuantLibAddinCpp::qlBlackConstantVol("flatVolTS", settlementDate, calendar, volatility, dayCounter);
//        QuantLibAddinCpp::qlBlackScholesMertonProcess("bsmProcess", "underlying", "flatDividendTS", "flatTermStructure", "flatVolTS");
//
//        // options
//        QuantLibAddinCpp::qlPlainVanillaPayoff("payoff", "PUT", strike);
//        QuantLibAddinCpp::qlVanillaOption("europeanOption", "payoff", "europeanExercise");
//
//        // Analytic formulas:
//
//        // Black-Scholes for European
//        method = "Black-Scholes";
//        QuantLibAddinCpp::qlAnalyticEuropeanEngine("engine", "bsmProcess");
//        QuantLibAddinCpp::qlInstrumentSetPricingEngine("europeanOption", "engine");
//        std::cout << std::setw(widths[0]) << std::left << method
//                  << std::fixed
//                  << std::setw(widths[1]) << std::left << QuantLibAddinCpp::qlInstrumentNPV("europeanOption")
//                  << std::setw(widths[2]) << std::left << "N/A"
//                  << std::setw(widths[3]) << std::left << "N/A"
//                  << std::endl;

        std::cout << "bye" << std::endl;
    } catch (const std::exception &e) {
        std::cout << "error " << e.what() << std::endl;
    } catch (...) {
        std::cout << "error" << std::endl;
    }
    return 0;
}
