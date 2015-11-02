
SUBDIRS = \
    coercions \
    conversions \
    enumerations \
    indexes \
    serialization \
    valueobjects

AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}

this_includedir=${includedir}/${subdir}
this_include_HEADERS = \
    auto_link.hpp \
    handle.hpp \
    handleimpl.hpp \
    index.hpp \
    init.hpp \
    loop.hpp \
    obj_all.hpp \
    obj_calendars.hpp \
    obj_daycounters.hpp \
    obj_exercise.hpp \
    obj_instruments.hpp \
    obj_math.hpp \
    obj_models.hpp \
    obj_payoffs.hpp \
    obj_pricingengines.hpp \
    obj_processes.hpp \
    obj_schedule.hpp \
    obj_termstructures.hpp \
    obj_vanillaswaps.hpp \
    obj_volatilities.hpp \
    objmanual_couponvectors.hpp \
    objmanual_date.hpp \
    objmanual_handles.hpp \
    objmanual_indexes.hpp \
    objmanual_interpolation.hpp \
    objmanual_leg.hpp \
    objmanual_piecewiseyieldcurve.hpp \
    objmanual_quote.hpp \
    objmanual_ratehelpers.hpp \
    objmanual_settings.hpp \
    objmanual_utilities.hpp \
    qladdindefines.hpp \
    yieldtermstructures.hpp

libAddinObjects_la_SOURCES = \
    index.cpp \
    init.cpp \
    objmanual_couponvectors.cpp \
    objmanual_date.cpp \
    objmanual_interpolation.cpp \
    objmanual_leg.cpp \
    objmanual_piecewiseyieldcurve.cpp \
    objmanual_quote.cpp \
    objmanual_ratehelpers.cpp \
    objmanual_settings.cpp \
    objmanual_utilities.cpp \
    yieldtermstructures.cpp

noinst_LTLIBRARIES = libAddinObjects.la

libAddinObjects_la_LIBADD = \
    conversions/libConversions.la \
    enumerations/constructors/libEnumerationConstructors.la \
    enumerations/factories/libEnumerationFactories.la \
    enumerations/register/libEnumerationRegister.la \
    indexes/libIndexes.la \
    serialization/libSerialization.la \
    valueobjects/libValueObjects.la

