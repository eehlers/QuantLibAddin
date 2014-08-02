
SUBDIRS = \
    conversions \
    enumerations \
    valueobjects

AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}

this_includedir=${includedir}/${subdir}
this_include_HEADERS = \
    init.hpp \
    obj_date.hpp \
    obj_exercise.hpp \
    obj_instruments.hpp \
    obj_payoffs.hpp \
    obj_processes.hpp \
    obj_pricingengines.hpp \
    obj_quote.hpp \
    obj_settings.hpp \
    obj_utilities.hpp \
    obj_volatilities.hpp \
    obj_yieldtermstructures.hpp

libAddinObjects_la_SOURCES = \
    init.cpp \
    obj_date.cpp \
    obj_exercise.cpp \
    obj_instruments.cpp \
    obj_payoffs.cpp \
    obj_processes.cpp \
    obj_pricingengines.cpp \
    obj_quote.cpp \
    obj_settings.cpp \
    obj_utilities.cpp \
    obj_volatilities.cpp \
    obj_yieldtermstructures.cpp

noinst_LTLIBRARIES = libAddinObjects.la

libAddinObjects_la_LIBADD = \
    conversions/libConversions.la \
    enumerations/constructors/libEnumerationConstructors.la \
    enumerations/factories/libEnumerationFactories.la \
    enumerations/register/libEnumerationRegister.la \
    valueobjects/libValueObjects.la

