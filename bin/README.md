# bin

Scripts to set up a fresh system. [prepare.sh](prepare.sh) runs most of them in the right order,
each one also works on its own.

| Script                                           | What it does                                                                 |
|--------------------------------------------------|------------------------------------------------------------------------------|
| [prepare.sh](prepare.sh)                         | Runs everything below (except the optional ones), prints the manual steps and runs the healthcheck |
| [create_dir_tree.sh](create_dir_tree.sh)         | Creates `~/my_folder` with projects, bin and media directories               |
| [install_cli.sh](install_cli.sh)                 | CLI tools, languages, Docker, Postgres, Redis, gh/glab, gitleaks             |
| [install_gui.sh](install_gui.sh)                 | Chrome, Telegram, Slack, Discord, Insomnia, Postman                          |
| [configure_system.sh](configure_system.sh)       | Fonts, keyboard repeat speed, optional display scaling                       |
| [install_rbenv.sh](install_rbenv.sh)             | rbenv with ruby-build and default gems                                       |
| [install_zsh.sh](install_zsh.sh)                 | Zsh, Oh My Zsh, the theme and plugins                                        |
| [install_vim.sh](install_vim.sh)                 | Neovim from the official release and its plugins from the lockfile          |
| [install_ai_agents.sh](install_ai_agents.sh)     | Claude Code, Codex, Gemini, Copilot, rtk, caveman, workmux, Claude profiles  |
| [create_symlinks.sh](create_symlinks.sh)         | Links git, tmux and Ruby tool configs to the home directory                  |
| [install_gitleaks.sh](install_gitleaks.sh)       | gitleaks from the GitHub release with a checksum check, used by `install_cli.sh` and CI |
| [healthcheck.sh](healthcheck.sh)                 | Checks programs, dotfile links and the shell, exits with 1 on a problem      |
| [test.sh](test.sh)                               | Starts the Docker sandbox from the [Dockerfile](../Dockerfile)               |

Optional, run by hand when needed:

| Script                                           | What it does                                                                 |
|--------------------------------------------------|------------------------------------------------------------------------------|
| [add_ssh.sh](add_ssh.sh)                         | Creates an ed25519 SSH key, adds it to the agent and copies the public key   |
| [enable_snap.sh](enable_snap.sh)                 | Enables snap, Linux Mint blocks it by default                                |
| [disable_snap.sh](disable_snap.sh)               | Removes snap and blocks it again                                             |
| [bootstrap_frogswamp.sh](bootstrap_frogswamp.sh) | Prepares this PC to manage the frogswamp home server, safe to run again      |

Scripts don't stop on errors, but a pipeline fails when any of its commands fails (`pipefail`).
The healthcheck at the end of `prepare.sh` shows what is missing.

Node lives in `~/.n` (managed by `n`), so global npm packages don't need sudo, and `/usr/local` stays owned by root.
