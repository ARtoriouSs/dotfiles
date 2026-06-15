#!/bin/bash

# install and configure AI coding agents: Claude Code, Codex and Gemini.
# Codex and Gemini are left stock; Claude additionally gets oh-my-claudecode.
# A final section installs token-reduction tooling (rtk, caveman) for all agents.
# Assumes node/npm and cargo (rust) are present (see install_cli.sh).

### Claude Code ###
npm install -g @anthropic-ai/claude-code
# oh-my-claudecode (OMC) - multi-agent orchestration layer
claude plugin marketplace add https://github.com/Yeachan-Heo/oh-my-claudecode.git
claude plugin install oh-my-claudecode@omc

### Codex (stock) ###
npm install -g @openai/codex

### Gemini (stock) ###
npm install -g @google/gemini-cli@latest

### Token-reduction tooling (applied to all agents) ###

# rtk - Rust Token Killer: CLI proxy that compresses dev command output
cargo install --git https://github.com/rtk-ai/rtk
rtk init -g --auto-patch           # Claude Code hook (non-interactive)
rtk init -g --codex --auto-patch   # Codex
rtk init -g --gemini --auto-patch  # Gemini

# caveman - token-efficient skills/prompt compression
npm install -g @juliusbrussee/caveman-code
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman                              # Claude Code
npx -y skills add JuliusBrussee/caveman -a codex                   # Codex
gemini extensions install https://github.com/JuliusBrussee/caveman # Gemini
