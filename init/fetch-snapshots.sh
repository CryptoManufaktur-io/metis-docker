#!/usr/bin/env bash
set -euo pipefail

# Prep l2geth datadir
if [ -n "${SNAPSHOT}" ] && [ ! -d "/root/.ethereum/geth/chaindata/" ]; then
  __dont_rm=0
  mkdir -p /root/.ethereum/geth/
  mkdir -p /root/.ethereum/snapshot
  cd /root/.ethereum/snapshot
  eval "__url=${SNAPSHOT}"
  aria2c -c -x6 -s6 --auto-file-renaming=false --conditional-get=true --allow-overwrite=true "${__url}"
  filename=$(echo "${__url}" | awk -F/ '{print $NF}')
  if [[ "${filename}" =~ \.tar\.zst$ ]]; then
    pzstd -c -d "${filename}" | tar xvf - -C /root/.ethereum/geth
  elif [[ "${filename}" =~ \.tar\.gz$ || "${filename}" =~ \.tgz$ ]]; then
    tar xzvf "${filename}" -C /root/.ethereum/geth
  elif [[ "${filename}" =~ \.tar$ ]]; then
    tar xvf "${filename}" -C /root/.ethereum/geth
  elif [[ "${filename}" =~ \.lz4$ ]]; then
    lz4 -d "${filename}" | tar xvf - -C /root/.ethereum/geth
  else
    __dont_rm=1
    echo "The snapshot file has a format that Metis Docker can't handle."
    echo "Please come to CryptoManufaktur Discord to work through this."
  fi
  if [ "${__dont_rm}" -eq 0 ]; then
    rm -f "${filename}"
  fi
  if [[ ! -d /root/.ethereum/geth/chaindata ]]; then
    echo "Chaindata isn't in the expected location."
    echo "This snapshot likely won't work until the fetch script has been adjusted for it."
  fi
fi

# Prep l1dtl datadir
if [ -n "${DTL_SNAPSHOT}" ] && [ ! -d "/data/db/" ]; then
  __dont_rm=0
  mkdir -p /data/snapshot
  cd /data/snapshot
  eval "__url=${SNAPSHOT}"
  aria2c -c -x6 -s6 --auto-file-renaming=false --conditional-get=true --allow-overwrite=true "${__url}"
  filename=$(echo "${__url}" | awk -F/ '{print $NF}')
  if [[ "${filename}" =~ \.tar\.zst$ ]]; then
    pzstd -c -d "${filename}" | tar xvf - -C /data
  elif [[ "${filename}" =~ \.tar\.gz$ || "${filename}" =~ \.tgz$ ]]; then
    tar xzvf "${filename}" -C /data
  elif [[ "${filename}" =~ \.tar$ ]]; then
    tar xvf "${filename}" -C /data
  elif [[ "${filename}" =~ \.lz4$ ]]; then
    lz4 -d "${filename}" | tar xvf - -C /data
  else
    __dont_rm=1
    echo "The dtl snapshot file has a format that Metis Docker can't handle."
    echo "Please come to CryptoManufaktur Discord to work through this."
  fi
  if [ "${__dont_rm}" -eq 0 ]; then
    rm -f "${filename}"
  fi
  if [[ ! -d /data/db ]]; then
    echo "DTL data isn't in the expected location."
    echo "This dtl snapshot likely won't work until the fetch script has been adjusted for it."
  fi
fi
