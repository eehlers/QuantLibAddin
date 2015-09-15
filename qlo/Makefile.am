
SUBDIRS = \
    conversions \
    enumerations \
    serialization \
    valueobjects

AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}

this_includedir=${includedir}/${subdir}
this_include_HEADERS = \
    handle.hpp \
    handleimpl.hpp \
    init.hpp \
    loop.hpp \
    obj_all.hpp \
    obj_calendars.hpp \
    obj_daycounters.hpp \
    obj_exercise.hpp \
    obj_instruments.hpp \
    objmanual_couponvectors.hpp \
    objmanual_date2.hpp \
    objmanual_date.hpp \
    objmanual_handles.hpp \
    objmanual_indexes.hpp \
    objmanual_indexes2.hpp \
    objmanual_interpolation.hpp \
    objmanual_leg.hpp \
    objmanual_piecewiseyieldcurve.hpp \
    objmanual_quote.hpp \
    objmanual_ratehelpers.hpp \
    objmanual_settings.hpp \
    objmanual_utilities.hpp \
    obj_payoffs.hpp \
    obj_prices.hpp \
    obj_pricingengines.hpp \
    obj_processes.hpp \
    obj_schedule.hpp \
    obj_termstructures.hpp \
    obj_vanillaswaps.hpp \
    obj_volatilities.hpp \
    qladdindefines.hpp \
    yieldtermstructures.hpp

libAddinObjects_la_SOURCES = \
    init.cpp \
    obj_calendars.cpp \
    obj_daycounters.cpp \
    obj_exercise.cpp \
    obj_instruments.cpp \
    objmanual_couponvectors.cpp \
    objmanual_date2.cpp \
    objmanual_date.cpp \
    objmanual_handles.cpp \
    objmanual_interpolation.cpp \
    objmanual_leg.cpp \
    objmanual_piecewiseyieldcurve.cpp \
    objmanual_quote.cpp \
    objmanual_ratehelpers.cpp \
    objmanual_settings.cpp \
    objmanual_utilities.cpp \
    obj_payoffs.cpp \
    obj_prices.cpp \
    obj_pricingengines.cpp \
    obj_processes.cpp \
    obj_schedule.cpp \
    obj_termstructures.cpp \
    obj_vanillaswaps.cpp \
    obj_volatilities.cpp \
    yieldtermstructures.cpp

noinst_LTLIBRARIES = libAddinObjects.la

libAddinObjects_la_LIBADD = \
    conversions/libConversions.la \
    enumerations/constructors/libEnumerationConstructors.la \
    enumerations/factories/libEnumerationFactories.la \
    enumerations/register/libEnumerationRegister.la \
    serialization/libSerialization.la \
    valueobjects/libValueObjects.la

