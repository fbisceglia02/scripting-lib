#!/bin/bash

# Source and target container registries
SRC_CR="tmsacreusd.azurecr.io"
DST_CR="provapush.azurecr.io"

# Images to migrate (source format)
IMAGES=(
  "tms-audit:5.5.0"
  "tms-msdk-charybui-shell:7.12.0"
  "tms-cmps:8.22.3"
  "tms-hd:3.22.5"
  "tms-pam:5.14.21"
  "tms-tnm:8.10.7"
  "tms-usm:8.9.12"
)

for IMG in "${IMAGES[@]}"; do
  SRC_IMG="${SRC_CR}/${IMG}"
  DST_IMG="${DST_CR}/${IMG}"

  echo "Processing ${IMG}"

  echo "  Pulling from source..."
  docker pull "${SRC_IMG}"

  echo "  Tagging for destination..."
  docker tag "${SRC_IMG}" "${DST_IMG}"

  echo "  Pushing to destination..."
  docker push "${DST_IMG}"

  echo "  Done: ${DST_IMG}"
  echo
done
