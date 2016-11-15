
%apply rp_tp_string { QuantLib::Period };
%apply rp_tp_string { QuantLib::Period & };

%import ql_typemaps.i

// This one must be last.
%import apply.i
