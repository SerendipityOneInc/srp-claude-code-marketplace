# Cloudflare Assets (R2 Storage)

Manage files on Cloudflare R2 storage at `assets.yesy.site`. Supports uploading, listing, and deleting files with **automatic routing** based on file size — small files go through MCP, large files go through REST API.

## When to Use This Skill

- User asks to "upload a file/image/video" to R2 or Cloudflare
- User asks to "list my files" or "what files do I have"
- User asks to "delete a file" from assets/R2
- User wants to store any file and get a public URL
- Referenced by `publish-html-page` skill for asset uploads

## When NOT to Use This Skill

- Publishing HTML pages — use `publish-html-page` skill (which calls this skill internally)
- Generic R2 SDK/API development — use `cloudflare-r2` skill
- Working with KV storage — use `cloudflare-kv` skill

---

## Upload: Smart Routing by File Size

**Threshold: 512KB**

```
File to upload
    │
    ├── size < 512KB  →  MCP tool (upload_file, base64)
    │                      Fast, no external tools needed
    │
    └── size >= 512KB →  Script (cf-assets.sh upload, REST API)
    │                      Multipart form-data, no base64 overhead
    │
    └── Returns public URL: https://assets.yesy.site/f/{category}/{year}/{month}/{id}.{ext}
```

### Why 512KB?

MCP tools encode file content as base64 strings in JSON parameters. Base64 adds ~33% overhead, so a 512KB file becomes ~680KB in transit. Above this threshold, the REST API with multipart form-data is significantly more efficient and avoids potential MCP payload limits.

---

## Operations

### 1. Upload a File

**Step 1: Check file size**

```bash
# Use the info command to determine recommended method
bash "$(dirname "$0")/../scripts/cf-assets.sh" info /path/to/file.png
# Returns: {"file":"file.png","size":1234567,"human_size":"1.2MB","recommended":"rest-api","threshold":"512KB"}
```

Or simply check in your logic: if file > 512KB → use script, else → use MCP.

**Step 2a: Small file (< 512KB) — Use MCP**

```
Tool: mcp__plugin_srp-developer_cloudflare-assets__upload_file
Args:
  filename: "photo.png"           # Used for type categorization
  content: "<base64-encoded>"     # File content as base64 string
```

**Step 2b: Large file (>= 512KB) — Use Script**

```bash
bash "$(dirname "$0")/../scripts/cf-assets.sh" upload /path/to/file.png
```

Both methods return the same JSON format:
```json
{
  "state": true,
  "message": "上传成功",
  "data": {
    "key": "images/2026/02/abc12345.png",
    "url": "https://assets.yesy.site/f/images/2026/02/abc12345.png",
    "size": 204800,
    "contentType": "image/png"
  }
}
```

**IMPORTANT:** The script path is relative to this skill. In practice, use the absolute path:
```bash
bash ~/.claude/plugins/cache/srp-claude-code-marketplace/srp-developer/*/scripts/cf-assets.sh upload /path/to/file
```
Or find the script dynamically:
```bash
SCRIPT=$(find ~/.claude/plugins/cache/srp-claude-code-marketplace/srp-developer -name "cf-assets.sh" -type f 2>/dev/null | head -1)
bash "$SCRIPT" upload /path/to/file
```

### 2. List Files

**Option A: MCP tool**

```
Tool: mcp__plugin_srp-developer_cloudflare-assets__list_files
Args:
  type: "images"     # Optional: images, videos, web, documents, other
  year: "2026"       # Optional
  month: "02"        # Optional
```

**Option B: Script** (useful when MCP is not available)

```bash
bash "$SCRIPT" list                                    # All files
bash "$SCRIPT" list --type images                      # Only images
bash "$SCRIPT" list --type videos --year 2026          # Videos from 2026
bash "$SCRIPT" list --type images --year 2026 --month 02  # Images from Feb 2026
```

### 3. Delete a File

**Option A: MCP tool**

```
Tool: mcp__plugin_srp-developer_cloudflare-assets__delete_file
Args:
  key: "images/2026/02/abc12345.png"    # Full key path
```

**Option B: Script**

```bash
bash "$SCRIPT" delete images/2026/02/abc12345.png
```

### 4. Check File Info (Script only)

```bash
bash "$SCRIPT" info /path/to/file.png
# {"file":"file.png","size":1234567,"human_size":"1.2MB","recommended":"rest-api","threshold":"512KB"}
```

---

## File Categories

Files are automatically organized by type and date:

| Category | Path Pattern | Extensions |
|----------|-------------|------------|
| images | `images/{year}/{month}/` | png, jpg, jpeg, gif, webp, svg, ico, bmp, tiff |
| videos | `videos/{year}/{month}/` | mp4, webm, mov, avi, mkv, flv |
| web | `web/{year}/{month}/` | html, htm |
| documents | `documents/{year}/{month}/` | pdf, doc, docx, xls, xlsx, ppt, pptx |
| other | `other/{year}/{month}/` | txt, json, csv, xml, yaml, yml, md, zip, tar, gz |

---

## Quick Decision Guide

| Scenario | Method | Why |
|----------|--------|-----|
| Upload a small icon (10KB) | MCP `upload_file` | Small, base64 is fine |
| Upload a screenshot (200KB) | MCP `upload_file` | Under 512KB threshold |
| Upload a photo (2MB) | Script `upload` | Over threshold, REST API efficient |
| Upload a video (50MB) | Script `upload` | Large file, must use REST API |
| List all images | MCP `list_files` or Script `list` | Either works, same result |
| Delete a file | MCP `delete_file` or Script `delete` | Either works, same result |
| Check if file needs REST API | Script `info` | Quick size check |

---

## Examples

### Example 1: User uploads a local image

```
User: "Upload ~/Downloads/photo.jpg to R2"

1. Check size: stat ~/Downloads/photo.jpg → 3.2MB (> 512KB)
2. Use script: bash "$SCRIPT" upload ~/Downloads/photo.jpg
3. Report URL: https://assets.yesy.site/f/images/2026/02/xxx.png
```

### Example 2: User uploads a small SVG

```
User: "Upload this icon to assets"

1. Check size: 15KB (< 512KB)
2. Use MCP: upload_file(filename="icon.svg", content=base64_content)
3. Report URL: https://assets.yesy.site/f/images/2026/02/yyy.svg
```

### Example 3: User wants to see all their videos

```
User: "What videos do I have in storage?"

1. Use MCP: list_files(type="videos")
   OR Script: bash "$SCRIPT" list --type videos
2. Display results with URLs
```

---

## REST API Reference

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/upload` | POST | Upload file (multipart/form-data, field: `file`) |
| `/api/list` | GET | List files (query: `type`, `year`, `month`) |
| `/api/delete/:key` | DELETE | Delete file by full key path |
| `/f/:key` | GET | Direct file access (public URL, cached 1 year) |

Full API docs: https://assets.yesy.site/docs

---

## Version History

- **1.0.0** (2026-02-26): Initial release
  - Smart routing: MCP (< 512KB) vs REST API (>= 512KB)
  - Upload, list, delete, info operations
  - Script `cf-assets.sh` for REST API access
