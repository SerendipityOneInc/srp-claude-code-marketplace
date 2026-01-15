# SRP Claude Code Marketplace

Internal marketplace for discovering and sharing Claude Code plugins and MCP servers within SRP.

## Installation

Add this marketplace to Claude Code:

```bash
/plugin marketplace add SerendipityOneInc/srp-claude-code-marketplace
```

## Available Plugins

### Example Hello World

**Description:** Example plugin demonstrating basic Claude Code skill structure

**Categories:** Example, Learning

**Install:**
```bash
/plugin install example-hello-world@srp-claude-code-marketplace
```

**Repository:** https://github.com/SerendipityOneInc/example-hello-world

---

## Contributing

We welcome contributions from all SRP developers! Here's how to add your plugin:

### Steps to Add a Plugin

1. **Create your Claude Code plugin** in a separate GitHub repository
   - Ensure it has proper `.claude-plugin/` directory structure
   - Include a plugin.json or skills/ directory
   - Add comprehensive README documentation

2. **Fork this marketplace repository**
   ```bash
   gh repo fork SerendipityOneInc/srp-claude-code-marketplace
   ```

3. **Add your plugin entry** to `.claude-plugin/marketplace.json`
   ```json
   {
     "name": "your-plugin-name",
     "source": {
       "source": "url",
       "url": "https://github.com/SerendipityOneInc/your-plugin-repo.git"
     },
     "description": "Brief description of what your plugin does",
     "version": "1.0.0",
     "strict": true
   }
   ```

4. **Submit a pull request**
   - CI will automatically validate your plugin entry
   - A team member will review and merge

### Plugin Requirements

- Must be a valid Claude Code plugin with `.claude-plugin/` structure
- Must be in a Git repository (GitHub recommended)
- Must use semantic versioning (e.g., 1.0.0)
- Must include a clear description
- Plugin name must be unique in the marketplace

### CI Validation

Our automated checks verify:
- ✅ Valid JSON syntax
- ✅ Required fields present (name, source, description, version, strict)
- ✅ Semantic version format
- ✅ No duplicate plugin names
- ✅ GitHub repository exists and is accessible
- ⚠️ Target repo has `.claude-plugin/` directory (warning only)

## Marketplace Structure

```
srp-claude-code-marketplace/
├── .claude-plugin/
│   └── marketplace.json       # Plugin catalog
├── .github/
│   └── workflows/
│       └── validate-pr.yml    # CI validation
├── README.md                  # This file
└── LICENSE                    # MIT License
```

## Resources

- **Creating Plugins:** [Claude Code Plugin Development Guide](https://docs.anthropic.com/claude-code)
- **Issues:** https://github.com/SerendipityOneInc/srp-claude-code-marketplace/issues
- **Design Document:** [docs/plans/2026-01-15-srp-claude-code-marketplace-design.md](docs/plans/2026-01-15-srp-claude-code-marketplace-design.md)
- **Linear Issue:** [INF-341](https://linear.app/srp/issue/INF-341)

## Support

For questions or help:
- Open an issue in this repository
- Contact the Infrastructure team
- Check #infrastructure channel in Slack

## License

MIT License - See LICENSE file for details

Individual plugins maintain their own licenses.
