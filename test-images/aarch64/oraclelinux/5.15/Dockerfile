FROM oraclelinux:9

ARG VERSION=5.15.0-8.91.4.1
ARG URL='https://yum.oracle.com/repo/OracleLinux/OL9/baseos/latest/aarch64'
ARG ARCH='aarch64'

RUN yum install -y \
		binutils-devel \
		clang \
		gcc \
		git \
		iproute \
		kmod \
		libcap-devel \
		llvm \
		make \
		openssh-server \
		rsync \
		systemd \
		tar && \
	curl -L -o kernel.rpm  ${URL}/getPackage/kernel-uek-core-${VERSION}.el9uek.${ARCH}.rpm && \
	curl -L -o devel.rpm   ${URL}/getPackage/kernel-uek-devel-${VERSION}.el9uek.${ARCH}.rpm && \
	curl -L -o modules.rpm ${URL}/getPackage/kernel-uek-modules-${VERSION}.el9uek.${ARCH}.rpm && \
	curl -L -o bpftool.rpm ${URL}/getPackage/bpftool-${VERSION}.el9uek.${ARCH}.rpm && \
	yum install -y ./kernel.rpm ./devel.rpm ./modules.rpm ./bpftool.rpm && \
	sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config && \
	echo "root:root" | chpasswd && \
	curl -LO https://cmake.org/files/v3.19/cmake-3.19.8-Linux-aarch64.tar.gz && \
	tar -xaf cmake-3.19.8-Linux-aarch64.tar.gz && \
	rm -vf cmake-3.19.8-Linux-aarch64.tar.gz && \
	mv cmake-3.19.8-Linux-aarch64     /opt/cmake-3.19.8 && \
	ln -sf  /opt/cmake-3.19.8/bin/*    /usr/bin/ && \
	mkdir -p  /lib/modules/5.15.0-8.91.4.1.el9uek.${ARCH}/ && \
	ln -s /usr/src/kernels/5.15.0-8.91.4.1.el9uek.${ARCH}/ /lib/modules/5.15.0-8.91.4.1.el9uek.${ARCH}/build
	#yum remove -y gcc && \
	#update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc10-gcc 100 --slave /usr/bin/g++ g++ /usr/bin/gcc10-c++ && \
	#update-alternatives --auto gcc


    #grep -E 'bpftool-'${VERSION}'.*.rpm' primary.xml | grep href | cut -d\"  -f2 | \
	#	xargs -I@ curl -Lo bpftool.rpm ${URL}/@ && \
