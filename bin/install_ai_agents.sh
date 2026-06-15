#!/bin/bash

# install and configure AI coding agents: Claude Code, Codex and Gemini.

### Claude Code
npm install -g @anthropic-ai/claude-code
# oh-my-claudecode (OMC) - multi-agent orchestration layer
claude plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode.git
claude plugin install oh-my-claudecode@omc
# ruby-lsp - Ruby language server integration
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin install ruby-lsp@claude-plugins-official
# find-skills - browse/search skills across marketplaces
claude plugin marketplace add dan323/easier-life-skills
claude plugin install find-skills@easier-life-skills

### Codex
npm install -g @openai/codex

### Gemini
npm install -g @google/gemini-cli@latest

### Token-reduction tooling
# rtk - Rust Token Killer: CLI proxy that compresses dev command output
cargo install --git https://github.com/rtk-ai/rtk
rtk init -g --auto-patch                                           # Claude Code hook (non-interactive)
rtk init -g --codex --auto-patch                                   # Codex
rtk init -g --gemini --auto-patch                                  # Gemini
# caveman - token-efficient skills/prompt compression
npm install -g @juliusbrussee/caveman-code
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman                              # Claude Code
npx -y skills add JuliusBrussee/caveman -a codex                   # Codex
gemini extensions install https://github.com/JuliusBrussee/caveman # Gemini
