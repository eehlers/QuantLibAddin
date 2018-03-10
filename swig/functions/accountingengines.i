
%group(accountingengines);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class AccountingEngine;
    class MarketModelEvolver;
    class MarketModelMultiProduct;
}
%}

%insert(obj_cpp) %{
#include <qlo/objects/obj_marketmodelevolvers.hpp>
#include <qlo/objects/obj_products.hpp>
#include <qlo/objects/obj_sequencestatistics.hpp>

#include <ql/models/marketmodels/accountingengine.hpp>
%}

namespace QuantLib {

    class AccountingEngine {
        public:
            AccountingEngine(
                const boost::shared_ptr<MarketModelEvolver>& MarketModelEvolver,    //!< MarketModelEvolver object ID.
                //const Clone<MarketModelMultiProduct>& Product,                      //!< MarketModelMultiProduct object ID.
                const MarketModelMultiProduct& Product,                             //!< MarketModelMultiProduct object ID.
                Real InitialNumeraireValue                                          //!< Initial numeraire value.
            );

            //! Return multiple path values.
            void multiplePathValues(
                SequenceStatisticsInc& SequenceStats,                         //!< Sequence Statistics object ID.
                Size Paths                                                          //!< Number of paths.
            );

    };
}

