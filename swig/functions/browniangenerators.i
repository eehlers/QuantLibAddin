
%group(browniangenerators);

%insert(obj_hpp) %{
namespace QuantLib {
    class MTBrownianGeneratorFactory;
}
%}

%insert(obj_cpp) %{
#include <ql/models/marketmodels/browniangenerators/mtbrowniangenerator.hpp>
%}

namespace QuantLib {

    //class BrownianGeneratorFactory{};

    class MTBrownianGeneratorFactory /*: public BrownianGeneratorFactory*/ {
        public:
            MTBrownianGeneratorFactory(
                /*unsigned*/ long seed = 0  //!< Seed for random sequence generator.
            );
    };
}

