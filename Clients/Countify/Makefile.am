
AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir}
ClientCountify_LDADD = ../../AddinCfy/libCountifyQuantLibAddin.la
ClientCountify_LDFLAGS = -lreposit -lQuantLib -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex
ClientCountify_SOURCES = ClientCountify.cpp

if BUILD_CFY
noinst_PROGRAMS = ClientCountify
else
EXTRA_PROGRAMS = ClientCountify
endif

