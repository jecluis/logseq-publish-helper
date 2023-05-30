#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "usage: $0 <graph-dir> <output-dir> [dark|light]" >/dev/stderr
  exit 1
fi

graphdir=${1}
outdir=${2}
theme=${3}

[[ ! -d "${graphdir}" ]] && \
  echo "graph dir at '${graphdir}' does not exist" >/dev/stderr && \
  exit 1

[[ ! -d "${outdir}" ]] && ( mkdir ${outdir} || exit 1 )

extra_args=
if [[ -n "${theme}" ]]; then
  extra_args="-e LOGSEQ_THEME=${theme}"
fi

podman run -it \
  -v ${graphdir}:/graph \
  -v ${outdir}:/out \
  ${extra_args} \
  localhost/logseq-publish-spa:latest

