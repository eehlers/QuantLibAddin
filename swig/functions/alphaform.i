
%group(alphaform);

%insert(obj_hpp) %{
#include <ql/types.hpp>

namespace QuantLib {
    class AlphaForm;
}
%}

%insert(obj_cpp) %{
#include <ql/models/marketmodels/models/alphaform.hpp>
#include <ql/models/marketmodels/models/alphaformconcrete.hpp>
%}

namespace QuantLib {

    class AlphaForm {
        public:
			%rename(Operator) operator();
            //! Returns the Alpha Form value at time i.
            Real operator()(
                Integer Time                        //!< Integer corresponding to i-th time.
            );
            //! Set the Alpha parameter value to Alpha Form.
            void setAlpha(
                Real alpha                          //!< Alpha parameter value for Alpha Form.
            );
    };

    class AlphaFormInverseLinear : public AlphaForm {
        public:
            AlphaFormInverseLinear(
                const std::vector<Time>& RateTimes, //!< Rate fixing times.
                Real Alpha                          //!< Alpha coefficient.
            );
    };

    class AlphaFormLinearHyperbolic : public AlphaForm {
        public:
            AlphaFormLinearHyperbolic(
                const std::vector<Time>& RateTimes, //!< Rate fixing times.
                Real Alpha                          //!< Alpha coefficient.
            );
    };
}

