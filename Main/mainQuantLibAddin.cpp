
#include <iostream>
#include "AddinCpp/init.hpp"
#include "AddinCpp/cpp_date.hpp"
#include "AddinCpp/cpp_quote.hpp"
#include "AddinCpp/cpp_utilities.hpp"
#include "AddinCpp/cpp_settings.hpp"
#include "AddinCpp/cpp_volatilities.hpp"

int main() {
    try {
        std::cout << "hi" << std::endl;
        QuantLibAddinCpp::initializeAddin();
        std::cout << "ql version=" << QuantLibAddinCpp::qlVersion() << std::endl;
        std::cout << QuantLibAddinCpp::qlClose(1, 2) << std::endl;
        QuantLibAddinCpp::qlSimpleQuote("quote", 1);
        std::cout << QuantLibAddinCpp::qlSimpleQuoteValue("quote") << std::endl;
        std::cout << QuantLibAddinCpp::qlDateToString("40024") << std::endl;
        std::cout << QuantLibAddinCpp::qlDateIsEndOfMonth(40025L) << std::endl;
        QuantLibAddinCpp::qlSettingsSetEvaluationDate(41841L);

        QuantLibAddinCpp::qlBlackConstantVol("vol", 35932L, "Target", 0.2, "Actual/365 (Fixed)");

        std::cout << "bye" << std::endl;
    } catch (const std::exception &e) {
        std::cout << "error " << e.what() << std::endl;
    } catch (...) {
        std::cout << "error" << std::endl;
    }
    return 0;
}

