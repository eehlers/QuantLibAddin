
ACLOCAL_AMFLAGS = -I m4

SUBDIRS = m4 docstrings swig qlo AddinCfy AddinCpp AddinCSharp Clients Docs

EXTRA_DIST = \
    QuantLibAddin_vc9.sln \
    QuantLibObjects_vc9.vcproj

.PHONY: SWIG
SWIG:
	$(MAKE) -C docstrings
	$(MAKE) -C swig

.PHONY: docs docs-clean
docs:
	$(MAKE) -C Docs docs-html
docs-clean:
	$(MAKE) -C Docs docs-clean

