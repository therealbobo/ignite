FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /home/ubuntu

RUN apt-get update && apt-get install -y \
		build-essential \
		clang \
		cmake \
		curl \
		dbus \
		git \
		iproute2 \
		iputils-ping \
		kmod \
		libcap-dev \
		libelf-dev \
		llvm \
		net-tools \
		openssh-server \
		rng-tools \
		rsync \
		sudo \
		systemd \
		udev \
		wget

COPY /* /home/ubuntu/

RUN apt install -y --fix-broken ./*.deb && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -v *.deb && \
	rm -v /boot/initrd* && \
	find /lib/modules -name '*.ko' -delete && \
	echo "" > /etc/machine-id && echo "" > /var/lib/dbus/machine-id && \
	sed -i -e 's/^AcceptEnv LANG LC_\*$/#AcceptEnv LANG LC_*/' /etc/ssh/sshd_config && \
	echo "root:root" | chpasswd
