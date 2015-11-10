
COUNTIFY_DIR = @countify_dir@
# FIXME parameterize this
#COUNTIFY_LIB = /home/countify/countify/lib
AM_CPPFLAGS = -I${top_srcdir} -I${top_builddir} -I$(COUNTIFY_DIR) -I$(COUNTIFY_DIR)/ACE_wrappers -I$(COUNTIFY_DIR)/ACE_wrappers/debian

ClientCountify_LDADD = ../../AddinCfy/libCountifyQuantLibAddin.la
#ClientCountify_LDFLAGS = -lreposit -lQuantLib -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex -L$(COUNTIFY_LIB) -lFlyLib -lACE -ljsonparser
ClientCountify_LDFLAGS = -lreposit -lQuantLib -lboost_filesystem -lboost_serialization -lboost_system -lboost_regex
ClientCountify_SOURCES = ClientCountify.cpp

if BUILD_CFY
noinst_PROGRAMS = ClientCountify
else
EXTRA_PROGRAMS = ClientCountify
endif

