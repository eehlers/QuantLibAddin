
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
    typemaps/addincountify.i \
    typemaps/addincpp.i \
    typemaps/addinexcel.i \
    typemaps/all.i \
    typemaps/apply.i \
    typemaps/libraryobjects.i \
    typemaps/serialization.i \
    typemaps/shared.i \
    typemaps/valueobjects.i

SWIG_DIR = @swig_dir@
SWIG_BIN = $(SWIG_DIR)/swig
SWIG_CMD = $(SWIG_DIR)/preinst-swig
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
SWIG_ARGS += -genxll
SWIG_ARGS += quantlib.i

.PHONY: SWIG
SWIG: .time-stamp

.time-stamp: $(SWIG_FILES) $(SWIG_BIN)
	$(SWIG_CMD) $(SWIG_DEBUG) $(SWIG_ARGS)
	touch .time-stamp

clean:
	rm -f .time-stamp

