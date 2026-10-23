#!/bin/bash
set -o pipefail # a pipeline fails when any command in it fails, not only the last one

# install and configure AI coding agents: Claude Code, Codex, Gemini and Copilot.

# native addons that npm builds or downloads in install scripts, newer npm skips scripts that are not listed
npm_allow_scripts=better-sqlite3,onnxruntime-node,koffi,protobufjs,node-pty,@lydell/node-pty,@github/keytar,@google/genai

### Codex, Gemini and Copilot, first so the caveman setup below can use gemini
npm install -g --allow-scripts=$npm_allow_scripts @openai/codex @google/gemini-cli@latest @github/copilot

### Claude Code
# native install (not npm) - drops binary in ~/.local/bin
# plugins are installed from enabledPlugins/extraKnownMarketplaces in development/claude/settings.json
# lavish - standalone skill (not a plugin, so not covered by settings.json)
npx -y skills add kunchenguid/lavish-axi --skill lavish -g -a claude-code -y
curl -fsSL https://claude.ai/install.sh | bash

### Token-reduction tooling
# rtk - Rust Token Killer: CLI proxy that compresses dev command output
cargo install --git https://github.com/rtk-ai/rtk
rtk init -g --auto-patch                                           # Claude Code hook (non-interactive)
rtk init -g --codex --auto-patch                                   # Codex
rtk init -g --gemini --auto-patch                                  # Gemini
# caveman - token-efficient skills/prompt compression
npm install -g --allow-scripts=$npm_allow_scripts @juliusbrussee/caveman-code
npx -y skills add JuliusBrussee/caveman -a codex                   # Codex
gemini extensions install --consent https://github.com/JuliusBrussee/caveman # Gemini

### Agent workflow
# workmux - git worktrees + tmux windows for running agents in parallel
curl -fsSL https://raw.githubusercontent.com/raine/workmux/main/scripts/install.sh | bash
# zsh completions (oh-my-zsh adds custom/completions to fpath)
mkdir -p ~/.oh-my-zsh/custom/completions
workmux completions zsh > ~/.oh-my-zsh/custom/completions/_workmux
# global config
mkdir -p ~/.config/workmux
ln -sf ~/dotfiles/tmux/workmux/config.yaml ~/.config/workmux/config.yaml
# Claude status hooks come from the workmux-status plugin in development/claude/settings.json

### Claude Code config
# two profiles, picked with CLAUDE_CONFIG_DIR (see claude-work/claude-personal in development/helpers.sh)
# plain ~/.claude is used by `claude` without the alias and gets the work settings
# MCP servers - work only
CLAUDE_CONFIG_DIR=~/.claude-work claude mcp add --scope user --transport http atlassian https://mcp.atlassian.com/v1/mcp
# settings and statusline - linked last so they override anything the installers above patched in
link_claude_profile() {
  local config_dir=$1 profile=$2
  mkdir -p "$config_dir"
  ln -sf ~/dotfiles/development/claude/"$profile"/settings.json "$config_dir"/settings.json
  ln -sf ~/dotfiles/development/claude/statusline.sh "$config_dir"/statusline.sh
  # rtk init writes global instructions only to ~/.claude, so share them with other profiles
  if [ "$config_dir" != ~/.claude ]; then
    ln -sf ~/.claude/CLAUDE.md "$config_dir"/CLAUDE.md
    ln -sf ~/.claude/RTK.md "$config_dir"/RTK.md
  fi
}
link_claude_profile ~/.claude work
link_claude_profile ~/.claude-work work
link_claude_profile ~/.claude-personal personal
