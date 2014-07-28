
SUBDIRS = \
    conversions

AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}

this_includedir=${includedir}/${subdir}
this_include_HEADERS = \
    cpp_date.hpp \
    cpp_exercise.hpp \
    cpp_includes.hpp \
    cpp_instruments.hpp \
    cpp_payoffs.hpp \
    cpp_processes.hpp \
    cpp_pricingengines.hpp \
    cpp_quote.hpp \
    cpp_settings.hpp \
    cpp_utilities.hpp \
    cpp_volatilities.hpp \
    cpp_yieldtermstructures.hpp \
    init.hpp

libAddinCpp_la_SOURCES = \
    cpp_date.cpp \
    cpp_exercise.cpp \
    cpp_instruments.cpp \
    cpp_payoffs.cpp \
    cpp_processes.cpp \
    cpp_pricingengines.cpp \
    cpp_quote.cpp \
    cpp_settings.cpp \
    cpp_utilities.cpp \
    cpp_volatilities.cpp \
    cpp_yieldtermstructures.cpp \
    init.cpp

noinst_LTLIBRARIES = libAddinCpp.la

libAddinCpp_la_LIBADD = \
    ../qlo/libAddinObjects.la conversions/libConversions.la

libAddinCpp_la_LDFLAGS = \
    -lQuantLib -lObjectHandler -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex

