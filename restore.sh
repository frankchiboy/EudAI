#!/bin/bash

echo "📦 建立正確的 volume..."
docker volume create eudai_open_webui_volume
docker volume create eudai_searxng_volume

echo "📂 還原 open_webui_volume 到 eudai_open_webui_volume..."
docker run --rm \
  -v eudai_open_webui_volume:/data \
  -v "$(pwd)/backup":/backup \
  ubuntu tar -xvzf /backup/open_webui_volume.tar.gz -C /data

echo "📂 還原 searxng_volume 到 eudai_searxng_volume..."
docker run --rm \
  -v eudai_searxng_volume:/data \
  -v "$(pwd)/backup":/backup \
  ubuntu tar -xvzf /backup/searxng_volume.tar.gz -C /data

echo "🚀 啟動服務..."
docker compose up -d
