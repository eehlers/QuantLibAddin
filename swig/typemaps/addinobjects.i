
// rp_obj_* - addin objects

%typemap(rp_obj_class) QuantLib::Instrument * %{
    OH_LIB_CLASS(Instrument, QuantLib::Instrument);
%}

