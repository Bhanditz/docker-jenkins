#!/bin/bash
set -e

if [[ $(docker inspect $1 | grep -i status | cut -d : -f 2) = *running* ]]; then exit 0; else exit 1; fi

