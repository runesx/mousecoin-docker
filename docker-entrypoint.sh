#!/bin/bash
set -e

if [[ "$1" == "mic3-cli" || "$1" == "mic3-tx" ]]; then
	exec "$@"
else
  mic3d
  trap "echo signal;exit 0" SIGINT

  while :
  do
    sleep infinity
  done
fi

