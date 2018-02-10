
%group(evolutiondescription);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class EvolutionDescription;
    class MarketModelMultiProduct;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_products.hpp>

#include <ql/models/marketmodels/multiproduct.hpp>
#include <ql/models/marketmodels/evolutiondescription.hpp>
%}

namespace QuantLib {

    class EvolutionDescription {
        public:
            EvolutionDescription(
                const std::vector<Time>& RateTimes,         //!< Rate fixing times.
                const std::vector<Time>& EvolutionTimes     //!< Evolution times in the simulation.
            );

            %rename(EvolutionDescriptionFromProduct) EvolutionDescription;
            %noimpl(EvolutionDescription);
            EvolutionDescription(
                const MarketModelMultiProduct& Product      //!< ID of product object.
            );

            //! Rates fixing times for the EvolutionDescription object.
            const std::vector<Time>& rateTimes() const;

            //! Rate taus for the EvolutionDescription object.
            const std::vector<Time>& rateTaus() const;

            //! Evolution times for the EvolutionDescription object.
            const std::vector<Time>& evolutionTimes() const;

            //! First alive rate at each evolution time for the EvolutionDescription object.
            const std::vector<Size>& firstAliveRate() const;

            //! Number of rates for the EvolutionDescription object.
            Size numberOfRates() const;

            //! Number of steps for the EvolutionDescription object.
            Size numberOfSteps() const;
    };

    //! Returns the terminal measure for the given EvolutionDescription object.
    std::vector<Size> terminalMeasure(
        const EvolutionDescription& EvolutionDescription    //!< ID of EvolutionDescription object.
    );

    //! Returns the discretely compounded money market measure for the given EvolutionDescription object.
    std::vector<Size> moneyMarketMeasure(
        const EvolutionDescription& EvolutionDescription    //!< ID of EvolutionDescription object.
    );

    //! Returns the discretely compounded money market measure for the given EvolutionDescription object.
    std::vector<Size> moneyMarketPlusMeasure(
        const EvolutionDescription& EvolutionDescription,   //!< ID of EvolutionDescription object.
        Size Offset=1                                       //!< Offset applied to the MoneyMarket measure.
    );

    //! Returns TRUE if the numeraire vector is Terminal measure for the given EvolutionDescription object.
    bool isInTerminalMeasure(
        const EvolutionDescription& EvolutionDescription,   //!< ID of EvolutionDescription object.
        const std::vector<Size>& Numeraires                 //!< Vector of numeraires.
    );

    //! Returns TRUE if the numeraire vector is money market measure for the given EvolutionDescription object.
    bool isInMoneyMarketMeasure(
        const EvolutionDescription& EvolutionDescription,   //!< ID of EvolutionDescription object.
        const std::vector<Size>& Numeraires                 //!< Vector of numeraires.
    );

    //! Returns TRUE if the numeraire vector is money market measure plus for the given EvolutionDescription object.
    bool isInMoneyMarketPlusMeasure(
        const EvolutionDescription& EvolutionDescription,   //!< ID of EvolutionDescription object.
        const std::vector<Size>& Numeraires,                //!< Vector of numeraires.
        Size Offset=1                                       //!< Offset applied to the MoneyMarket measure.
    );
}

