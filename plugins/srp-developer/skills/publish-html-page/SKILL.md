---
name: publish-html-page
description: Publish HTML pages with optimized asset handling - uploads images/media to R2 first, then publishes lightweight HTML to Cloudflare Pages
---

# Publish HTML Page

Publish HTML pages to Cloudflare Pages with an **asset-first workflow**: images and media are uploaded to R2 storage (cf-assets) first, then the HTML references them via URLs instead of embedding base64 data. This keeps pages lightweight and fast.

## When to Use This Skill

- User asks to "create/publish/deploy an HTML page"
- User asks to "make a web page" or "build a landing page"
- User wants to publish HTML content (reports, games, dashboards, portfolios, etc.)
- User mentions `page.yesy.site` or publishing to pages

## When NOT to Use This Skill

- Uploading standalone files (images, videos, PDFs) without an HTML page — use `cloudflare-assets` skill
- Deploying full web applications with build steps — use `cloudflare-pages` skill
- Editing existing code projects — use standard development workflow

---

## Architecture

```
                    ┌─────────────────┐
                    │   AI generates  │
                    │   HTML + assets │
                    └────────┬────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
              ▼              ▼              ▼
        ┌──────────┐  ┌──────────┐  ┌──────────┐
        │  Images  │  │  Videos  │  │  SVG/CSS  │
        │  (png,   │  │  (mp4,   │  │  (inline  │
        │  jpg...) │  │  webm)   │  │  is OK)   │
        └────┬─────┘  └────┬─────┘  └─────┬─────┘
             │              │              │
             ▼              ▼              │
     ┌───────────────────────────┐         │
     │   cf-assets (R2 Storage)  │         │
     │   assets.yesy.site        │         │
     │   → returns public URLs   │         │
     └────────────┬──────────────┘         │
                  │                        │
                  ▼                        ▼
          ┌─────────────────────────────────────┐
          │   HTML with URL references          │
          │   (lightweight, no base64 blobs)    │
          └──────────────┬──────────────────────┘
                         │
                         ▼
              ┌──────────────────────┐
              │  cf-page-publish-mcp │
              │  page.yesy.site      │
              │  (KV Storage)        │
              └──────────────────────┘
```

---

## Workflow (MANDATORY)

### Step 0: Design Phase (if needed)

If the page requires custom visual assets (hero images, illustrations, icons, graphics):

1. **Check if `canvas-design` skill is available**
2. **If available**: Use it to generate images, then continue to Step 1
3. **If not available**: Ask the user:
   > "This page would benefit from custom graphics. Would you like to install the `canvas-design` skill for image generation? You can install it with: `/install-skill canvas-design`"
4. **If user declines**: Use SVG graphics, CSS art, emoji, or stock image URLs instead

Other image generation skills like `nano-banana` or `gpt-image-1-5` can also be used if available.

### Step 1: Analyze Content

Before writing any HTML, identify all media assets the page will need:

- **Binary images** (PNG, JPG, WebP, GIF) → MUST upload to cf-assets
- **Videos** (MP4, WebM) → MUST upload to cf-assets
- **SVG graphics** → CAN inline directly in HTML (small, text-based)
- **CSS/fonts** → SHOULD inline in `<style>` tags or use CDN links
- **Icons** → Prefer SVG inline, emoji, or CDN icon libraries

**Rule: Any base64-encoded binary content > 1KB should go to cf-assets.**

### Step 2: Upload Assets to cf-assets

Use the `cloudflare-assets` skill for smart upload routing:

- **File < 512KB** → MCP tool `upload_file` (base64, fast)
- **File >= 512KB** → Script `cf-assets.sh upload` (REST API, no base64 overhead)

**Small file (< 512KB) — MCP:**

```
Tool: mcp__plugin_srp-developer_cloudflare-assets__upload_file
Args:
  filename: "icon.svg"
  content: "<base64-encoded content>"
```

**Large file (>= 512KB) — Script:**

```bash
SCRIPT=$(find ~/.claude/plugins/cache/srp-claude-code-marketplace/srp-developer -name "cf-assets.sh" -type f 2>/dev/null | head -1)
bash "$SCRIPT" upload /path/to/hero-banner.png
```

Both return: `{"state":true,"data":{"url":"https://assets.yesy.site/f/images/2026/02/abc12345.png",...}}`

**Tips:**
- Upload all assets in parallel when possible
- Note down each returned URL for use in HTML
- Filenames are for type detection only — the actual key is auto-generated
- For generated images (nano-banana, etc.), always use script — they're typically > 512KB

### Step 3: Build HTML with URLs

Construct the HTML page using the returned asset URLs:

```html
<!-- GOOD: Reference uploaded asset URL -->
<img src="https://assets.yesy.site/f/images/2026/02/abc12345.png" alt="Hero">

<!-- GOOD: Inline SVG (small, text-based) -->
<svg viewBox="0 0 24 24"><path d="..."/></svg>

<!-- GOOD: CDN resources -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/...">

<!-- BAD: Inline base64 binary (bloats HTML) -->
<img src="data:image/png;base64,iVBORw0KGgo...very long string...">
```

### Step 4: Publish HTML Page

Publish the lightweight HTML:

```
Tool: mcp__plugin_srp-developer_cloudflare-pages________
Args:
  pagetitle: "Page Title"
  pagehtml: "<complete HTML content>"

Returns: URL like https://page.yesy.site/pages/{key}
```

### Step 5: Verify & Report

Report to the user:
- Published page URL
- List of uploaded assets (with URLs)
- Page size comparison (if relevant)

---

## MCP Tools Reference

### cloudflare-assets (assets.yesy.site)

| Tool | Description |
|------|-------------|
| `mcp__plugin_srp-developer_cloudflare-assets__upload_file` | Upload file (base64) → returns public URL |
| `mcp__plugin_srp-developer_cloudflare-assets__list_files` | List files, filter by type/year/month |
| `mcp__plugin_srp-developer_cloudflare-assets__delete_file` | Delete file by key |

**Upload file parameters:**
- `filename` (string): Filename with extension, e.g. `photo.png` — used for type categorization
- `content` (string): Base64-encoded file content

**File categories** (auto-detected from extension):
- `images/` — png, jpg, jpeg, gif, webp, svg, ico, bmp, tiff
- `videos/` — mp4, webm, mov, avi, mkv
- `web/` — html, css, js
- `documents/` — pdf, doc, docx, xls, xlsx, ppt, pptx, txt, csv, md
- `other/` — everything else

### cloudflare-pages (page.yesy.site)

| Tool | Description |
|------|-------------|
| `mcp__plugin_srp-developer_cloudflare-pages________` | Create HTML page → returns page URL |

**Parameters:**
- `pagetitle` (string): Page title
- `pagehtml` (string): Complete HTML content

---

## Examples

### Example 1: Simple Text Page (no assets needed)

**User**: "Create a page showing today's meeting notes"

**Flow**: No images → skip asset upload → publish directly

```
1. Build HTML with meeting notes content
2. Publish via cloudflare-pages
3. Return page URL
```

### Example 2: Landing Page with Images

**User**: "Create a product landing page for our new app"

**Flow**:

```
1. [Design] Generate hero image and product screenshots
   → Use canvas-design / nano-banana skill if available
   → Save as PNG files

2. [Upload] Upload images to cf-assets
   → hero.png → https://assets.yesy.site/f/images/2026/02/xxx.png
   → screenshot1.png → https://assets.yesy.site/f/images/2026/02/yyy.png

3. [Build] Create HTML referencing asset URLs
   <img src="https://assets.yesy.site/f/images/2026/02/xxx.png" alt="Hero">

4. [Publish] Publish to cloudflare-pages
   → https://page.yesy.site/pages/ProductLandingAbcDefGh
```

### Example 3: Interactive Game

**User**: "Create a 2048 game and publish it"

**Flow**: Pure CSS/JS game → no binary assets → publish directly

```
1. Build complete HTML with inline CSS and JavaScript
2. Publish via cloudflare-pages (single HTML, no external assets)
3. Return page URL
```

### Example 4: Data Dashboard with Charts

**User**: "Create a dashboard showing our sales data"

**Flow**: Charts via JS library (Chart.js CDN) + maybe a logo image

```
1. [Upload] Upload company logo to cf-assets (if provided)
2. [Build] HTML with:
   - Chart.js from CDN
   - Logo from cf-assets URL
   - Data inline in <script>
3. [Publish] Publish to cloudflare-pages
```

---

## Decision Tree: Inline vs Upload

```
Is it binary (PNG, JPG, MP4, etc.)?
├── YES → Upload to cf-assets
└── NO
    ├── Is it SVG < 5KB? → Inline in HTML
    ├── Is it CSS? → Inline in <style> or use CDN
    ├── Is it JS? → Inline in <script> or use CDN
    └── Is it a font? → Use CDN (Google Fonts, etc.)
```

---

## Important Notes

- **Always upload binary assets first** before building the HTML — you need the URLs
- **Parallel uploads**: When multiple assets need uploading, call upload_file for each in parallel
- **SVG is special**: Small SVGs can inline directly; large/complex SVGs should upload to cf-assets
- **CDN preference**: For common libraries (jQuery, Chart.js, Tailwind), use CDN links rather than uploading
- **Page size target**: Aim for HTML < 500KB after asset extraction. If larger, check for missed base64 blobs
- **No auth needed**: Both services are protected by Cloudflare Zero Trust at the network level

---

## Version History

- **1.1.0** (2026-02-26): Smart upload routing
  - Upload now uses `cloudflare-assets` skill with size-based routing
  - Files < 512KB → MCP; files >= 512KB → REST API via script
  - Added reference to `cf-assets.sh` script for large file uploads
- **1.0.0** (2026-02-26): Initial skill release
  - Asset-first workflow for HTML page publishing
  - Integration with cf-assets (R2) and cf-page-publish-mcp (KV)
  - Design phase with canvas-design skill integration
  - Decision tree for inline vs upload
