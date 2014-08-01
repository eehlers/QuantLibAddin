
// rp_xll_* - Excel addin

%typemap(rp_xll) QuantLib::Date const & "P";
%typemap(rp_xll) QuantLib::Calendar const & "P";
%typemap(rp_xll) QuantLib::DayCounter const & "P";
%typemap(rp_xll) QuantLib::Volatility "E";
%typemap(rp_xll) QuantLib::Rate "E";
%typemap(rp_xll) QuantLib::Real "E";
%typemap(rp_xll) QuantLib::Handle<QuantLib::Quote> const & "X";
%typemap(rp_xll) QuantLib::Handle<QuantLib::YieldTermStructure> const & "X";
%typemap(rp_xll) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "X";
%typemap(rp_xll) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "X";
%typemap(rp_xll) boost::shared_ptr< QuantLib::Exercise > const & "X";
%typemap(rp_xll) QuantLib::Option::Type "X";
%typemap(rp_xll) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "X";
%typemap(rp_xll) const boost::shared_ptr<QuantLib::PricingEngine>& "X";

%typemap(rp_xll_in) QuantLib::Date const & "OPER*";
%typemap(rp_xll_in) QuantLib::Calendar const & "OPER*";
%typemap(rp_xll_in) QuantLib::DayCounter const & "OPER*";
%typemap(rp_xll_in) QuantLib::Volatility "double*";
%typemap(rp_xll_in) QuantLib::Rate "double*";
%typemap(rp_xll_in) QuantLib::Real "double*";
%typemap(rp_xll_in) QuantLib::Handle<QuantLib::Quote> const & "xxx";
%typemap(rp_xll_in) QuantLib::Handle<QuantLib::YieldTermStructure> const & "xxx";
%typemap(rp_xll_in) QuantLib::Handle<QuantLib::BlackVolTermStructure> const & "xxx";
%typemap(rp_xll_in) boost::shared_ptr< QuantLib::StrikedTypePayoff > const & "xxx";
%typemap(rp_xll_in) boost::shared_ptr< QuantLib::Exercise > const & "xxx";
%typemap(rp_xll_in) QuantLib::Option::Type "xxx";
%typemap(rp_xll_in) boost::shared_ptr<QuantLib::GeneralizedBlackScholesProcess> const & "xxx";
%typemap(rp_xll_in) const boost::shared_ptr<QuantLib::PricingEngine>& "xxx";

%typemap(rp_xll_cnv) QuantLib::Date const & %{
        QuantLib::Date $1_name_cnv = ObjectHandler::convert2<QuantLib::Date>(
            ObjectHandler::ConvertOper(*$1_name), "$1_name", QuantLib::Date());
%} 

%typemap(rp_xll_call) QuantLib::Date const & "$1_name_cnv";

%typemap(rp_xll_out) QuantLib::Real "double*";

