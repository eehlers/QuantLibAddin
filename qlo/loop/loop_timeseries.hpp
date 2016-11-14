
// BEGIN buffer b_lib_loop_hpp


#ifndef loop_timeseries_hpp
#define loop_timeseries_hpp

#include <boost/bind.hpp>

namespace QuantLibAddin {

    // qlTimeSeriesSubscriptWrapper

    typedef     boost::_bi::bind_t<
                QuantLib::Real,
                boost::_mfi::mf1<
                    QuantLib::Real,
                    QuantLibAddin::TimeSeriesDef,
                    QuantLib::Date const &>,
                boost::_bi::list2<
                    boost::_bi::value<boost::shared_ptr<QuantLibAddin::TimeSeriesDef> >,
                    boost::arg<1> > >
                    qlTimeSeriesSubscriptWrapperBind;

    typedef     QuantLib::Real
                (QuantLibAddin::TimeSeriesDef::* qlTimeSeriesSubscriptWrapperSignature)(
                    QuantLib::Date const &);

}

#endif


// END buffer b_lib_loop_hpp

