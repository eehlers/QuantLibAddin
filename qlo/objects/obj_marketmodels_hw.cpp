
// BEGIN buffer b_lib_grp_cpp


#include <qlo/objects/obj_marketmodels.hpp>


#include <ql/models/marketmodels/models/fwdperiodadapter.hpp>
#include <ql/models/marketmodels/models/fwdtocotswapadapter.hpp>
#include <ql/models/marketmodels/models/pseudorootfacade.hpp>
#include <ql/models/marketmodels/models/cotswaptofwdadapter.hpp>
#include <ql/models/marketmodels/models/flatvol.hpp>
#include <ql/legacy/libormarketmodels/lmextlinexpvolmodel.hpp>
#include <ql/models/marketmodels/models/abcdvol.hpp>
#include <ql/models/marketmodels/marketmodeldifferences.hpp>
#include <ql/models/marketmodels/swapforwardmappings.hpp>

QuantLib::Matrix
QuantLibAddin::coterminalSwapForwardJacobian(
    // BEGIN typemap rp_tm_default
    QuantLib::CurveState const &CurveState
    // END   typemap rp_tm_default
) {
    return QuantLib::SwapForwardMappings::coterminalSwapForwardJacobian(CurveState);
}

//****FUNC*****
QuantLib::Matrix
QuantLibAddin::coterminalSwapZedMatrix(
    // BEGIN typemap rp_tm_default
    QuantLib::CurveState const &CurveState,
    QuantLib::Spread const Displacement
    // END   typemap rp_tm_default
) {
    return QuantLib::SwapForwardMappings::coterminalSwapZedMatrix(CurveState, Displacement);
}

//****FUNC*****
QuantLib::Matrix
QuantLibAddin::coinitialSwapForwardJacobian(
    // BEGIN typemap rp_tm_default
    QuantLib::CurveState const &CurveState
    // END   typemap rp_tm_default
) {
    return QuantLib::SwapForwardMappings::coinitialSwapForwardJacobian(CurveState);
}

//****FUNC*****
QuantLib::Matrix
QuantLibAddin::coinitialSwapZedMatrix(
    // BEGIN typemap rp_tm_default
    QuantLib::CurveState const &CurveState,
    QuantLib::Spread const Displacement
    // END   typemap rp_tm_default
) {
    return QuantLib::SwapForwardMappings::coinitialSwapZedMatrix(CurveState, Displacement);
}

//****FUNC*****
QuantLib::Matrix
QuantLibAddin::cmSwapForwardJacobian(
    // BEGIN typemap rp_tm_default
    QuantLib::CurveState const &CurveState,
    QuantLib::Size const SpanningForwards
    // END   typemap rp_tm_default
) {
    return QuantLib::SwapForwardMappings::cmSwapForwardJacobian(CurveState, SpanningForwards);
}

//****FUNC*****
QuantLib::Matrix
QuantLibAddin::cmSwapZedMatrix(
    // BEGIN typemap rp_tm_default
    QuantLib::CurveState const &CurveState,
    QuantLib::Size const SpanningForwards,
    QuantLib::Spread const Displacement
    // END   typemap rp_tm_default
) {
    return QuantLib::SwapForwardMappings::cmSwapZedMatrix(CurveState, SpanningForwards, Displacement);
}

//****FUNC*****
QuantLib::Real
QuantLibAddin::annuity(
    // BEGIN typemap rp_tm_default
    QuantLib::CurveState const &CurveState,
    QuantLib::Size StartIndex,
    QuantLib::Size EndIndex,
    QuantLib::Size NumeraireIndex
    // END   typemap rp_tm_default
) {
    return QuantLib::SwapForwardMappings::annuity(CurveState, StartIndex, EndIndex, NumeraireIndex);
}

//****FUNC*****
QuantLib::Real
QuantLibAddin::swapDerivative(
    // BEGIN typemap rp_tm_default
    QuantLib::CurveState const &CurveState,
    QuantLib::Size StartIndex,
    QuantLib::Size EndIndex,
    QuantLib::Size FwdRateIndex
    // END   typemap rp_tm_default
) {
    return QuantLib::SwapForwardMappings::swapDerivative(CurveState, StartIndex, EndIndex, FwdRateIndex);
}

// END buffer b_lib_grp_cpp

