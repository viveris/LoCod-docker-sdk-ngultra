FROM centos:7
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
MAINTAINER Julien ARMENGAUD <julien.armengaud@viveris.fr>
LABEL description="Docker with NG-Ultra SDK"

# Adding packages for NG-Ultra SDK
RUN     yum -y update && \
        yum -y install git bzip2 make libtool pkgconfig autoconf && \
        yum clean all


# Install NG-Ultra BSP
RUN     cd /opt && \
        git clone --recursive https://jarmengaud:YSzFPNQ5bnWx3P3Nh5Kw@gitlabext.nanoxplore.com/nx_sw_embedded/baremetal/bsps/ngultra_bsp.git


# Copy ARM none eabi GCC install archive to docker
COPY    gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 /opt/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2


# Install ARM none eabi GCC (add to PATH)
RUN     cd /opt && \
        tar -xvf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 && \
        rm -rf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
ENV     PATH=/opt/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH


# Workdir
RUN     mkdir -p /opt/ngultra_bsp/apps/locod/
RUN     chmod -R 777 /opt/ngultra_bsp
WORKDIR /opt/ngultra_bsp/apps/locod/
