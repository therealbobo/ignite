FROM amazonlinux:2022

ARG VERSION=5.15.73-45
ARG URL='https://al2022-repos-us-east-1-9761ab97.s3.dualstack.us-east-1.amazonaws.com/core/mirrors/latest/aarch64'


RUN dnf groupinstall -y 'Development Tools' && \
	dnf install -y \
		binutils-devel \
		chrony \
		clang \
		cmake \
		iproute \
		kmod \
		libcap-devel \
		llvm \
		make \
		openssh-server \
		rsync \
		systemd && \
	curl -sLO "$URL"/mirror.list && \
	URL=$(cat mirror.list) && \
	curl -sLO "${URL}"repodata/primary.xml.gz && \
	gunzip primary.xml.gz && \
    grep -E 'kernel-headers-'${VERSION}'.*.rpm' primary.xml | grep href | cut -d\"  -f2 | \
		xargs -I@ curl -Lo headers.rpm ${URL}@ && \
    grep -E 'kernel-devel-'${VERSION}'.*.rpm' primary.xml | grep href | cut -d\"  -f2 | \
		xargs -I@ curl -Lo sources.rpm ${URL}@ && \
    grep -E 'bpftool-'${VERSION}'.*.rpm' primary.xml | grep href | cut -d\"  -f2 | \
		xargs -I@ curl -Lo bpftool.rpm ${URL}@ && \
	dnf install -y ./headers.rpm ./bpftool.rpm ./sources.rpm && \
	mkdir -p  /lib/modules/5.15.73-45.135.amzn2022.aarch64/ && \
	ln -s /usr/src/kernels/5.15.73-45.135.amzn2022.aarch64/ /lib/modules/5.15.73-45.135.amzn2022.aarch64/build && \
	sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config && \
	echo "root:root" | chpasswd

