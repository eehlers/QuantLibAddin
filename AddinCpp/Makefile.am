
AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}

this_includedir=${includedir}/${subdir}
this_include_HEADERS = \
    convert2.hpp \
    init.hpp \
    cpp_date.hpp \
    cpp_quote.hpp \
    cpp_settings.hpp \
    cpp_utilities.hpp

libAddinCpp_la_SOURCES = \
    convert2.cpp \
    init.cpp \
    cpp_date.cpp \
    cpp_quote.cpp \
    cpp_settings.cpp \
    cpp_utilities.cpp

noinst_LTLIBRARIES = libAddinCpp.la

libAddinCpp_la_LIBADD = \
    ../qlo/libAddinObjects.la
#    ../qlo/valueobjects/libValueObjects.la ../qlo/libAddinObjects.la

libAddinCpp_la_LDFLAGS = \
    -lQuantLib -lObjectHandler -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex

