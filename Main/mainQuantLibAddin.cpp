
#include <iostream>
#include "AddinCpp/init.hpp"
#include "AddinCpp/cpp_date.hpp"
#include "AddinCpp/cpp_quote.hpp"
#include "AddinCpp/cpp_utilities.hpp"
#include "AddinCpp/cpp_settings.hpp"

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
        std::cout << "bye" << std::endl;
    } catch (const std::exception &e) {
        std::cout << "error " << e.what() << std::endl;
    } catch (...) {
        std::cout << "error" << std::endl;
    }
    return 0;
}

