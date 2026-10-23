# system

Shell and desktop configuration.

| File                                               | What it does                                                                  |
|----------------------------------------------------|-------------------------------------------------------------------------------|
| [.zprofile](.zprofile)                             | Login shell entry, loads `environment.sh`. Linked to `~/.zprofile`            |
| [.zshrc](.zshrc)                                   | Oh My Zsh with plugins, key bindings, loads `initializer.sh`. Linked to `~/.zshrc` |
| [environment.sh](environment.sh)                   | `PATH` and environment variables, rbenv, kiex and cargo setup                 |
| [initializer.sh](initializer.sh)                   | Sources the helpers of every directory, then `temp_settings.sh`               |
| [helpers.sh](helpers.sh)                           | General aliases and functions: navigation, clipboard, proxy, display scaling |
| [temp_settings.sample.sh](temp_settings.sample.sh) | Template for the private `temp_settings.sh` (current project, email, proxy)   |
| [.agignore](.agignore)                             | Ignore list for `ag`. Linked to `~/.agignore`                                 |
| [autostart](autostart)                             | Desktop autostart entries, linked by hand (see `bin/configure_system.sh`)     |

`temp_settings.sh` is not committed. Put things there that are private or change often,
for example `CURRENT_PROJECT`, which the `cdc`, `cd1`, `tc` and similar aliases use.

Run `reload` after changing any of these files.
