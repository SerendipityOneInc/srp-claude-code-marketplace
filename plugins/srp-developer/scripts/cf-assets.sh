#!/bin/bash
# cf-assets: Manage files on Cloudflare R2 storage via REST API
# Base URL: https://assets.yesy.site
#
# Usage:
#   cf-assets.sh upload <file_path>              Upload a file (preferred for files > 512KB)
#   cf-assets.sh list [--type TYPE] [--year YYYY] [--month MM]   List files with optional filters
#   cf-assets.sh delete <key>                    Delete a file by its full key
#   cf-assets.sh info <file_path>                Show file size and whether MCP or REST is recommended
#
# Types: images, videos, web, documents, other
#
# Examples:
#   cf-assets.sh upload ~/Downloads/photo.png
#   cf-assets.sh list --type images --year 2026 --month 02
#   cf-assets.sh delete images/2026/02/abc12345.png
#   cf-assets.sh info ~/Downloads/large-video.mp4

set -euo pipefail

ASSETS_BASE_URL="${ASSETS_BASE_URL:-https://assets.yesy.site}"
SIZE_THRESHOLD=524288  # 512KB in bytes

cmd_upload() {
  local file_path="$1"
  if [ ! -f "$file_path" ]; then
    echo "{\"state\":false,\"message\":\"File not found: $file_path\"}" >&2
    exit 1
  fi
  curl -s -f -F "file=@${file_path}" "${ASSETS_BASE_URL}/api/upload"
}

cmd_list() {
  local params=""
  while [ $# -gt 0 ]; do
    case "$1" in
      --type)  params="${params:+${params}&}type=$2"; shift 2 ;;
      --year)  params="${params:+${params}&}year=$2"; shift 2 ;;
      --month) params="${params:+${params}&}month=$2"; shift 2 ;;
      *) echo "{\"state\":false,\"message\":\"Unknown option: $1\"}" >&2; exit 1 ;;
    esac
  done
  local url="${ASSETS_BASE_URL}/api/list"
  [ -n "$params" ] && url="${url}?${params}"
  curl -s -f "$url"
}

cmd_delete() {
  local key="$1"
  curl -s -f -X DELETE "${ASSETS_BASE_URL}/api/delete/${key}"
}

cmd_info() {
  local file_path="$1"
  if [ ! -f "$file_path" ]; then
    echo "{\"state\":false,\"message\":\"File not found: $file_path\"}" >&2
    exit 1
  fi
  local size
  size=$(stat -f%z "$file_path" 2>/dev/null || stat -c%s "$file_path" 2>/dev/null)
  local name
  name=$(basename "$file_path")
  local method="mcp"
  [ "$size" -ge "$SIZE_THRESHOLD" ] && method="rest-api"
  local human_size
  if [ "$size" -ge 1048576 ]; then
    human_size="$(echo "scale=1; $size / 1048576" | bc)MB"
  elif [ "$size" -ge 1024 ]; then
    human_size="$(echo "scale=0; $size / 1024" | bc)KB"
  else
    human_size="${size}B"
  fi
  echo "{\"file\":\"$name\",\"size\":$size,\"human_size\":\"$human_size\",\"recommended\":\"$method\",\"threshold\":\"512KB\"}"
}

# Main
if [ $# -lt 1 ]; then
  echo "Usage: cf-assets.sh <upload|list|delete|info> [args...]" >&2
  exit 1
fi

command="$1"; shift
case "$command" in
  upload) [ $# -lt 1 ] && { echo "Usage: cf-assets.sh upload <file_path>" >&2; exit 1; }; cmd_upload "$1" ;;
  list)   cmd_list "$@" ;;
  delete) [ $# -lt 1 ] && { echo "Usage: cf-assets.sh delete <key>" >&2; exit 1; }; cmd_delete "$1" ;;
  info)   [ $# -lt 1 ] && { echo "Usage: cf-assets.sh info <file_path>" >&2; exit 1; }; cmd_info "$1" ;;
  *)      echo "{\"state\":false,\"message\":\"Unknown command: $command. Use upload|list|delete|info\"}" >&2; exit 1 ;;
esac
