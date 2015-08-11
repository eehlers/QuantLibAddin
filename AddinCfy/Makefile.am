
#SUBDIRS = \
#    conversions

AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir} -I/home/countify/sdk/Eric-SDK -I/home/countify/sdk/Eric-SDK/ACE_wrappers -I/home/countify/sdk/Eric-SDK/ACE_wrappers/debian

this_includedir=${includedir}/${subdir}
this_include_HEADERS = \
    cfy_date.hpp \
    cfy_exercise.hpp \
    cfy_instruments.hpp \
    cfy_payoffs.hpp \
    cfy_processes.hpp \
    cfy_pricingengines.hpp \
    cfy_quote.hpp \
    cfy_settings.hpp \
    cfy_utilities.hpp \
    cfy_volatilities.hpp \
    cfy_yieldtermstructures.hpp \
    init.hpp

libCountifyQuantLibAddin_la_SOURCES = \
    cfy_date.cpp \
    cfy_exercise.cpp \
    cfy_instruments.cpp \
    cfy_payoffs.cpp \
    cfy_processes.cpp \
    cfy_pricingengines.cpp \
    cfy_quote.cpp \
    cfy_settings.cpp \
    cfy_utilities.cpp \
    cfy_volatilities.cpp \
    cfy_yieldtermstructures.cpp \
    init.cpp

#noinst_LTLIBRARIES = libCountifyQuantLibAddin.la
lib_LTLIBRARIES = libCountifyQuantLibAddin.la

#libCountifyQuantLibAddin_la_LIBADD = \
#    ../qlo/libAddinObjects.la conversions/libConversions.la

libCountifyQuantLibAddin_la_LIBADD = \
    ../qlo/libAddinObjects.la

libCountifyQuantLibAddin_la_LDFLAGS = \
    -lQuantLib -lObjectHandler -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex -L/home/countify/countify/lib -lFlyLib

