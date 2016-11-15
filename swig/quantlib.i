
%module(
    rp_obj_dir="../qlo",
    rp_obj_inc="qlo",
    rp_add_dir="../AddinCpp",
    rp_add_inc="AddinCpp",
    rp_xll_dir="../../QuantLibXL/qlxl",
    rp_xll_inc="qlxl",
    rp_dox_dir="../Docs/pages_auto",
    rp_doc_str="../docstrings/docstrings.txt"
) QuantLibAddin

%import typedefs/all.i
%import typemaps/all.i
%include functions/all.i

