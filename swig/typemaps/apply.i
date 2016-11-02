//
//// These are types which require specific typemaps to be defined.  Tell the
//// reposit SWIG module to treat these types as strings, that causes some of the
//// necessary typemaps to be generated, the rest are defined in this project.
//%apply rp_tp_string { QuantLib::Schedule & };
//%apply rp_tp_string { QuantLib::OptimizationMethod & };
//%apply rp_tp_string { QuantLib::EndCriteria & };
//%apply rp_tp_string { QuantLib::Leg & };

//// Enumerated types.
//ENUMERATED_TYPE(QuantLib::DateGeneration::Rule)
//ENUMERATED_TYPE(QuantLib::Duration::Type)
ENUMERATED_TYPE(QuantLib::Futures::Type)
//ENUMERATED_TYPE(QuantLib::GFunctionFactory::YieldCurveModel)
ENUMERATED_TYPE(QuantLib::Pillar::Choice)
//ENUMERATED_TYPE(QuantLib::Position::Type)
//ENUMERATED_TYPE(QuantLib::Protection::Side)
//ENUMERATED_TYPE(QuantLib::Seniority)
//ENUMERATED_TYPE(QuantLib::VanillaSwap::Type)
ENUMERATED_TYPE(QuantLib::BusinessDayConvention)
ENUMERATED_TYPE(QuantLib::Compounding)
ENUMERATED_TYPE(QuantLib::Currency)
ENUMERATED_TYPE(QuantLib::Frequency)
ENUMERATED_TYPE(QuantLib::MixedInterpolation::Behavior)
ENUMERATED_TYPE(QuantLib::Month)
ENUMERATED_TYPE(QuantLib::Option::Type)
ENUMERATED_TYPE(QuantLib::SensitivityAnalysis)
ENUMERATED_TYPE(QuantLib::Weekday)

ENUMERATED_TYPE(QuantLibAddin::RateHelper::DepoInclusionCriteria)
ENUMERATED_TYPE(QuantLibAddin::SwapIndex::FixingType)

// Enumerated classes.
ENUMERATED_CLASS(QuantLib::Calendar)
ENUMERATED_CLASS(QuantLib::DayCounter)

%define QL_OBJECT_WRAPPER(T...)

namespace QuantLib {
    class T;
}

%typemap(rp_tm_xll_cnvt) std::vector<boost::shared_ptr<QuantLib::T> > & %{
        std::vector<std::string> $1_name_vec =
            reposit::operToVector<std::string>(*$1_name, "$1_name");
        std::vector<boost::shared_ptr<QuantLib::T> > $1_name_vec2 =
            reposit::getLibraryObjectVector<QuantLibAddin::T, QuantLib::T>($1_name_vec);
%}

OBJECT_WRAPPER(QuantLibAddin::T, QuantLib::T)
%enddef

//// Data types of objects passed as function parameters to be retrieved from the repository
//QL_OBJECT_WRAPPER(BaseModel)
//QL_OBJECT_WRAPPER(Basket)
QL_OBJECT_WRAPPER(Bond)
//QL_OBJECT_WRAPPER(CalibratedModel)
//QL_OBJECT_WRAPPER(CalibrationHelper)
//QL_OBJECT_WRAPPER(CmsCouponPricer)
//QL_OBJECT_WRAPPER(CorrelationTermStructure)
//QL_OBJECT_WRAPPER(CreditDefaultSwap)
//QL_OBJECT_WRAPPER(DefaultEventSet)
//QL_OBJECT_WRAPPER(DefaultLossModel)
//QL_OBJECT_WRAPPER(DefaultProbabilityHelper)
//QL_OBJECT_WRAPPER(DefaultProbabilityTermStructure)
QL_OBJECT_WRAPPER(DiscountCurve)
//QL_OBJECT_WRAPPER(Exercise)
QL_OBJECT_WRAPPER(FlatForward)
//QL_OBJECT_WRAPPER(FloatingRateCouponPricer)
QL_OBJECT_WRAPPER(ForwardCurve)
QL_OBJECT_WRAPPER(ForwardSpreadedTermStructure)
//QL_OBJECT_WRAPPER(G2)
//QL_OBJECT_WRAPPER(GeneralizedBlackScholesProcess)
QL_OBJECT_WRAPPER(ImpliedTermStructure)
QL_OBJECT_WRAPPER(Instrument)
//QL_OBJECT_WRAPPER(InterpolatedYieldCurve)
//QL_OBJECT_WRAPPER(Issuer)
//QL_OBJECT_WRAPPER(OneFactorAffineModel)
//QL_OBJECT_WRAPPER(PricingEngine)
QL_OBJECT_WRAPPER(RateHelper)
QL_OBJECT_WRAPPER(Schedule)
//QL_OBJECT_WRAPPER(ShortRateModel)
//QL_OBJECT_WRAPPER(StrikedTypePayoff)
//QL_OBJECT_WRAPPER(SwaptionHelper)
//QL_OBJECT_WRAPPER(VanillaSwap)
QL_OBJECT_WRAPPER(ZeroCurve)
QL_OBJECT_WRAPPER(Extrapolator)
QL_OBJECT_WRAPPER(IborIndex)
QL_OBJECT_WRAPPER(Index)
QL_OBJECT_WRAPPER(InterestRateIndex)
QL_OBJECT_WRAPPER(OvernightIndex)
QL_OBJECT_WRAPPER(SwapIndex)
QL_OBJECT_WRAPPER(TermStructure)
QL_OBJECT_WRAPPER(YieldTermStructure)
QL_OBJECT_WRAPPER(TimeSeriesDef)

// ctor in QLA namespace, member function in QL namespace

%define QLA_GET_OBJECT(T_ADDIN,T_LIB...)
%typemap(rp_tm_xxx_rp_get) T_LIB %{
        RP_GET_REFERENCE(xxx, objectID, T_ADDIN, T_LIB);
%}
%enddef

QLA_GET_OBJECT(QuantLibAddin::Quote, QuantLib::Quote)
QLA_GET_OBJECT(QuantLibAddin::SwapRateHelper, QuantLib::SwapRateHelper)
QLA_GET_OBJECT(QuantLibAddin::FxSwapRateHelper, QuantLib::FxSwapRateHelper)
QLA_GET_OBJECT(QuantLibAddin::FuturesRateHelper, QuantLib::FuturesRateHelper)

%define QUANTLIB_GET_QUOTE(T_ADDIN,T_LIB...)
%typemap(rp_tm_xxx_rp_get) T_LIB %{
        boost::shared_ptr<T_LIB> xxx =
            QuantLibAddin::getQuote<T_ADDIN, T_LIB>(objectID);
%}
%enddef

QUANTLIB_GET_QUOTE(QuantLibAddin::SimpleQuote, QuantLib::SimpleQuote)
QUANTLIB_GET_QUOTE(QuantLibAddin::FuturesConvAdjustmentQuote, QuantLib::FuturesConvAdjustmentQuote)
QUANTLIB_GET_QUOTE(QuantLibAddin::LastFixingQuote, QuantLib::LastFixingQuote)

%define QUANTLIB_GET_YTS(T_ADDIN,T_LIB...)
%typemap(rp_tm_xxx_rp_get) T_LIB %{
        boost::shared_ptr<T_LIB> xxx =
            QuantLibAddin::getYieldTermStructure<T_ADDIN, T_LIB>(objectID);
%}
%enddef

QUANTLIB_GET_YTS(QuantLibAddin::TermStructure, QuantLib::TermStructure)
QUANTLIB_GET_YTS(QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure)
QUANTLIB_GET_YTS(QuantLibAddin::DefaultProbabilityTermStructure, QuantLib::DefaultProbabilityTermStructure)

%define QUANTLIB_HANDLE(T_ADDIN,T_LIB...)

%typemap(rp_tm_xll_argf) QuantLib::Handle<T_LIB> & "$1_name_handle";
%typemap(rp_tm_xll_argf2) QuantLib::Handle<T_LIB> & "$1_name_handle";
%typemap(rp_tm_xll_argfv) QuantLib::Handle<T_LIB> & "$1_name_vo";
%typemap(rp_tm_xll_argfv2) QuantLib::Handle<T_LIB> & "$1_name_vo";
%typemap(rp_tm_xll_cnvt) QuantLib::Handle<T_LIB> & %{
        RP_GET_REFERENCE($1_name_get, $1_name, T_ADDIN, T_LIB)
        QuantLib::Handle<T_LIB> $1_name_handle =
            QuantLib::Handle<T_LIB>($1_name_get);
%}
%typemap(rp_tm_vob_parm) QuantLib::Handle<T_LIB> & "const std::string &";
%typemap(rp_tm_vob_mbvr) QuantLib::Handle<T_LIB> & "std::string $1_name_";
%typemap(rp_tm_vob_cnvt) QuantLib::Handle<T_LIB> & "reposit::convert<std::string>(value)";

%typemap(rp_tm_xll_code) QuantLib::Handle<T_LIB> & "C";
%typemap(rp_tm_xll_parm) QuantLib::Handle<T_LIB> & "char*";

%enddef

%define QUANTLIB_HANDLE_COERCEABLE(T_ADDIN,T_LIB...)
QUANTLIB_HANDLE(T_ADDIN,T_LIB)
%typemap(rp_tm_vob_parm) QuantLib::Handle<T_LIB> & "const reposit::property_t&";
%typemap(rp_tm_vob_mbvr) QuantLib::Handle<T_LIB> & "reposit::property_t $1_name_";
%typemap(rp_tm_vob_cnvt) QuantLib::Handle<T_LIB> & "value";

%typemap(rp_tm_xll_code) QuantLib::Handle<T_LIB> & "P";
%typemap(rp_tm_xll_parm) QuantLib::Handle<T_LIB> & "OPER*";

%enddef

%define QUANTLIB_QUOTE(T_ADDIN,T_LIB...)
%typemap(rp_tm_xxx_rp_get) QuantLib::SimpleQuote %{
        boost::shared_ptr<QuantLib::SimpleQuote> xxx =
            QuantLibAddin::Get<std::string, boost::shared_ptr<QuantLib::SimpleQuote> >()(objectID);
%}
%enddef

//// QuantLib Handles.
QUANTLIB_HANDLE(QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
//QUANTLIB_HANDLE(QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
QUANTLIB_HANDLE_COERCEABLE(QuantLibAddin::Quote, QuantLib::Quote)
QUANTLIB_HANDLE(QuantLibAddin::SimpleQuote, QuantLib::SimpleQuote)
QUANTLIB_HANDLE(QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure)
//QUANTLIB_HANDLE(QuantLibAddin::SwaptionVolatilityStructure, QuantLib::SwaptionVolatilityStructure)
//QUANTLIB_HANDLE(QuantLibAddin::DefaultProbabilityTermStructure, QuantLib::DefaultProbabilityTermStructure)

// Override some of the typemaps that were generated by the macro above.

%typemap(rp_tm_xll_argf) std::vector<QuantLib::Handle<QuantLib::Quote> > & "$1_name_vec2";

%typemap(rp_tm_xll_argfv) QuantLib::Handle<QuantLib::YieldTermStructure> & "$1_name";
%typemap(rp_tm_xll_argfv) QuantLib::Handle< QuantLib::Quote > & "$1_name_cnv";

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::Quote> & %{
        reposit::property_t $1_name_cnv = reposit::convert<reposit::property_t>(
            reposit::ConvertOper(*$1_name));
        QuantLib::Handle<QuantLib::Quote> $1_name_handle = 
            reposit::convert<QuantLib::Handle<QuantLib::Quote> >(
                reposit::ConvertOper(*$1_name), "$1_name");
%}

%typemap(rp_tm_xll_cnvt) std::vector<QuantLib::Handle<QuantLib::Quote> > & %{
        std::vector<reposit::property_t> $1_name_vec =
            reposit::operToVector<reposit::property_t>(*$1_name, "$1_name");
        std::vector<QuantLib::Handle<QuantLib::Quote> > $1_name_vec2 =
            reposit::operToVector<QuantLib::Handle<QuantLib::Quote> >(*$1_name, "$1_name");
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<QuantLib::YieldTermStructure> & %{
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle = QuantLibAddin::getYieldTermStructureHandle($1_name);
%}

%typemap(rp_tm_xll_cnvt2) QuantLib::Handle<QuantLib::YieldTermStructure> & %{
        std::string $1_name_vo = reposit::convert<std::string>(
            reposit::ConvertOper(*$1_name), "$1_name", "");
        QuantLib::Handle<QuantLib::YieldTermStructure> $1_name_handle = QuantLibAddin::getYieldTermStructureHandle($1_name_vo, $rp_value);
%}
