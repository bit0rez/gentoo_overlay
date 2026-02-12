#!/bin/zsh

TMPFILE=/tmp/max-packages

restish get https://download.max.ru/linux/deb/dists/stable/main/binary-amd64/Packages > ${TMPFILE}

cwd=$(dirname $0)

for version in $(cat ${TMPFILE} | ag Filename | awk '{print $2}' | sed 's#pool/main/m/max/MAX-##;s#\.deb##'); do 
	cp -f ${cwd}/max.ebuild.tpl ${cwd}/max-$version.ebuild
done
