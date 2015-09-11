
// This file is for QuantLib index classes where no constructor
// is exported, only member functions.  The relevant wrapper class
// is defined by index.i, and here we just autogenerate calls to
// the relevant member functions of the underlying QuantLib object.

%pragma(reposit) group="indexes2";
%pragma(reposit) override_obj="true";

namespace QuantLib {

    class Index {};
    
    class InterestRateIndex : public Index {
        public:
            QuantLib::Natural fixingDays();
            const QuantLib::DayCounter& dayCounter();
            QuantLib::Date valueDate(const QuantLib::Date& fixingDate);
            QuantLib::Period tenor();
    };
    
    class IborIndex : public InterestRateIndex {
        public:
            QuantLib::BusinessDayConvention businessDayConvention();
    };    
}
