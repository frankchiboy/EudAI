#!/bin/bash
set -e
mkdir -p backup

echo "📦 備份 open_webui_volume..."
docker run --rm -v open_webui_volume:/data -v $(pwd)/backup:/backup ubuntu \
  tar czf /backup/open_webui_volume.tar.gz -C /data .

echo "📦 備份 searxng_volume..."
docker run --rm -v searxng_volume:/data -v $(pwd)/backup:/backup ubuntu \
  tar czf /backup/searxng_volume.tar.gz -C /data .

echo "📤 匯出 open-webui image..."
docker save -o backup/open-webui-image.tar ghcr.io/open-webui/open-webui:latest

echo "✅ 備份完成。"
