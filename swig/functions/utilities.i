
%group(Utilities);

%insert(obj_cpp) %{
#include <qlo/objects/obj_utilities.hpp>
%}

namespace QuantLibAddin {

    //! returns the version number of QuantLib.
    std::string version();
}
