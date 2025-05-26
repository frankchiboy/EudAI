#!/bin/bash
set -e

echo "🔄 還原 open_webui_volume..."
docker volume create open_webui_volume
docker run --rm -v open_webui_volume:/data -v $(pwd)/backup:/backup ubuntu \
  tar xzf /backup/open_webui_volume.tar.gz -C /data

echo "🔄 還原 searxng_volume..."
docker volume create searxng_volume
docker run --rm -v searxng_volume:/data -v $(pwd)/backup:/backup ubuntu \
  tar xzf /backup/searxng_volume.tar.gz -C /data

echo "📥 匯入 open-webui image..."
docker load -i backup/open-webui-image.tar

echo "🚀 啟動服務..."
docker compose up -d
