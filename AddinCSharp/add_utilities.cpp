
#include "qlo/objmanual_utilities.hpp"
#include <windows.h>

extern "C" __declspec(dllexport) char* __stdcall qlVersion()
{
    std::string ret = QuantLibAddin::version();
    ULONG ulSize = ret.length() + sizeof(char);
    char* pszReturn = NULL;

    pszReturn = (char*)::CoTaskMemAlloc(ulSize);
    // Copy the contents of szSampleString
    // to the memory pointed to by pszReturn.
    strcpy(pszReturn, ret.c_str());
    // Return pszReturn.
    return pszReturn;
}
