
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
SWIG:
	$(SWIG_BIN) $(SWIG_DEBUG) $(SWIG_ARGS)

