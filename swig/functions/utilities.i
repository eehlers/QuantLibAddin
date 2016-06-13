
%group(utilities);
%groupCaption(Utilities);
%override;

%insert(utilities_addin_cpp) %{
#include <qlo/objmanual_utilities.hpp>
%}

namespace QuantLibAddin {

    %generate(c++, version);
    %generate(c#, version);
    %generate(countify, version);
    //! returns the version number of QuantLib.
    std::string version();

    %generate(c++, ObjectCount);
    %generate(countify, ObjectCount);
    long ObjectCount();

    // temporary hack to extract the accrual start dates from the fixed leg of a swap
    %generate(c#, temp1);
    std::vector<QuantLib::Date> temp1(const std::string &s);
}
