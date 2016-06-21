
@REM SET SWIG_ROOT_DIR=C:\Users\erik\Documents\repos\reposit\swig
@REM SET SWIG_EXE=%SWIG_ROOT_DIR%\build\vc90\Win32\Release\swig.exe
@REM SET SWIG_LIB_DIR=%SWIG_ROOT_DIR%\Lib
@REM SET REPOSIT_INC_DIR=%SWIG_LIB_DIR%\reposit

SET SWIG_EXE=..\..\swig\build\vc90\Win32\Release\swig.exe
SET SWIG_LIB_DIR=..\..\swig\Lib
SET REPOSIT_INC_DIR=..\..\swig\Lib\reposit

@REM %SWIG_EXE% -help
%SWIG_EXE% -I%SWIG_LIB_DIR% -I%REPOSIT_INC_DIR% -DSWIG_MSVC -legacy -c++ -reposit -genxll -prefix ql quantlib.i
@REM %SWIG_EXE% -debug-top 4 -debug-tmsearch -I%SWIG_LIB_DIR% -I%REPOSIT_INC_DIR% -DSWIG_MSVC -legacy -c++ -reposit -genxll -prefix ql quantlib.i > debug.txt

