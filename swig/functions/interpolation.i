
%feature("rp:group", "interpolation");

%feature("rp:override_obj");

namespace QuantLibAddin {

    class Interpolation : public Extrapolator {
    public:
        QuantLib::Real interpolate(QuantLib::Real x,
                                  bool allowExtrapolation);
    };
    
    class GenericInterp : public Interpolation {
    public:
        GenericInterp(
            const std::string& type,
            const std::vector<QuantLib::Real>& x,
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& y);
    };    
}

%feature("rp:override_obj", "");
%feature("rp:group", "");

