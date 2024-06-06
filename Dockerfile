FROM centos:7
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
MAINTAINER Julien ARMENGAUD <julien.armengaud@viveris.fr>
LABEL description="Docker with NG-Ultra SDK"


# Arguments
ARG     NX_USERNAME
ARG     NX_PERSONAL_ACCESS_TOKEN


# Adding packages for NG-Ultra SDK
RUN     yum -y update && \
        yum -y install git bzip2 make libtool pkgconfig autoconf && \
        yum clean all


# Install NG-Ultra BSP
RUN     cd /opt && \
        git clone --recursive --branch ngultra_bsp_v2.3.3 https://${NX_USERNAME}:${NX_PERSONAL_ACCESS_TOKEN}@gitlabext.nanoxplore.com/nx_sw_embedded/baremetal/bsps/ngultra_bsp.git

# Install ARM none eabi GCC (add to PATH)
RUN     cd /opt && \
        curl https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 --output gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 && \
        tar -xvf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 && \
        rm -rf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
ENV     PATH=/opt/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH


# Workdir
RUN     mkdir -p /opt/ngultra_bsp/apps/locod/
RUN     chmod -R 777 /opt/ngultra_bsp
WORKDIR /opt/ngultra_bsp/apps/locod/
