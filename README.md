# SRP Claude Code Marketplace

Internal marketplace for discovering and sharing Claude Code plugins and MCP servers within SRP.

**Architecture:** Monorepo - all plugins live in the `plugins/` directory of this repository.

## Installation

Add this marketplace to Claude Code:

```bash
/plugin marketplace add SerendipityOneInc/srp-claude-code-marketplace
```

## Available Plugins

### SRP AllStaff

**Description:** Lark/Feishu integration and office automation platform with Rube - access documents, messages, and automate workflows across Gmail, Slack, Calendar, Drive, GitHub, Linear, and more

**Categories:** Productivity, Integration, Communication, Automation

**Install:**
```bash
/plugin install srp-allstaff@srp-claude-code-marketplace
```

**Skills:** `/lark-docs`, `/lark-messages`

**Commands:** `srp:docs`, `srp:msg`

**Key Features:**
- Lark/Feishu: Documents, wiki, messages, notifications
- Rube Automation: Gmail, Slack, Google Calendar, Drive
- Project Management: GitHub, Linear, Notion
- Communication: WhatsApp, Twitter, PagerDuty

**Location:** [plugins/srp-allstaff](plugins/srp-allstaff)

---

### SRP Developer

**Description:** Developer plugin providing GitHub integration, GCP BigQuery access, Cloudflare edge computing & storage services, Ray Data processing, Slurm cluster management, and development tools

**Categories:** Development, GitHub, GCP, Cloudflare, Edge Computing, HPC, ML Infrastructure

**Install:**
```bash
/plugin install srp-developer@srp-claude-code-marketplace
```

**Skills:** `/github-integration`, `/gcp-developer`, `/cloudflare-workers`, `/cloudflare-pages`, `/cloudflare-r2`, `/cloudflare-kv`, `/raydata`, `/slurm`

**Commands:** `srp:github`, `srp:gcp`, `srp:gh`, `srp:bq`, `srp:workers`, `srp:pages`, `srp:r2`, `srp:kv`, `srp:raydata`, `srp:slurm`

**Key Features:**
- GitHub: Code review, PR management, issue tracking
- GCP: BigQuery data queries and analysis
- Cloudflare Workers: Serverless edge computing with Wrangler CLI
- Cloudflare Pages: JAMstack platform with Git integration
- Cloudflare R2: S3-compatible object storage with zero egress fees
- Cloudflare KV: Low-latency key-value storage at the edge
- Ray Data: Large-scale distributed data processing and batch inference
- Slurm: GPU cluster job submission and management (H100/H200)

**Location:** [plugins/srp-developer](plugins/srp-developer)

---

### SRP DevOps

**Description:** DevOps plugin providing Kubernetes management, cloud resource monitoring, and operations tools

**Categories:** DevOps, Kubernetes, Cloud, Operations

**Install:**
```bash
/plugin install srp-devops@srp-claude-code-marketplace
```

**Skills:** `/k8s-management`, `/cloud-resources`

**Commands:** `srp:k8s`, `srp:cloud`

**Location:** [plugins/srp-devops](plugins/srp-devops)

---

### Example Hello World

**Description:** Example plugin demonstrating basic Claude Code skill structure

**Categories:** Example, Learning

**Install:**
```bash
/plugin install example-hello-world@srp-claude-code-marketplace
```

**Skills:** `/hello-world`

**Location:** [plugins/example-hello-world](plugins/example-hello-world)

---

## Contributing

We welcome contributions from all SRP developers! Here's how to add your plugin:

### Steps to Add a Plugin

1. **Fork this marketplace repository**
   ```bash
   gh repo fork SerendipityOneInc/srp-claude-code-marketplace
   cd srp-claude-code-marketplace
   ```

2. **Create your plugin directory** in the `plugins/` folder
   ```bash
   mkdir -p plugins/your-plugin-name/.claude-plugin
   mkdir -p plugins/your-plugin-name/skills/your-skill
   ```

3. **Add plugin metadata** in `plugins/your-plugin-name/.claude-plugin/plugin.json`
   ```json
   {
     "name": "your-plugin-name",
     "version": "1.0.0",
     "description": "Brief description of your plugin",
     "author": {
       "name": "Your Name",
       "email": "your.email@srp.one"
     },
     "license": "MIT",
     "keywords": ["category1", "category2"]
   }
   ```
   
   **Important:** Do NOT include a `skills` field! Skills are auto-discovered from the `skills/` directory.

4. **Create your skill(s)** in `plugins/your-plugin-name/skills/skill-name/SKILL.md`
   ```markdown
   ---
   name: your-skill
   description: What this skill does
   ---

   # Your Skill

   ## Instructions
   
   Clear, step-by-step instructions for Claude...
   ```

5. **Add to marketplace catalog** in `.claude-plugin/marketplace.json`
   ```json
   {
     "name": "your-plugin-name",
     "source": "./plugins/your-plugin-name",
     "description": "Brief description of what your plugin does",
     "version": "1.0.0",
     "strict": true
   }
   ```

6. **Submit a pull request**
   - CI will automatically validate your plugin entry
   - A team member will review and merge

### Plugin Structure

Each plugin should follow this structure:

```
plugins/your-plugin-name/
├── .claude-plugin/
│   └── plugin.json               # Plugin metadata (NO skills field!)
├── skills/
│   └── your-skill/               # Skill directory
│       └── SKILL.md              # Skill definition (must be SKILL.md, uppercase)
├── README.md                     # Plugin documentation
└── LICENSE                       # Optional: plugin-specific license
```

**Key Points:**
- Each skill gets its own subdirectory under `skills/`
- The skill file MUST be named `SKILL.md` (uppercase)
- Skills are auto-discovered from `skills/` directory
- Do NOT include a `skills` array in plugin.json

### Plugin Requirements

- Must follow the `.claude-plugin/` structure
- Must include plugin.json with required fields (name, version, description, author)
- Skills must be in `skills/{skill-name}/SKILL.md` format
- Must use semantic versioning (e.g., 1.0.0)
- Plugin name must be unique in the marketplace
- Include comprehensive README documentation

### CI Validation

Our automated checks verify:
- ✅ Valid JSON syntax in marketplace.json
- ✅ Required fields present (name, source, description, version, strict)
- ✅ Semantic version format
- ✅ No duplicate plugin names
- ✅ Plugin directory exists at specified path
- ⚠️ Plugin has valid `.claude-plugin/` structure (warning only)

### Common Mistakes to Avoid

❌ **Don't:** Include `skills` field in plugin.json  
✅ **Do:** Let skills auto-discover from `skills/` directory

❌ **Don't:** Name skill file `skill.md` or `my-skill.md`  
✅ **Do:** Name it `SKILL.md` (uppercase)

❌ **Don't:** Put skill files directly in skills/ (e.g., `skills/my-skill.md`)  
✅ **Do:** Create subdirectory first (`skills/my-skill/SKILL.md`)

## Marketplace Structure

```
srp-claude-code-marketplace/
├── .claude-plugin/
│   └── marketplace.json           # Plugin catalog
├── .github/
│   └── workflows/
│       └── validate-pr.yml        # CI validation
├── plugins/                       # All plugins live here
│   ├── example-hello-world/       # Example plugin
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── skills/
│   │   │   └── hello-world/
│   │   │       └── SKILL.md
│   │   └── README.md
│   ├── srp-allstaff/              # SRP AllStaff plugin
│   │   └── ...
│   ├── srp-developer/             # SRP Developer plugin
│   │   └── ...
│   └── srp-devops/                # SRP DevOps plugin
│       └── ...
├── README.md                      # This file
└── LICENSE                        # MIT License
```

## Resources

- **Example Plugin:** [plugins/example-hello-world](plugins/example-hello-world) - Reference implementation
- **Creating Plugins:** [Claude Code Plugin Development Guide](https://docs.anthropic.com/claude-code)
- **Official Marketplace:** [Anthropic's Claude Code Plugins](https://github.com/anthropics/claude-code/tree/main/plugins)
- **Issues:** https://github.com/SerendipityOneInc/srp-claude-code-marketplace/issues
- **Design Document:** [docs/plans/2026-01-15-srp-claude-code-marketplace-design.md](docs/plans/2026-01-15-srp-claude-code-marketplace-design.md)
- **Linear Issue:** [INF-341](https://linear.app/srp/issue/INF-341)

## Support

For questions or help:
- Open an issue in this repository
- Check the [example-hello-world plugin](plugins/example-hello-world) for reference
- Contact the Infrastructure team (infra@srp.one)
- Check #infrastructure channel in Slack

## License

MIT License - See LICENSE file for details

Individual plugins may have their own licenses - check each plugin's directory.
