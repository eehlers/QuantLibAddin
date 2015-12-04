
# Process this file with autoconf to produce a configure script.

AC_INIT([QuantLibAddin], [1.7.0],
        [quantlib-dev@lists.sourceforge.net],
        [QuantLibAddin])
AC_PREREQ(2.50)
AC_CONFIG_SRCDIR([./swig/quantlib.i])
AC_CONFIG_AUX_DIR([config])
AC_CONFIG_HEADERS([config.hpp])
AM_INIT_AUTOMAKE([foreign])

AC_COPYRIGHT([
Copyright (C) 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,
    2013, 2014 Eric Ehlers
Copyright (C) 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012,
    2013, 2014 Ferdinando Ametrano

Copyright (C) 2004, 2006 StatPro Italia srl
Copyright (C) 2005, 2006 Aurelien Chanudet
Copyright (C) 2005, 2006 Plamen Neykov
Copyright (C) 2005 Walter Penschke
Copyright (C) 2006, 2007 Chiara Fornarola
Copyright (C) 2006, 2007 Cristina Duminuco
Copyright (C) 2006, 2007 Francois du Vignaud
Copyright (C) 2006, 2007 Giorgio Facchinetti
Copyright (C) 2006, 2007 Katiuscia Manzoni
Copyright (C) 2006, 2007 Marco Bianchetti
Copyright (C) 2006 Mario Pucci
Copyright (C) 2006 Silvia Frasson
Copyright (C) 2007 Luigi Ballabio

This file is part of QuantLib, a free-software/open-source library
for financial quantitative analysts and developers - http://quantlib.org/

QuantLib is free software: you can redistribute it and/or modify it under the
terms of the QuantLib license.  You should have received a copy of the
license along with this program; if not, please email
<quantlib-dev@lists.sf.net>. The license is also available online at
<http://quantlib.org/license.shtml>.

This program is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
FOR A PARTICULAR PURPOSE.  See the license for more details.])

AC_PROG_INSTALL

# Default compilation variables

AC_SUBST([CXXFLAGS],[${CXXFLAGS='-g -O2 -Wall'}])

# Continue setup

AC_PROG_CC
AC_PROG_CXX
AC_PROG_CPP
AC_PROG_LIBTOOL
AC_LANG([C++])
AC_CONFIG_MACRO_DIR([m4])

# Help the compiler find external software

AC_ARG_WITH([boost-include],
            AC_HELP_STRING([--with-boost-include=INCLUDE_PATH],
                           [Supply the location of Boost header files]),
            [ql_boost_include_path="`cd ${withval} 2>/dev/null && pwd`"],
            [ql_boost_include_path=""])
if test [ -n "$ql_boost_include_path" ] ; then
   AC_SUBST([BOOST_INCLUDE],["-I${ql_boost_include_path}"])
   AC_SUBST([CPPFLAGS],["${CPPFLAGS} -I${ql_boost_include_path}"])
fi
AC_ARG_WITH([boost-lib],
            AC_HELP_STRING([--with-boost-lib=LIB_PATH],
                           [Supply the location of Boost libraries]),
            [ql_boost_lib_path="`cd ${withval} 2>/dev/null && pwd`"],
            [ql_boost_lib_path=""])
if test [ -n "$ql_boost_lib_path" ] ; then
   AC_SUBST([BOOST_LIB],["-L${ql_boost_lib_path}"])
   AC_SUBST([LDFLAGS],["${LDFLAGS} -L${ql_boost_lib_path}"])
fi

# Configure and validate the path to SWIG

# Use this if SWIG was installed via "make install" to a directory on our $PATH.

#AC_PATH_PROG([SWIG], [swig])

# This allows us to run SWIG from its source code tree instead of from its installed path.
# It means that after recompiling SWIG we can just do "make" instead of "make install".

AC_ARG_WITH([swig],
            AC_HELP_STRING([--with-swig=/path/to/SWIG],
                           [Specify the root directory of the SWIG source tree]),
            [swig_path=${withval}],
            [AC_MSG_ERROR([You must specify the location of SWIG: "./configure --with-swig=path/to/SWIG"])])
AC_CHECK_FILE([${swig_path}/preinst-swig], [],
            [AC_MSG_ERROR([Unable to locate file preinst-swig in specified SWIG directory])])
AC_ARG_VAR(swig_dir, path to SWIG)
AC_SUBST(swig_dir, [${swig_path}])

# The path to the =countify SDK.  Required if --enable-addin-cfy is specified.

AC_ARG_WITH([countify],
            AC_HELP_STRING([--with-countify=/path/to/countify],
                           [Specify the root directory of the =countify SDK]),
            [countify_path=${withval}])
if test [ -n "$countify_path" ] ; then
AC_CHECK_FILE([${countify_path}/FlyLib/FlyLib.h], [],
            [AC_MSG_ERROR([Unable to locate file FlyLib/FlyLib.h in specified countify directory])])
AC_ARG_VAR(countify_dir, path to countify)
AC_SUBST(countify_dir, [${countify_path}])
fi

# Possibly enable features

AC_ARG_ENABLE([addin-cpp],
              AC_HELP_STRING([--enable-addin-cpp],
                             [build C++ addin and clients [[default=no]]]),
                             [qla_build_cpp=$enableval],
                             [qla_build_cpp=omitted])
#AC_ARG_ENABLE([addin-calc],
#              AC_HELP_STRING([--enable-addin-calc],
#                             [build Calc addin [[default=no]]]),
#                             [qla_build_calc=$enableval],
#                             [qla_build_calc=omitted])
AC_ARG_ENABLE([addin-cfy],
              AC_HELP_STRING([--enable-addin-cfy],
                             [build =countify addin and clients [[default=no]]]),
                             [qla_build_cfy=$enableval],
                             [qla_build_cfy=omitted])
AC_ARG_ENABLE([addin-all],
              AC_HELP_STRING([--enable-addin-all],
                             [build all addins and clients [[default=no]]]),
                             [qla_build_all=$enableval])
AM_CONDITIONAL(BUILD_CPP, [test "$qla_build_cpp" = "omitted" \
    && test "$qla_build_all" = "yes" || test "$qla_build_cpp" = "yes"])
#AM_CONDITIONAL(BUILD_CALC, [test "$qla_build_calc" = "omitted" \
#    && test "$qla_build_all" = "yes" || test "$qla_build_calc" = "yes"])
AM_CONDITIONAL(BUILD_CFY, [test "$qla_build_cfy" = "omitted" \
    && test "$qla_build_all" = "yes" || test "$qla_build_cfy" = "yes"])
# If =countify output is requested then ensure that the path to the SDK was specified.
if test "$qla_build_cfy" = "omitted" && test "$qla_build_all" = "yes" || test "$qla_build_cfy" = "yes"; then
if test [ -z "$countify_path" ] ; then
AC_MSG_ERROR([Use --with-countify=/path/to/countify to specify the path to the =countify SDK])
fi
fi

# Done, output the configured files

AC_CONFIG_FILES([
    Makefile
    m4/Makefile
    swig/Makefile
    qlo/Makefile
    qlo/coercions/Makefile
    qlo/conversions/Makefile
    qlo/enumerations/Makefile
    qlo/enumerations/constructors/Makefile
    qlo/enumerations/factories/Makefile
    qlo/enumerations/register/Makefile
    qlo/indexes/Makefile
    qlo/indexes/ibor/Makefile
    qlo/indexes/swap/Makefile
    qlo/serialization/create/Makefile
    qlo/serialization/Makefile
    qlo/serialization/register/Makefile
    qlo/valueobjects/Makefile
    AddinCfy/Makefile
    AddinCpp/Makefile
    AddinCSharp/Makefile
    Clients/Makefile
    Clients/Cpp/Makefile
    Clients/Countify/Makefile
])

AC_OUTPUT

