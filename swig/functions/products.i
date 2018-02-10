
%group(products);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class MarketModelMultiProduct;
    class Payoff;
}
%}

%insert(obj_cpp) %{
//#include <qlo/evolutiondescription.hpp>
//#include <qlo/valueobjects/vo_evolutiondescription.hpp>
#include <qlo/objects/obj_payoffs.hpp>

#include <ql/models/marketmodels/products/onestep/onestepforwards.hpp>
#include <ql/models/marketmodels/products/onestep/onestepoptionlets.hpp>
#include <ql/models/marketmodels/products/multistep/multistepratchet.hpp>
#include <ql/models/marketmodels/products/multiproductcomposite.hpp>
#include <ql/instruments/payoffs.hpp>

//#include <oh/repository.hpp>
%}

namespace QuantLib {

    class MarketModelMultiProduct {
        //public:
        //    std::string evolution() const;
    };

    class MarketModelComposite : public MarketModelMultiProduct {};

    class MultiProductComposite : public MarketModelComposite {
        public:
            %rename2(MultiProductComposite, MarketModelMultiProductComposite);
            MultiProductComposite();

            //! Add new product to MarketModelComposite object.
            %rename2(add, MarketModelMultiProductCompositeAdd);
            void add(
                //const Clone<MarketModelMultiProduct> &Product               //!< ID of product object.
                const MarketModelMultiProduct &Product                  //!< ID of product object.
            );

            //! Finalize the MarketModelComposite object.
            %rename2(finalize, MarketModelMultiProductCompositeFinalize);
            void finalize();

            //! Suggested Numeraires for the MarketModelMultiProduct object.
            %rename2(suggestedNumeraires, MarketModelMultiProductSuggestedNumeraires);
            std::vector<Size> suggestedNumeraires() const;

            //! Possible cash flow times for the MarketModelMultiProduct object.
            %rename2(possibleCashFlowTimes, MarketModelMultiProductPossibleCashFlowTimes);
            std::vector<Time> possibleCashFlowTimes() const;

            //! Number of products in the MarketModelMultiProduct object.
            %rename2(numberOfProducts, MarketModelMultiProductNumberOfProducts);
            Size numberOfProducts() const;

            //! Max number of cashflows per product per step for the MarketModelMultiProduct object.
            %rename2(maxNumberOfCashFlowsPerProductPerStep, MarketModelMultiProductMaxNumberOfCashFlowsPerProductPerStep);
            Size maxNumberOfCashFlowsPerProductPerStep() const;
    };

    class OneStepForwards : public MarketModelMultiProduct {
        public:
            %rename2(OneStepForwards, MarketModelOneStepForwards);
            OneStepForwards(
                const std::vector<Time>& RateTimes,                     //!< Rate fixing times.
                const std::vector<Real>& Accruals,                      //!< Accrual factors.
                const std::vector<Time>& paymentTimes,                  //!< Payment times of the product.
                const std::vector<Rate>& strikes                        //!< Forward strikes.
            );
    };

    class MultiStepRatchet : public MarketModelMultiProduct {
        public:
            %rename2(MultiStepRatchet, MarketModelMultiStepRatchet);
            MultiStepRatchet(
                const std::vector<Time>& RateTimes,                     //!< Rate fixing times.
                const std::vector<Real>& Accruals,                      //!< Accrual factors.
                const std::vector<Time>& PaymentTimes,                  //!< Payment times of the product.
                Real GearingOfFloor,                                    //!< Gearing of floor.
                Real GearingOfFixing,                                   //!< Gearing of fixing.
                Rate SpreadOfFloor,                                     //!< Spread of floor.
                Rate SpreadOfFixing,                                    //!< Spread of fixing.
                Real InitialFloor,                                      //!< Initial floor.
                bool Payer                                              //!< Payer if true.
            );
    };

    class OneStepOptionlets : public MarketModelMultiProduct {
        public:
            %rename2(OneStepOptionlets, MarketModelOneStepOptionlets);
            OneStepOptionlets(
                const std::vector<Time>& RateTimes,                     //!< Rate fixing times.
                const std::vector<Real>& Accruals,                      //!< Accrual factors.
                const std::vector<Time>& PaymentTimes,                  //!< Payment times of the product.
                const std::vector<boost::shared_ptr<Payoff> >&Payoffs   //!< Striked type payoff object IDs.
            );
    };
}

