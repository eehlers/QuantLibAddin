
SWIG_DIR = @swig_dir@

#SWIG_DEBUG = -debug-top 4 -debug-tmsearch

.PHONY: SWIG
SWIG:
	$(SWIG_DIR)/swig -I$(SWIG_DIR)/Lib/reposit -prefix ql -c++ -reposit quantlib.i

