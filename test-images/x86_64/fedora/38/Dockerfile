FROM fedora:38

ARG VERSION=6.2.9-300
ARG HVERSION=6.2.6-300
ARG URL='https://mirrors.kernel.org/fedora/releases/38/Everything/x86_64/os/Packages'

RUN dnf groupinstall -y 'Development Tools' && \
	dnf install -y clang llvm rsync cmake libcap-devel && \
	curl -Lo bpftool.rpm ${URL}/b/bpftool-${HVERSION}.fc38.x86_64.rpm && \
	curl -Lo sources.rpm ${URL}/k/kernel-devel-${VERSION}.fc38.x86_64.rpm    && \
	curl -Lo headers.rpm ${URL}/k/kernel-headers-${HVERSION}.fc38.x86_64.rpm && \
	dnf install -y ./bpftool.rpm ./sources.rpm ./headers.rpm && \
	rm -v ./bpftool.rpm ./sources.rpm ./headers.rpm && \
	mkdir -p /lib/modules/${VERSION}.fc38.x86_64 && \
	ln -s /usr/src/kernels/${VERSION}.fc38.x86_64/ /lib/modules/${VERSION}.fc38.x86_64/build && \
	dnf install -y systemd openssh-server iproute && \
	sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config && \
	echo "root:root" | chpasswd

