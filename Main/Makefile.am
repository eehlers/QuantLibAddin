
AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}
#MainQuantLibAddin_LDADD = ../ValueObjects/libValueObjects.la ../AddinObjects/libAddinObjects.la ../AddinCpp/libAddinCpp.la
MainQuantLibAddin_LDADD = ../AddinCpp/libAddinCpp.la
MainQuantLibAddin_LDFLAGS = -lObjectHandler -lQuantLib -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex
MainQuantLibAddin_SOURCES = mainQuantLibAddin.cpp
noinst_PROGRAMS = MainQuantLibAddin

