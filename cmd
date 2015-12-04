
IDIR=/media/windows/linux/repos/reposit/install
SWIG_DIR=/media/windows/linux/repos/reposit/swig

./configure \
    CXXFLAGS=-Wno-unused-local-typedefs \
    --prefix=$IDIR \
    --with-boost-include=$IDIR/include \
    --with-boost-lib=$IDIR/lib \
    --with-swig=$SWIG_DIR \
    --enable-addin-cpp

