#!/bin/bash

theme=${LOGSEQ_THEME:-"light"}

[[ ! -d "/graph" ]] && \
  echo "missing graph directory" >/dev/stderr && \
  exit 1

[[ ! -d "/out" ]] && \
  echo "missing out directory" >/dev/stderr && \
  exit 1

sudo chown -R logseq:users /out || exit 1

node \
  /publish-spa/publish_spa.mjs \
  /out \
  --static-directory \
  /publish-spa/logseq/static \
  --directory /graph \
  --theme-mode ${theme} || exit 1

