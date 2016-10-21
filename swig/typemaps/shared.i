
//*****************************************************************************
// rp_tm_xxx_* - typemaps shared by multiple addins
//*****************************************************************************

// rp_tm_xxx_rp_get:  Retrieve the object from the repository, extract reference.
%typemap(rp_tm_xxx_rp_get) QuantLib::TermStructure %{
        RP_GET_OBJECT(yyy, objectID, reposit::Object)
        boost::shared_ptr<QuantLib::TermStructure> xxx =
            QuantLibAddin::CoerceTermStructure<
                QuantLibAddin::TermStructure,
                QuantLib::TermStructure>()(
                    yyy);
%}
%typemap(rp_tm_xxx_rp_get) QuantLib::YieldTermStructure %{
        RP_GET_OBJECT(yyy, objectID, reposit::Object)
        boost::shared_ptr<QuantLib::YieldTermStructure> xxx =
            QuantLibAddin::CoerceTermStructure<
                QuantLibAddin::YieldTermStructure,
                QuantLib::YieldTermStructure>()(
                    yyy);
%}
%typemap(rp_tm_xxx_rp_get) QuantLib::DefaultProbabilityTermStructure %{
        RP_GET_OBJECT(yyy, objectID, reposit::Object)
        boost::shared_ptr<QuantLib::DefaultProbabilityTermStructure> xxx =
            QuantLibAddin::CoerceTermStructure<
                QuantLibAddin::DefaultProbabilityTermStructure,
                QuantLib::DefaultProbabilityTermStructure>()(
                    yyy);
%}

%typemap(rp_tm_xxx_loop) QuantLib::Date "$1_name_cnv";
%typemap(rp_tm_xxx_loop) QuantLib::Date const & "$1_name_cnv";
