#!/bin/bash


usage() {
  cat << EOF
usage: $0 <directory> <user@host> </path/to/location>

Requires 'scp' to perform the upload.
EOF
}

[[ $# -lt 3 ]] && usage && exit 1

srcdir=${1}
dsthost=${2}
dstdir=${3}

origdir=$(pwd)

pushd ${srcdir}
tar cvf ${origdir}/contents.tar * || exit 1
popd

scp -r ${origdir}/contents.tar ${dsthost}:${dstdir} || exit 1
ssh ${dsthost} \
  "cd ${dstdir} && tar xvf contents.tar && rm contents.tar" || \
  exit 1

rm ${origdir}/contents.tar
