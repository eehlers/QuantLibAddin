
%group(utilities);
%groupCaption(Utilities);
%override;

%insert(utilities_addin_cpp) %{
#include <qlo/objects/objmanual_utilities.hpp>
%}

namespace QuantLibAddin {

    //! returns the version number of QuantLib.
    std::string version();
}
