FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y \
        wget \
        g++ \
        cmake \
        libeigen3-dev \
        libopenimageio-dev \
        libgtest-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libjpeg-dev \
        freeglut3-dev \
        libxmu-dev \
        libxi-dev \
        libhdf5-dev \
        libilmbase-dev \
        libblas-dev \
        libsuitesparse-dev \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Build gtest
RUN cd /tmp \
    && mkdir gtest \
    && cd gtest \
    && cmake -DBUILD_SHARED_LIBS=on /usr/src/gtest \
    && make \
    && cp lib* /usr/local/lib/ \
    && cd / \
    && rm -rf /tmp/gtest

# Install ceres from source

# Not using the package libceres-dev due to:
# https://bugs.launchpad.net/ubuntu/+source/ceres-solver/+bug/1596296
# https://bugs.launchpad.net/ubuntu/+source/ceres-solver/+bug/1595692

RUN cd /tmp \
    && wget -q http://ceres-solver.org/ceres-solver-1.12.0.tar.gz \
    && tar xzf ceres-solver-1.12.0.tar.gz \
    && mkdir ceres-build \
    && cd ceres-build \
    && cmake -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF -DBUILD_SHARED_LIBS=ON ../ceres-solver-1.12.0 \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/ceres-build /tmp/ceres-solver-1.12.0


