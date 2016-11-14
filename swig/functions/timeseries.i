
%group(TimeSeries);

%insert(obj_hpp) %{
#include <ql/types.hpp>
#include <map>

namespace QuantLib {
    class Date;
    class Index;

    template<class T, class Container>
    class TimeSeries;

    typedef TimeSeries<QuantLib::Real, std::map<QuantLib::Date, QuantLib::Real> > TimeSeriesDef;
}
%}

namespace QuantLib {

    %rename(TimeSeries) TimeSeriesDef;
    class TimeSeriesDef {
        public:

            %rename(TimeSeries) TimeSeriesDef;
            TimeSeriesDef(
                const std::vector<QuantLib::Date> &Dates,           //!< dates.
                const std::vector<QuantLib::Real> &Values           //!< values.
            );

            //%rename(TimeSeriesFromIndex) TimeSeriesDef;
            //TimeSeriesDef(
            //    const boost::shared_ptr<QuantLib::Index>& Index     //!< Index object ID.
            //);

            //! Returns the first date for which a historical datum exists.
            Date firstDate();

            //! Returns the last date for which a historical datum exists.
            Date lastDate();

            //! Returns the size of the time series.
            Size size();

            //! Returns whether the series contains any data.
            bool empty();

            //! Returns the dates for which historical data exist.
            std::vector<Date> dates();

            //! Returns the historical data.
            std::vector<Real> values();
%insert(rp_class) %{
        QuantLib::Real subscriptWrapper(const QuantLib::Date& d);
%}
    };
}

namespace QuantLibAddin {

    %rename(TimeSeries) TimeSeriesDef;
    %noexport(TimeSeriesDef);
    %noctor(TimeSeriesDef);
    class TimeSeriesDef {
        public:

            //! Returns returns the data corresponding to the given dates.
            %rename(value) subscriptWrapper;
            %loop(subscriptWrapper, Dates);
            QuantLib::Real subscriptWrapper(
                const QuantLib::Date &Dates                         //!< fixing date(s).
            );
    };
}
