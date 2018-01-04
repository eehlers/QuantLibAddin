
%group(accountingengines);

//%insert(obj_hpp) %{
//#include <ql/types.hpp>
//
//namespace QuantLib {
//    class AbcdFunction;
//    class AbcdCalibration;
//    class Quote;
//    class EndCriteria;
//    class OptimizationMethod;
//}
//%}

%insert(obj_cpp) %{
#include <qlo/accountingengines.hpp>
#include <qlo/marketmodelevolvers.hpp>
#include <qlo/products.hpp>
#include <qlo/sequencestatistics.hpp>
#include <ql/models/marketmodels/accountingengine.hpp>
%}

namespace QuantLib {

    class AccountingEngine {
        public:
            AccountingEngine(
                const boost::shared_ptr<MarketModelEvolver>& MarketModelEvolver,    //!< MarketModelEvolver object ID.
                const Clone<MarketModelMultiProduct>& Product,                      //!< MarketModelMultiProduct object ID.
                Real InitialNumeraireValue                                          //!< Initial numeraire value.
            );

            //! Return multiple path values.
            void multiplePathValues(
                SequenceStatisticsInc& SequenceStats,                               //!< Sequence Statistics object ID.
                Size Paths                                                          //!< Number of paths.
            );

    };
}

