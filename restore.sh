#!/bin/bash

echo "🔁 Creating volumes..."
docker volume create open_webui_volume
docker volume create searxng_volume

echo "📦 Restoring open_webui_volume..."
docker run --rm \
  -v open_webui_volume:/data \
  -v "$(pwd)/backup":/backup \
  ubuntu tar -xzvf /backup/open_webui_volume.tar.gz -C /data

echo "📦 Restoring searxng_volume..."
docker run --rm \
  -v searxng_volume:/data \
  -v "$(pwd)/backup":/backup \
  ubuntu tar -xzvf /backup/searxng_volume.tar.gz -C /data

echo "🚀 Starting containers..."
docker compose up -d
