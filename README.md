# 🧠 EudAI: Portable Open WebUI + SearXNG Stack

This repository provides a fully containerized snapshot of your EudAI project — including [Open WebUI](https://github.com/open-webui/open-webui) (v0.5.4), [SearXNG](https://github.com/searxng/searxng), and preloaded data volumes.

> ✅ Designed for backup, versioning, and portable restoration via GitHub + Git LFS.

---

## 📁 Project Structure

```
EudAI/
├── docker-compose.yml              # Service definitions
├── backup.sh                       # One-click volume backup
├── restore.sh                      # One-click volume restore
├── .gitattributes                  # Git LFS tracked files
├── .gitignore                      # Ignore non-versioned files
├── backup/
│   ├── open_webui_volume.tar.gz    # Open WebUI volume snapshot
│   └── searxng_volume.tar.gz       # SearXNG volume snapshot
└── README.md
```

---

## 🚀 Quick Start (for restoring)

### ✅ Clone & Restore

```bash
git clone https://github.com/frankchiboy/EudAI.git
cd EudAI
git lfs install
git lfs pull
./restore.sh
```

> ⏳ This will:
> - Create Docker volumes
> - Extract snapshot data from `.tar.gz`
> - Pull container images
> - Launch Open WebUI and SearXNG

Access Open WebUI: http://localhost:3000

---

## 🧠 Ollama Integration (Optional)

EudAI supports using [Ollama](https://ollama.com/) to run local LLMs like LLaMA4, Mistral.

> 🛠️ Ensure Ollama is installed and running on your host:
```bash
curl http://localhost:11434
```

> Pull a model:
```bash
ollama pull llama4
```

### 🛠️ Enable Ollama in `docker-compose.yml`:

```yaml
environment:
  - USE_OLLAMA_DOCKER=true
  - OLLAMA_BASE_URL=http://host.docker.internal:11434
```

---

## 🧪 Snapshot Creation

> Run the following to backup volume contents to `.tar.gz`.

```bash
./backup.sh
```

It creates:

* `backup/open_webui_volume.tar.gz`
* `backup/searxng_volume.tar.gz`

---

## 🛠️ Restore Script Explanation

```bash
docker volume create open_webui_volume
docker run --rm -v open_webui_volume:/data -v $(pwd)/backup:/backup ubuntu \
  tar xzf /backup/open_webui_volume.tar.gz -C /data

docker volume create searxng_volume
docker run --rm -v searxng_volume:/data -v $(pwd)/backup:/backup ubuntu \
  tar xzf /backup/searxng_volume.tar.gz -C /data

docker compose up -d
```

---

## 🧰 Docker Compose Details

### ✅ Volume names are explicitly defined:

```yaml
volumes:
  open_webui_volume:
    name: open_webui_volume
  searxng_volume:
    name: searxng_volume
```

> ❗ This avoids `eudai_` prefixing on volume names and keeps backups compatible across systems.

---

## 💾 Git LFS Setup

```bash
git lfs install
git lfs track "backup/*.tar.gz"
```

`.gitattributes`:
```
backup/*.tar.gz filter=lfs diff=lfs merge=lfs -text
```

---



## ℹ️ Requirements

- Docker (latest)
- Git LFS
- (Optional) [Ollama](https://ollama.com/download)

---

## 📜 License

MIT — includes Open WebUI and SearXNG open-source components.

