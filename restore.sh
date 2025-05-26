#!/bin/bash
set -e

docker volume create open_webui_volume
docker run --rm -v open_webui_volume:/data -v $(pwd)/backup:/backup ubuntu \
  tar xzf /backup/open_webui_volume.tar.gz -C /data

docker volume create searxng_volume
docker run --rm -v searxng_volume:/data -v $(pwd)/backup:/backup ubuntu \
  tar xzf /backup/searxng_volume.tar.gz -C /data

docker compose pull
docker compose up -d
