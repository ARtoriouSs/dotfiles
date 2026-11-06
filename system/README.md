# system

Shell and desktop configuration.

| File                                               | What it does                                                                  |
|----------------------------------------------------|-------------------------------------------------------------------------------|
| [.zprofile](.zprofile)                             | Login shell entry, loads `environment.sh`. Linked to `~/.zprofile`            |
| [.zshrc](.zshrc)                                   | Oh My Zsh with plugins, key bindings, loads `initializer.sh`. Linked to `~/.zshrc` |
| [environment.sh](environment.sh)                   | `PATH` and environment variables, rbenv, kiex and cargo setup                 |
| [initializer.sh](initializer.sh)                   | Sources the helpers of every directory, then the private files from `~/dotfiles-secret` |
| [helpers.sh](helpers.sh)                           | General aliases and functions: navigation, clipboard, proxy, display scaling |
| [.agignore](.agignore)                             | Ignore list for `ag`. Linked to `~/.agignore`                                 |
| [autostart](autostart)                             | Desktop autostart entries, linked by hand (see `bin/configure_system.sh`)     |

Private things and things that change often go to `private_settings.sh` in the private `dotfiles-secret` repo
(open it with `temps`), for example `CURRENT_PROJECT`, which the `cdc`, `cd1`, `tc` and similar aliases use.
The initializer sources its `helpers.sh`, `credentials.sh` and `private_settings.sh` when they exist.

Run `reload` after changing any of these files.
