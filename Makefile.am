
ACLOCAL_AMFLAGS = -I m4

SUBDIRS = \
    m4 \
    qlo \
    AddinCpp \
    Main

SWIG_DIR = @swig_dir@

SWIG:
	$(SWIG_DIR)/swig -I$(SWIG_DIR)/Lib/reposit -prefix ql -c++ -reposit quantlib.i

