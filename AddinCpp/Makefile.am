
#SUBDIRS = conversions

AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}

this_includedir=${includedir}/${subdir}

if BUILD_CPP
this_include_HEADERS = \
    add_all.hpp \
    add_exercise.hpp \
    add_instruments.hpp \
    add_payoffs.hpp \
    add_pricingengines.hpp \
    add_processes.hpp \
    add_quote.hpp \
    add_settings.hpp \
    add_termstructures.hpp \
    add_utilities.hpp \
    add_volatilities.hpp \
    init.hpp
endif

if BUILD_CPP
libAddinCpp_la_SOURCES = \
    add_exercise.cpp \
    add_instruments.cpp \
    add_payoffs.cpp \
    add_pricingengines.cpp \
    add_processes.cpp \
    add_quote.cpp \
    add_settings.cpp \
    add_termstructures.cpp \
    add_utilities.cpp \
    add_volatilities.cpp \
    init.cpp
endif

if BUILD_CPP
noinst_LTLIBRARIES = libAddinCpp.la
else
EXTRA_LTLIBRARIES = libAddinCpp.la
endif

#libAddinCpp_la_LIBADD = \
#    ../qlo/libAddinObjects.la conversions/libConversions.la

libAddinCpp_la_LIBADD = \
    ../qlo/libAddinObjects.la

libAddinCpp_la_LDFLAGS = \
    -lQuantLib -lreposit -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex

