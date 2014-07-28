
SUBDIRS = \
    enumerations \
    valueobjects

AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}

this_includedir=${includedir}/${subdir}
this_include_HEADERS = \
    init.hpp \
    obj_date.hpp \
    obj_quote.hpp \
    obj_settings.hpp \
    obj_utilities.hpp \
    obj_volatilities.hpp

libAddinObjects_la_SOURCES = \
    init.cpp \
    obj_date.cpp \
    obj_quote.cpp \
    obj_settings.cpp \
    obj_utilities.cpp \
    obj_volatilities.cpp

noinst_LTLIBRARIES = libAddinObjects.la

libAddinObjects_la_LIBADD = \
    enumerations/factories/libEnumerationFactories.la \
    enumerations/register/libEnumerationRegister.la \
    valueobjects/libValueObjects.la

