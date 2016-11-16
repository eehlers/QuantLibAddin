
%group(Processes);

%insert(obj_hpp) %{
#include <ql/types.hpp>
#include <ql/processes/blackscholesprocess.hpp>
#include <ql/termstructures/volatility/equityfx/blackconstantvol.hpp>
#include <ql/termstructures/volatility/equityfx/blackvariancesurface.hpp>

namespace QuantLib {
    class GeneralizedBlackScholesProcess;
    class BlackVolTermStructure;
    class DayCounter;
    class Date;
}
%}

namespace QuantLib {

    class GeneralizedBlackScholesProcess /*: public StochasticProcess1D*/ {
      public:

        GeneralizedBlackScholesProcess(
            const boost::shared_ptr<QuantLib::BlackVolTermStructure>& BlackVolID,   //!< Black Vol Term Structure.
            QuantLib::Real Underlying,                                              //!< Underlying.
            const QuantLib::DayCounter& DayCounter/*=Actual/365 (Fixed)*/,          //!< DayCounter ID.
            const QuantLib::Date& SettlementDate,                                   //!< Settlement date.
            QuantLib::Real RiskFreeRate,                                            //!< Risk free rate.
            QuantLib::Spread DividendYield                                          //!< Dividend yield.
        );
    };
}

