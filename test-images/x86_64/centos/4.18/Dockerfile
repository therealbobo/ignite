FROM quay.io/centos/centos:stream8

ARG VERSION=4.18.0-497
ARG BASEOS_URL='http://mirror.centos.org/centos/8-stream/BaseOS/x86_64/os/Packages'

RUN dnf groupinstall -y 'Development Tools' && \
	dnf install -y --allowerasing \
		curl \
		systemd \
		openssh-server \
		iproute \
		rsync \
		cmake \
		clang \
		llvm \
		libcap-devel \
		git && \
	curl -Lo headers.rpm ${BASEOS_URL}/kernel-devel-${VERSION}.el8.x86_64.rpm && \
	dnf install -y ./headers.rpm && \
	rm -v ./headers.rpm && \
	curl -Lo bpftool.rpm ${BASEOS_URL}/bpftool-${VERSION}.el8.x86_64.rpm && \
	dnf install -y ./bpftool.rpm && \
	rm -v ./bpftool.rpm && \
	mkdir -p /lib/modules/${VERSION}.el8.x86_64/ && \
	ln -s /usr/src/kernels/${VERSION}.el8.x86_64/ /lib/modules/${VERSION}.el8.x86_64/build && \
	sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config && \
	echo "root:root" | chpasswd

