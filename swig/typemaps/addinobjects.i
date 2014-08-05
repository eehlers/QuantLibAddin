
// rp_obj_* - addin objects
// These typemaps generate source code for cpp and hpp files in the qlo directory -
// QuantLibAddin classes that wrap QuantLib classes.

// Typemap rp_tm_obj_cls - this typemap generates macros which declare QuantLibAddin classes.
// The default behavior is no typemap, in which case the full definition of the class is generated.
// If a typemap is defined then the macro code is generated instead of the full definition.

%typemap(rp_tm_obj_cls) QuantLib::Instrument * %{
    OH_LIB_CLASS(Instrument, QuantLib::Instrument);
%}

