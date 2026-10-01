#!/bin/bash

# install and configure AI coding agents: Claude Code, Codex and Gemini.

### Claude Code
# native install (not npm) - drops binary in ~/.local/bin
# plugins are installed from enabledPlugins/extraKnownMarketplaces in development/claude/settings.json
curl -fsSL https://claude.ai/install.sh | bash

### Token-reduction tooling
# rtk - Rust Token Killer: CLI proxy that compresses dev command output
cargo install --git https://github.com/rtk-ai/rtk
rtk init -g --auto-patch                                           # Claude Code hook (non-interactive)
rtk init -g --codex --auto-patch                                   # Codex
rtk init -g --gemini --auto-patch                                  # Gemini
# caveman - token-efficient skills/prompt compression
npm install -g @juliusbrussee/caveman-code
npx -y skills add JuliusBrussee/caveman -a codex                   # Codex
gemini extensions install https://github.com/JuliusBrussee/caveman # Gemini

### Claude Code config
# MCP servers
claude mcp add --scope user --transport http atlassian https://mcp.atlassian.com/v1/mcp
# settings - linked last so it overrides anything the installers above patched in
mkdir -p ~/.claude
ln -sf ~/dotfiles/development/claude/settings.json ~/.claude/settings.json

### Codex
npm install -g @openai/codex

### Gemini
npm install -g @google/gemini-cli@latest
