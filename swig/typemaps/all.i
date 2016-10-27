
%apply rp_tp_string { QuantLib::Period };
%apply rp_tp_string { QuantLib::Period & };

%include ql_typemaps.i

// This one must be last.
%include apply.i
