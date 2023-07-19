#!/bin/bash

PPA=https://kernel.ubuntu.com/~kernel-ppa/mainline/

declare -A ARCHCONV=( ["aarch64"]="arm64" ["x86_64"]="amd64")

CANONARCH=$(uname -m)
ARCH=${ARCHCONV[$CANONARCH]}

readarray ALL_VERSIONS < <(curl -sL $PPA | grep -oE 'href="v[0-9]+\.[0-9]+(\.[0-9]+){0,1}."' | cut -d\" -f2 | tr -d '\/')

readarray ALL_MINORS < <(printf "%s\n" ${ALL_VERSIONS[@]} | cut -d. -f1-2 | sort -V -u)

readarray LATEST_MINORS < <(for MINOR in ${ALL_MINORS[@]}; do
	printf "%s\n" ${ALL_VERSIONS[@]} | grep "$MINOR" | sort -r -V | head -1
done
)

mkdir -p out/${CANONARCH}/mainline

cd out/${CANONARCH}/mainline

for V in ${LATEST_MINORS[@]}; do
	#TODO(therealbobo): some old kernels are stored in the parent directory ${V}
	echo Downloading debs for kernel ${V}...
	mkdir $V
	cd $V
	curl -sL "${PPA}/${V}/${ARCH}" | grep -Eo 'href="linux-.*' | cut -d\" -f2 | \
		grep -vE 'lowlatency|snapdragon|lpae' | \
		xargs -I@ curl -sLO "${PPA}/${V}/${ARCH}/@"
	cd ..
done

echo 'Deleting empty dirs:'
find . -type d -empty -print -delete
cd ../../..

cp Makefile out/
ls out/$CANONARCH/mainline | xargs -I@ cp Dockerfile Dockerfile.kernel out/$CANONARCH/mainline/@

FOCALMAX='v5.12'
while read VERSION  ; do
	echo -e "${FOCALMAX}\n${VERSION}" | \
		sort -C -V &&
		sed -i -e 's/FROM ubuntu:20.04/FROM ubuntu:22.04/g' out/$(uname -m)/mainline/${VERSION}/Dockerfile
done < <(ls out/$(uname -m)/mainline)
