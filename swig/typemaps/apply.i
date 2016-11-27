
// Enumerated types.

%define QL_ENUMERATED_TYPE(T...)
ENUMERATED_TYPE(QuantLib, T)
%enddef

%define QL_ENUMERATED_TYPE_STRUCT(S,T...)
ENUMERATED_TYPE_STRUCT(QuantLib, S, T)
%enddef

QL_ENUMERATED_TYPE(BusinessDayConvention)
QL_ENUMERATED_TYPE(Compounding)
QL_ENUMERATED_TYPE(Currency)
QL_ENUMERATED_TYPE(Frequency)
QL_ENUMERATED_TYPE(Month)
QL_ENUMERATED_TYPE(Seniority)
QL_ENUMERATED_TYPE(SensitivityAnalysis)
QL_ENUMERATED_TYPE(Weekday)
QL_ENUMERATED_TYPE(VolatilityType)

QL_ENUMERATED_TYPE_STRUCT(DateGeneration, Rule)
QL_ENUMERATED_TYPE_STRUCT(Duration, Type)
QL_ENUMERATED_TYPE_STRUCT(Futures, Type)
QL_ENUMERATED_TYPE_STRUCT(GFunctionFactory, YieldCurveModel)
QL_ENUMERATED_TYPE_STRUCT(MixedInterpolation, Behavior)
QL_ENUMERATED_TYPE_STRUCT(Option, Type)
QL_ENUMERATED_TYPE_STRUCT(Pillar, Choice)
QL_ENUMERATED_TYPE_STRUCT(Position, Type)
QL_ENUMERATED_TYPE_STRUCT(Protection, Side)
QL_ENUMERATED_TYPE_STRUCT(SalvagingAlgorithm, Type)
QL_ENUMERATED_TYPE_STRUCT(Replication, Type)

// We can't use the directive below, because it would declare VanillaSwap, but we have also
// declared VanillaSwap elsewhere as a full-fledged class, which would result in an illegal redefinition:
//QL_ENUMERATED_TYPE_STRUCT(VanillaSwap, Type)
// Instead we bypass QL_ENUMERATED_TYPE_STRUCT() and call directly into reposit's ENUMERATED_TYPE_IMPL(),
// this avoids the redefinition:
ENUMERATED_TYPE_IMPL(QuantLib::VanillaSwap::Type)

ENUMERATED_TYPE_IMPL(QuantLib::EndCriteria::Type)
ENUMERATED_TYPE_IMPL(QuantLibAddin::RateHelper::DepoInclusionCriteria)
ENUMERATED_TYPE_IMPL(QuantLibAddin::SwapIndex::FixingType)

// Enumerated classes.

ENUMERATED_CLASS(QuantLib, Calendar)
ENUMERATED_CLASS(QuantLib, DayCounter)

// Objects.

%define QL_OBJECT_WRAPPER(T...)

namespace QuantLib {
    class T;
}
// FIXME - Move this into reposit swig module.
%typemap(rp_tm_xll_cnvt) QuantLib::T & %{
        boost::shared_ptr<QuantLib::T> $1_name_temp =
            QuantLibAddin::GetObject<QuantLibAddin::T, QuantLib::T>::f($1_name);
        const QuantLib::T &$1_name_obj = *($1_name_temp.get());
%}

OBJECT_WRAPPER(QuantLibAddin::T, QuantLib::T)
%enddef

// Data types of objects passed as function parameters to be retrieved from the repository

//QL_OBJECT_WRAPPER(BaseModel)
//QL_OBJECT_WRAPPER(Basket)
//QL_OBJECT_WRAPPER(CalibratedModel)
//QL_OBJECT_WRAPPER(CalibrationHelper)
//QL_OBJECT_WRAPPER(CmsCouponPricer)
//QL_OBJECT_WRAPPER(CorrelationTermStructure)
//QL_OBJECT_WRAPPER(CreditDefaultSwap)
//QL_OBJECT_WRAPPER(DefaultEventSet)
//QL_OBJECT_WRAPPER(DefaultLossModel)
//QL_OBJECT_WRAPPER(DefaultProbabilityHelper)
//QL_OBJECT_WRAPPER(DefaultProbabilityTermStructure)
//QL_OBJECT_WRAPPER(FloatingRateCouponPricer)
//QL_OBJECT_WRAPPER(GeneralizedBlackScholesProcess)
//QL_OBJECT_WRAPPER(InterpolatedYieldCurve)
//QL_OBJECT_WRAPPER(Issuer)
//QL_OBJECT_WRAPPER(OneFactorAffineModel)
//QL_OBJECT_WRAPPER(PricingEngine)
//QL_OBJECT_WRAPPER(ShortRateModel)
//QL_OBJECT_WRAPPER(SwaptionHelper)
//QL_OBJECT_WRAPPER(VanillaSwap)

QL_OBJECT_WRAPPER(AffineModel)
QL_OBJECT_WRAPPER(BlackCalculator)
QL_OBJECT_WRAPPER(BlackScholesCalculator)
QL_OBJECT_WRAPPER(BlackVolTermStructure)
QL_OBJECT_WRAPPER(Bond)
QL_OBJECT_WRAPPER(CapFloorTermVolatilityStructure)
QL_OBJECT_WRAPPER(CapFloorTermVolCurve)
QL_OBJECT_WRAPPER(CapFloorTermVolSurface)
QL_OBJECT_WRAPPER(CovarianceDecomposition)
QL_OBJECT_WRAPPER(DiscountCurve)
QL_OBJECT_WRAPPER(EndCriteria)
QL_OBJECT_WRAPPER(Exercise)
QL_OBJECT_WRAPPER(Extrapolator)
QL_OBJECT_WRAPPER(FlatForward)
QL_OBJECT_WRAPPER(ForwardCurve)
QL_OBJECT_WRAPPER(ForwardSpreadedTermStructure)
QL_OBJECT_WRAPPER(G2)
QL_OBJECT_WRAPPER(GeneralizedBlackScholesProcess)
QL_OBJECT_WRAPPER(HullWhite)
QL_OBJECT_WRAPPER(IborIndex)
QL_OBJECT_WRAPPER(ImpliedTermStructure)
QL_OBJECT_WRAPPER(Index)
QL_OBJECT_WRAPPER(Instrument)
QL_OBJECT_WRAPPER(InterestRateIndex)
QL_OBJECT_WRAPPER(LineSearch)
QL_OBJECT_WRAPPER(OneFactorAffineModel)
QL_OBJECT_WRAPPER(OptimizationMethod)
QL_OBJECT_WRAPPER(OptionletStripper)
QL_OBJECT_WRAPPER(OptionletStripper1)
QL_OBJECT_WRAPPER(OptionletVolatilityStructure)
QL_OBJECT_WRAPPER(OvernightIndex)
QL_OBJECT_WRAPPER(Payoff)
QL_OBJECT_WRAPPER(PlainVanillaPayoff)
QL_OBJECT_WRAPPER(RateHelper)
QL_OBJECT_WRAPPER(Schedule)
QL_OBJECT_WRAPPER(SmileSection)
QL_OBJECT_WRAPPER(StrikedTypePayoff)
QL_OBJECT_WRAPPER(StrippedOptionletBase)
QL_OBJECT_WRAPPER(SwapIndex)
QL_OBJECT_WRAPPER(SwaptionVolatilityCube)
QL_OBJECT_WRAPPER(SwaptionVolatilityStructure)
QL_OBJECT_WRAPPER(SwaptionVolatilityStructure)
QL_OBJECT_WRAPPER(SymmetricSchurDecomposition)
QL_OBJECT_WRAPPER(TermStructure)
QL_OBJECT_WRAPPER(TimeSeriesDef)
QL_OBJECT_WRAPPER(TypePayoff)
QL_OBJECT_WRAPPER(Vasicek)
QL_OBJECT_WRAPPER(YieldTermStructure)
QL_OBJECT_WRAPPER(ZeroCurve)

QL_OBJECT_WRAPPER(Leg)
QL_OBJECT_WRAPPER(MultiPhaseLeg)
QL_OBJECT_WRAPPER(InterestRate)
QL_OBJECT_WRAPPER(DigitalReplication)
QL_OBJECT_WRAPPER(FixedRateLeg)
QL_OBJECT_WRAPPER(IborLeg)
QL_OBJECT_WRAPPER(DigitalIborLeg)
QL_OBJECT_WRAPPER(CmsLeg)
QL_OBJECT_WRAPPER(DigitalCmsLeg)
QL_OBJECT_WRAPPER(RangeAccrualLeg)
QL_OBJECT_WRAPPER(CmsZeroLeg)
QL_OBJECT_WRAPPER(IborCouponPricer)
QL_OBJECT_WRAPPER(CmsCouponPricer)
QL_OBJECT_WRAPPER(NumericHaganPricer)
QL_OBJECT_WRAPPER(VanillaSwap)
QL_OBJECT_WRAPPER(Swap)

// This functionality is copied directly from the old build - see function qlLegNPV().
// It looks a little odd?  Treating a DiscountCurve like a YieldTermStructure?
%typemap(rp_tm_xll_cnvt) QuantLib::DiscountCurve & %{
        boost::shared_ptr<QuantLib::YieldTermStructure> $1_name_temp =
            QuantLibAddin::GetObject<QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure>::f($1_name);
        const QuantLib::YieldTermStructure &$1_name_obj = *($1_name_temp.get());
%}

// ctor in QLA namespace, member function in QL namespace

%define QLA_GET_OBJECT(T...)
%typemap(rp_tm_xxx_rp_get) QuantLib::T %{
        RP_GET_REFERENCE(xxx, objectID, QuantLibAddin::T, QuantLib::T);
%}
%enddef

QLA_GET_OBJECT(Quote)
QLA_GET_OBJECT(SwapRateHelper)
QLA_GET_OBJECT(FxSwapRateHelper)
QLA_GET_OBJECT(FuturesRateHelper)
QLA_GET_OBJECT(BlackVolTermStructure)
QLA_GET_OBJECT(BlackConstantVol)
QLA_GET_OBJECT(BlackVarianceSurface)
QLA_GET_OBJECT(BlackAtmVolCurve)
QLA_GET_OBJECT(AbcdAtmVolCurve)
QLA_GET_OBJECT(SabrVolSurface)
QLA_GET_OBJECT(VolatilityTermStructure)
QLA_GET_OBJECT(SabrVolSurface)

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

// NB: If you add a new item to the list below, then you also need to edit file qlo/conversions/get.cpp
// and add an explicit instantiation of template getYieldTermStructure.
QUANTLIB_GET_YTS(QuantLibAddin::TermStructure, QuantLib::TermStructure)
QUANTLIB_GET_YTS(QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure)
QUANTLIB_GET_YTS(QuantLibAddin::DefaultProbabilityTermStructure, QuantLib::DefaultProbabilityTermStructure)
QUANTLIB_GET_YTS(QuantLibAddin::SwaptionVolatilityStructure, QuantLib::SwaptionVolatilityStructure)
QUANTLIB_GET_YTS(QuantLibAddin::OptionletVolatilityStructure, QuantLib::OptionletVolatilityStructure)
QUANTLIB_GET_YTS(QuantLibAddin::CapFloorTermVolatilityStructure, QuantLib::CapFloorTermVolatilityStructure)

%define QUANTLIB_HANDLE(T_ADDIN,T_LIB...)

%typemap(rp_tm_vob_parm) QuantLib::Handle<T_LIB> & "const std::string &";
%typemap(rp_tm_vob_mbvr) QuantLib::Handle<T_LIB> & "std::string $1_name_";
%typemap(rp_tm_vob_cnvt) QuantLib::Handle<T_LIB> & "reposit::convert<std::string>(value)";

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<T_LIB> & %{
    std::string $1_name_str =
        reposit::convert<std::string>(valueObject->getProperty("$1_name"));
    valueObject->processPrecedentID($1_name_str);
    QuantLib::Handle<T_LIB> $1_name = QuantLibAddin::getHandle<T_ADDIN, T_LIB>($1_name_str);
%}

%typemap(rp_tm_xll_cnvt) QuantLib::Handle<T_LIB> & %{
        QuantLib::Handle<T_LIB> $1_name_handle =
            QuantLibAddin::getHandle<T_ADDIN, T_LIB>($1_name);
%}

%typemap(rp_tm_xll_cnvt2) QuantLib::Handle<T_LIB> & %{
        std::string $1_name_str = reposit::convert<std::string>(
            reposit::ConvertOper(*$1_name), "$1_name", "");
        QuantLib::Handle<T_LIB> $1_name_handle =
            QuantLibAddin::getHandle<T_ADDIN, T_LIB>($1_name_str, $rp_value);
%}

%typemap(rp_tm_xll_argv) QuantLib::Handle<T_LIB> & "$1_name";
%typemap(rp_tm_xll_argv2) QuantLib::Handle<T_LIB> & "$1_name_str";
%typemap(rp_tm_xll_argf) QuantLib::Handle<T_LIB> & "$1_name_handle";
%typemap(rp_tm_xll_argf2) QuantLib::Handle<T_LIB> & "$1_name_handle";
%typemap(rp_tm_xll_code) QuantLib::Handle<T_LIB> & "C";
%typemap(rp_tm_xll_parm) QuantLib::Handle<T_LIB> & "char*";
%typemap(rp_tm_xll_rtft) QuantLib::Handle<T_LIB> & "char*";
%typemap(rp_tm_xll_rtdc) QuantLib::Handle<T_LIB> & "std::string returnValue =";
%typemap(rp_tm_xll_cdrt) QuantLib::Handle<T_LIB> & "C";

%typemap(rp_tm_xll_rtst) QuantLib::Handle<T_LIB> & %{
        static char ret[XL_MAX_STR_LEN];
        reposit::stringToChar(returnValue, ret);
        return ret;
%}

%enddef

// QuantLib Handles.
// NB: If you add a new item to the list below, then you also need to edit file qlo/conversions/get.cpp
// and add an explicit instantiation of template getHandle.
QUANTLIB_HANDLE(QuantLibAddin::FlatForward, QuantLib::YieldTermStructure)
QUANTLIB_HANDLE(QuantLibAddin::BlackConstantVol, QuantLib::BlackVolTermStructure)
QUANTLIB_HANDLE(QuantLibAddin::SimpleQuote, QuantLib::SimpleQuote)
QUANTLIB_HANDLE(QuantLibAddin::YieldTermStructure, QuantLib::YieldTermStructure)
QUANTLIB_HANDLE(QuantLibAddin::BlackAtmVolCurve, QuantLib::BlackAtmVolCurve)
QUANTLIB_HANDLE(QuantLibAddin::SwaptionVolatilityStructure, QuantLib::SwaptionVolatilityStructure)
//QUANTLIB_HANDLE(QuantLibAddin::DefaultProbabilityTermStructure, QuantLib::DefaultProbabilityTermStructure)
QUANTLIB_HANDLE(QuantLibAddin::SabrVolSurface, QuantLib::SabrVolSurface)
QUANTLIB_HANDLE(QuantLibAddin::OptionletVolatilityStructure, QuantLib::OptionletVolatilityStructure)
QUANTLIB_HANDLE(QuantLibAddin::CapFloorTermVolCurve, QuantLib::CapFloorTermVolCurve)

// Handle<Quote> - Call the macro to set the default typemaps, then override most of them.

QUANTLIB_HANDLE(QuantLibAddin::Quote, QuantLib::Quote)

%typemap(rp_tm_vob_parm) QuantLib::Handle<QuantLib::Quote> & "const reposit::property_t&";
%typemap(rp_tm_vob_mbvr) QuantLib::Handle<QuantLib::Quote> & "reposit::property_t $1_name_";
%typemap(rp_tm_vob_cnvt) QuantLib::Handle<QuantLib::Quote> & "value";
%typemap(rp_tm_vob_parm) std::vector<QuantLib::Handle<QuantLib::Quote > > & "const std::vector<reposit::property_t>&";
%typemap(rp_tm_vob_parm) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote > > > & "const std::vector<std::vector<reposit::property_t> >&";
%typemap(rp_tm_vob_mbvr) std::vector<QuantLib::Handle<QuantLib::Quote > > & "std::vector<reposit::property_t> $1_name_";
%typemap(rp_tm_vob_mbvr) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote > > > & "std::vector<std::vector<reposit::property_t> > $1_name_";
%typemap(rp_tm_vob_cnvt) std::vector<QuantLib::Handle<QuantLib::Quote> > & "reposit::vector::convert<reposit::property_t>(value, nameUpper)";
%typemap(rp_tm_vob_cnvt) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > & "reposit::matrix::convert<reposit::property_t>(value, nameUpper)";

%typemap(rp_tm_scr_cnvt) QuantLib::Handle<QuantLib::Quote> & %{
    reposit::property_t $1_name_prop =
        valueObject->getProperty("$1_name");
    valueObject->processPrecedentID($1_name_prop);
    QuantLib::Handle<QuantLib::Quote> $1_name =
        reposit::convert<QuantLib::Handle<QuantLib::Quote> >(
            $1_name_prop, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<QuantLib::Handle<QuantLib::Quote> > & %{
    std::vector<reposit::property_t> $1_name_vec =
        reposit::vector::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    valueObject->processPrecedentID($1_name_vec);
    std::vector<QuantLib::Handle<QuantLib::Quote> > $1_name =
        reposit::vector::convert<QuantLib::Handle<QuantLib::Quote> >($1_name_vec, "$1_name");
%}

%typemap(rp_tm_scr_cnvt) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > & %{
    std::vector<std::vector<reposit::property_t> > $1_name_vec =
        reposit::matrix::convert<reposit::property_t>(valueObject->getProperty("$1_name"), "$1_name");
    valueObject->processPrecedentID($1_name_vec);
    std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > $1_name =
        reposit::matrix::convert<QuantLib::Handle<QuantLib::Quote> >($1_name_vec, "$1_name");
%}

%typemap(rp_tm_xll_code) QuantLib::Handle<QuantLib::Quote> & "P";
%typemap(rp_tm_xll_parm) QuantLib::Handle<QuantLib::Quote> & "OPER*";
%typemap(rp_tm_xll_argf) std::vector<QuantLib::Handle<QuantLib::Quote> > & "$1_name_vec2";
%typemap(rp_tm_xll_argf) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > >& "$1_name_vec2";
%typemap(rp_tm_xll_argv) QuantLib::Handle< QuantLib::Quote > & "$1_name_cnv";

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

%typemap(rp_tm_xll_cnvt) std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > & %{
        std::vector<std::vector<reposit::property_t> > $1_name_vec =
            reposit::operToMatrix<reposit::property_t>(*$1_name, "$1_name");
        std::vector<std::vector<QuantLib::Handle<QuantLib::Quote> > > $1_name_vec2 =
            reposit::operToMatrix<QuantLib::Handle<QuantLib::Quote> >(*$1_name, "$1_name");
%}
