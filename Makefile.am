
ACLOCAL_AMFLAGS = -I m4

SUBDIRS = m4 swig qlo AddinCfy AddinCpp AddinCSharp Clients

EXTRA_DIST = \
    QuantLibAddin_vc9.sln \
    QuantLibObjects_vc9.vcproj

.PHONY: SWIG
SWIG:
	$(MAKE) -C swig SWIG

