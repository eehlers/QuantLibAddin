
%group(interpolation);
%override

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

