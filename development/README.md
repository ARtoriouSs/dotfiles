# development

Tools and settings for development, mostly Ruby and AI agents.

| File                             | What it does                                                                         |
|----------------------------------|--------------------------------------------------------------------------------------|
| [helpers.sh](helpers.sh)         | Aliases and functions for Rails, Elixir, Docker, Redis, Postgres and Claude           |
| [.pryrc](.pryrc)                 | Pry config. Linked to `~/.pryrc`                                                     |
| [.gemrc](.gemrc)                 | Gem config, no docs on install. Linked to `~/.gemrc`                                 |
| [default-gems](default-gems)     | Gems installed with every new rbenv Ruby. Linked to `~/.rbenv/default-gems`          |
| [claude](claude)                 | Claude Code settings for the `work` and `personal` profiles and the shared statusline |

## Project commands

`server` (`rs`), `spec`, `console` (`rc`), `migrate`, `rollback` and `deps` pick the right command for the project.
The language is read from `.git/safe/current_language` (`ruby` when missing), set it with `current-language-edit`.

For non-Rails projects `server`, `spec` and `console` load `.env` with `with-dotenv`: it runs in a subshell,
so nothing stays in your shell, and exported variables win over `.env`, e.g. `FOO=bar spec`.

## Claude Code profiles

`claude-work` and `claude-personal` start Claude with `~/.claude-work` or `~/.claude-personal` as the config directory.
Both get their `settings.json` and `statusline.sh` linked from [claude](claude), and share the global `CLAUDE.md`
from `~/.claude` (edit it with `claude-md`). Plain `claude` uses `~/.claude` with the work settings.
