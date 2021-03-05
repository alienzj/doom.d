#!/usr/bin/env bash
set -euo pipefail

#sizes="256 64 48 32 24 20 16"
sizes="22"

for _size in ${sizes}; do
  inkscape --without-gui --export-png=icon-${_size}.png --export-width=${_size} --export-height=${_size} logo-snake.svg &&
  pngs+=" icon-${_size}.png"
  if [ $? -eq 1 ]; then exit 1; fi
done
convert -verbose ${pngs} snakemake.ico &&
#rm ${pngs}
