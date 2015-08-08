
SWIG_DIR = @swig_dir@
SWIG_BIN = $(SWIG_DIR)/preinst-swig
#SWIG_DEBUG = -debug-top 4 -debug-tmsearch

.PHONY: SWIG
SWIG:
#	$(SWIG) -prefix ql -c++ -reposit quantlib.i
	$(SWIG_BIN) $(SWIG_DEBUG) -c++ -reposit -gencpp -gencfy -prefix ql quantlib.i

