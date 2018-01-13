
// BEGIN buffer b_lib_grp_cpp


#include <qlo/objects/obj_sequencestatistics.hpp>
#include <ql/math/statistics/sequencestatistics.hpp>

QuantLibAddin::SequenceStatistics::SequenceStatistics(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Size Dimension,
            QuantLib::Matrix &Values,
            std::vector< QuantLib::Real > &Weights,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::SequenceStatistics>(properties, permanent) {

    libraryObject_ = boost::shared_ptr<QuantLib::SequenceStatistics>(new QuantLib::SequenceStatistics(
                // BEGIN typemap rp_tm_default
                Dimension
                // END   typemap rp_tm_default
    ));

    QL_REQUIRE(Weights.empty() || Values.rows() == Weights.size(),
        "Mismatch between number of samples (" <<
        Values.rows() << ") and number of weights (" <<
        Weights.size() << ")");

    if (Values.rows()>0) {
        if (!Weights.empty()) {
            for (QuantLib::Size i = 0; i<Values.rows(); ++i)
                libraryObject_->add(Values.row_begin(i),
                    Values.row_end(i),
                    Weights[i]);
        }
        else {
            for (QuantLib::Size i = 0; i<Values.rows(); ++i)
                libraryObject_->add(Values.row_begin(i),
                    Values.row_end(i));
        }
    }
}

QuantLibAddin::SequenceStatisticsInc::SequenceStatisticsInc(
    const boost::shared_ptr<reposit::ValueObject>& properties,
            // BEGIN typemap rp_tm_default
            QuantLib::Size Dimension,
            QuantLib::Matrix &Values,
            std::vector< QuantLib::Real > &Weights,
            // END   typemap rp_tm_default
    bool permanent)
: reposit::LibraryObject<QuantLib::SequenceStatisticsInc>(properties, permanent) {

    libraryObject_ = boost::shared_ptr<QuantLib::SequenceStatisticsInc>(new QuantLib::SequenceStatisticsInc(
        // BEGIN typemap rp_tm_default
        Dimension
        // END   typemap rp_tm_default
    ));

    QL_REQUIRE(Weights.empty() || Values.rows() == Weights.size(),
        "Mismatch between number of samples (" <<
        Values.rows() << ") and number of weights (" <<
        Weights.size() << ")");

    if (Values.rows()>0) {
        if (!Weights.empty()) {
            for (QuantLib::Size i = 0; i<Values.rows(); ++i)
                libraryObject_->add(Values.row_begin(i),
                    Values.row_end(i),
                    Weights[i]);
        }
        else {
            for (QuantLib::Size i = 0; i<Values.rows(); ++i)
                libraryObject_->add(Values.row_begin(i),
                    Values.row_end(i));
        }
    }
}
