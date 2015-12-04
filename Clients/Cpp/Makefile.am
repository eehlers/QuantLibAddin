
AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}
ClientCppDemo_LDADD = ../../AddinCpp/libAddinCpp.la
ClientCppDemo_LDFLAGS = -lreposit -lQuantLib -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex
ClientCppDemo_SOURCES = ClientCppDemo.cpp

EXTRA_DIST = \
    ClientCppDemo_vc9.vcproj

if BUILD_CPP
noinst_PROGRAMS = ClientCppDemo
else
EXTRA_PROGRAMS = ClientCppDemo
endif

