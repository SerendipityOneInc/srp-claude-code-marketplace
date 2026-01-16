# Example Hello World Plugin

A minimal example Claude Code plugin demonstrating basic skill structure. Part of the [SRP Claude Code Marketplace](https://github.com/SerendipityOneInc/srp-claude-code-marketplace).

## What This Demonstrates

This plugin shows:
- ✅ Proper `.claude-plugin/` directory structure
- ✅ Plugin metadata in `plugin.json`
- ✅ Correct skill file organization
- ✅ Skill discovery (auto-discovered from skills/ directory)
- ✅ Documentation best practices
- ✅ Monorepo plugin structure

## Installation

### Via SRP Marketplace
```bash
/plugin marketplace add SerendipityOneInc/srp-claude-code-marketplace
/plugin install example-hello-world@srp-claude-code-marketplace
```

## Usage

Once installed, invoke the skill:
```bash
/hello-world
```

Claude will demonstrate the basic skill structure and explain key concepts.

## Plugin Structure

```
example-hello-world/
├── .claude-plugin/
│   └── plugin.json               # Plugin metadata (NO skills field!)
├── skills/
│   └── hello-world/              # Skill directory
│       └── SKILL.md              # Skill definition (must be SKILL.md)
└── README.md                     # This file
```

**Key Points:**
- Each skill gets its own subdirectory under `skills/`
- The skill file must be named `SKILL.md` (uppercase)
- Skills are auto-discovered; no need to register in plugin.json
- The directory name becomes the skill invocation name

## Creating Your Own Plugin

Use this as a template:

1. **Create plugin directory in marketplace:**
   ```bash
   cd srp-claude-code-marketplace/plugins
   mkdir -p my-plugin/.claude-plugin
   mkdir -p my-plugin/skills/my-skill
   ```

2. **Add plugin.json** (metadata only):
   ```json
   {
     "name": "my-plugin",
     "version": "1.0.0",
     "description": "Your plugin description",
     "author": {
       "name": "Your Name",
       "email": "your.email@srp.one"
     },
     "license": "MIT",
     "keywords": ["skill", "category"]
   }
   ```
   
   **Note:** Do NOT include a `skills` field! Skills are auto-discovered.

3. **Create skill file** (skills/my-skill/SKILL.md):
   ```markdown
   ---
   name: my-skill
   description: Brief description
   ---

   # My Skill

   ## Instructions
   
   Your skill instructions here...
   ```

4. **Add to marketplace.json:**
   ```json
   {
     "name": "my-plugin",
     "source": "./plugins/my-plugin",
     "description": "Your plugin description",
     "version": "1.0.0",
     "strict": true
   }
   ```

5. **Test and submit PR:**
   - Test the plugin locally
   - Submit PR to marketplace repository
   - CI will validate automatically

## Common Mistakes to Avoid

❌ **Don't:** Include `skills` field in plugin.json  
✅ **Do:** Let skills auto-discover from skills/ directory

❌ **Don't:** Name skill file `skill.md` or `my-skill.md`  
✅ **Do:** Name it `SKILL.md` (uppercase)

❌ **Don't:** Put skill files directly in skills/ (e.g., skills/my-skill.md)  
✅ **Do:** Create subdirectory first (skills/my-skill/SKILL.md)

## Resources

- [SRP Marketplace](https://github.com/SerendipityOneInc/srp-claude-code-marketplace)
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Anthropic Official Marketplace](https://github.com/anthropics/claude-code/tree/main/plugins)

## License

MIT License - See [LICENSE](../../LICENSE)
