
%module(
    rp_obj_dir="../qlo",
    rp_add_dir="../AddinCpp",
    rp_csh_dir="../AddinCSharp",
    rp_cfy_dir="../AddinCfy",
    rp_xll_dir="../../QuantLibXL2/qlxl",
    rp_obj_inc="qlo",
    rp_add_inc="AddinCpp",
    rp_xll_inc="qlxl"
) QuantLibAddin

%include typemaps/all.i
%include typedefs/all.i
%include functions/all.i

