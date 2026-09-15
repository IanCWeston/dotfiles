# dots

My dot files

## Fresh install

```sh
curl -fsSL https://raw.githubusercontent.com/IanCWeston/dotfiles/main/bootstrap.sh | bash
```

The script installs [mise](https://mise.jdx.dev) and then runs
`mise bootstrap --adopt <repo-url> --yes`, which clones this repo into
`~/.config/mise/`, treats the root `mise.toml` as the active config, and
applies all the bootstrap phases declared in it: base packages, git repos,
dotfile symlinks, shell activation, and login shell.

Re-run from the adopted config (after first install, the repo IS
`~/.config/mise/`):

```sh
cd ~/.config/mise && mise bootstrap --yes
```

`bootstrap.sh --offline` skips the network phases (packages, repos, tools)
but still applies dotfiles, shell activation, and `chsh`.

## Layout

```
.
├── mise.toml            # bootstrap config + [tools] + [settings]
├── mise.lock            # tool version lockfile
├── conf.d/              # additional [tools] entries (loaded by mise)
├── bootstrap.sh         # thin wrapper (installs mise, runs `mise bootstrap --adopt`)
├── .zshenv              # deployed to ~/.zshenv via [dotfiles]
└── xdg_config/          # other app dotfiles, deployed via [dotfiles]
    ├── atuin/
    ├── git/
    ├── k9s/
    ├── lazygit/
    ├── nvim/
    ├── ohmyposh/
    ├── sesh/
    ├── starship.toml
    ├── tmux/
    ├── wezterm/
    ├── yamllint/
    └── zsh/
```

## WSL notes

The wezterm config is only deployed on macOS (via `variants.os = "macos"`
on the dotfile entry). On WSL, install your wezterm config on the Windows
side at `%APPDATA%\wezterm\`. If using oh-my-posh, install a Nerd Font on
Windows.
