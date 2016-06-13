
%group(interpolation);
%groupCaption(Interpolation);
%override;

namespace QuantLibAddin {

    class Interpolation /*: public Extrapolator*/ {
    public:
        //! Returns interpolated values using the given Interpolation object.
        QuantLib::Real interpolate(
            QuantLib::Real x,                                               //!< x values.
            bool allowExtrapolation                                         //!< allow extrapolation flag.
        );
    };

    class GenericInterp : public Interpolation {
    public:
        GenericInterp(
            const std::string& type,                                        //!< interpolation type (e.g BackwardFlat, ForwardFlat, MonotonicCubicNaturalSpline, etc.)
            const std::vector<QuantLib::Real>& x,                           //!< x array.
            const std::vector<QuantLib::Handle<QuantLib::Quote> >& y        //!< y array.
        );
    };
}

