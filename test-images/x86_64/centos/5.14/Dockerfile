FROM quay.io/centos/centos:stream9

ARG VERSION=5.14.0-325
ARG BASEOS_URL='https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os/Packages'
ARG APPSTR_URL='http://mirror.stream.centos.org/9-stream/AppStream/x86_64/os/Packages'

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
	curl -Lo headers.rpm ${APPSTR_URL}/kernel-devel-${VERSION}.el9.x86_64.rpm && \
	dnf install -y ./headers.rpm && \
	rm -v ./headers.rpm && \
	curl -Lo bpftool.rpm ${BASEOS_URL}/bpftool-7.1.0-325.el9.x86_64.rpm && \
	dnf install -y ./bpftool.rpm && \
	rm -v ./bpftool.rpm && \
	mkdir -p /lib/modules/${VERSION}.el9.x86_64/ && \
	ln -s /usr/src/kernels/${VERSION}.el9.x86_64/ /lib/modules/${VERSION}.el9.x86_64/build && \
	sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config && \
	echo "root:root" | chpasswd

