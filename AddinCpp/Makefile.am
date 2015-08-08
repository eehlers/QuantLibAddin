
#SUBDIRS = \
#    conversions

AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}

this_includedir=${includedir}/${subdir}
this_include_HEADERS = \
    add_date.hpp \
    add_exercise.hpp \
    add_instruments.hpp \
    add_payoffs.hpp \
    add_processes.hpp \
    add_pricingengines.hpp \
    add_quote.hpp \
    add_settings.hpp \
    add_utilities.hpp \
    add_volatilities.hpp \
    add_yieldtermstructures.hpp \
    init.hpp

libAddinCpp_la_SOURCES = \
    add_date.cpp \
    add_exercise.cpp \
    add_instruments.cpp \
    add_payoffs.cpp \
    add_processes.cpp \
    add_pricingengines.cpp \
    add_quote.cpp \
    add_settings.cpp \
    add_utilities.cpp \
    add_volatilities.cpp \
    add_yieldtermstructures.cpp \
    init.cpp

noinst_LTLIBRARIES = libAddinCpp.la

#libAddinCpp_la_LIBADD = \
#    ../qlo/libAddinObjects.la conversions/libConversions.la

libAddinCpp_la_LIBADD = \
    ../qlo/libAddinObjects.la

libAddinCpp_la_LDFLAGS = \
    -lQuantLib -lObjectHandler -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex

