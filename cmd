
./configure \
    CXXFLAGS=-Wno-unused-local-typedefs \
    --enable-addin-cpp \
    --prefix=$REPOSIT_DIR/install \
    --with-boost-include=$REPOSIT_DIR/install/include \
    --with-boost-lib=$REPOSIT_DIR/install/lib \
    --with-swig=$REPOSIT_DIR/swig

