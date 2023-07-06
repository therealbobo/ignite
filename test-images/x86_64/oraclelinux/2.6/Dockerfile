FROM oraclelinux:7

ARG VERSION=3.10.0-1160.92.1.0.2
ARG URL='https://yum.oracle.com/repo/OracleLinux/OL7/MODRHCK/x86_64'

RUN yum install -y systemd openssh-server iproute clang llvm rsync libcap-devel \
	gcc make binutils-devel kmod && \
	curl -L -o kernel.rpm  ${URL}/getPackage/kernel-${VERSION}.el7.x86_64.rpm && \
	curl -L -o devel.rpm   ${URL}/getPackage/kernel-devel-${VERSION}.el7.x86_64.rpm && \
	yum install -y ./kernel.rpm ./devel.rpm  && \
	sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config && \
	echo "root:root" | chpasswd && \
	yum install -y git tar && \
	curl -LO https://cmake.org/files/v3.16/cmake-3.16.7-Linux-x86_64.tar.gz && \
	tar -xaf cmake-3.16.7-Linux-x86_64.tar.gz && \
	rm -vf cmake-3.16.7-Linux-x86_64.tar.gz && \
	mv cmake-3.16.7-Linux-x86_64     /opt/cmake-3.16.7 && \
	ln -sf  /opt/cmake-3.16.7/bin/*    /usr/bin/ && \
	mkdir -p  /lib/modules/${VERSION}.el7.x86_64/ && \
	ln -s /usr/src/kernels/${VERSION}.el7.x86_64/ /lib/modules/${VERSION}.el7.x86_64/build
	#yum remove -y gcc && \
	#update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc10-gcc 100 --slave /usr/bin/g++ g++ /usr/bin/gcc10-c++ && \
	#update-alternatives --auto gcc
