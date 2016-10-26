
%group(timeseries);
%groupCaption(TimeSeries);
%override;

%insert(timeseries_addin_cpp) %{
#include <qlo/objects/objmanual_timeseries.hpp>
//#include <qlo/objects/objmanual_indexes.hpp>
%}

namespace QuantLib {

    %rename(TimeSeries) TimeSeriesDef;
    class TimeSeriesDef {
        public:

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
    };
}

namespace QuantLibAddin {

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

            //! Returns returns the data corresponding to the given dates.
            %rename(value) subscriptWrapper;
            %loop(subscriptWrapper, Dates);
            QuantLib::Real subscriptWrapper(
                const QuantLib::Date &Dates                         //!< fixing date(s).
            );
    };
}
