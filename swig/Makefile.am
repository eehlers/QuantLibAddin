
SWIG_FILES := \
    quantlib.i \
    functions/all.i \
    functions/calendars.i \
    functions/couponvectors.i \
    functions/date.i \
    functions/date2.i \
    functions/daycounters.i \
    functions/exercise.i \
    functions/handles.i \
    functions/indexes.i \
    functions/indexes2.i \
    functions/instruments.i \
    functions/interpolation.i \
    functions/leg.i \
    functions/payoffs.i \
    functions/piecewiseyieldcurve.i \
    functions/prices.i \
    functions/pricingengines.i \
    functions/processes.i \
    functions/quote.i \
    functions/ratehelpers.i \
    functions/schedule.i \
    functions/settings.i \
    functions/termstructures.i \
    functions/utilities.i \
    functions/volatilities.i \
    typemaps/addinobjects.i \
    typemaps/all.i \
    typemaps/apply.i \
    typemaps/cfyaddin.i \
    typemaps/cppaddin.i \
    typemaps/exceladdin.i \
    typemaps/serialization.i \
    typemaps/typemaps.ods \
    typemaps/valueobjects.i

EXTRA_DIST = \
    .time-stamp \
    Makefile.vc \
    swigrun_cpp_vc9.vcproj \
    swigrun_xl_vc9.vcproj \
    $(SWIG_FILES)

SWIG_DIR = @swig_dir@
SWIG_BIN = $(SWIG_DIR)/preinst-swig
#SWIG_DEBUG = -debug-top 4 -debug-tmsearch

SWIG_ARGS = -c++ -reposit -prefix ql
if BUILD_CPP
    SWIG_ARGS += -gencpp
endif
#if BUILD_CALC
#    SWIG_ARGS += -gencalc
#endif
if BUILD_CFY
    SWIG_ARGS += -gencfy
endif
SWIG_ARGS += quantlib.i

.PHONY: SWIG
SWIG: .time-stamp

.time-stamp: $(SWIG_FILES)
	$(SWIG_BIN) $(SWIG_DEBUG) $(SWIG_ARGS)
	touch .time-stamp

clean:
	rm -f .time-stamp

