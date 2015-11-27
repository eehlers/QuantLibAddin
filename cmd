
#IDIR=/media/windows/linux/repos/reposit/install
#SWIG_DIR=/media/windows/linux/repos/reposit/swig

IDIR=/home/countify/install
SWIG_DIR=/home/countify/projects/swig

./configure \
    CXXFLAGS=-Wno-unused-local-typedefs \
    --prefix=$IDIR \
    --with-boost-include=$IDIR/include \
    --with-boost-lib=$IDIR/lib \
    --with-swig=$SWIG_DIR \
    --with-countify=/home/countify/sdk/Eric-SDK \
    --enable-addin-cpp \
    --enable-addin-cfy
