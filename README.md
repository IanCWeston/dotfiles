# dots

My dot files

## Fresh install

```sh
curl -fsSL https://raw.githubusercontent.com/IanCWeston/dotfiles/main/bootstrap.sh | bash
```

The script installs [mise](https://mise.jdx.dev) and then runs `mise bootstrap --adopt <repo-url> --yes`, which clones my mise-config repo into `~/.config/mise/`, and applies all the bootstrap phases declared in it: base packages, git repos, dotfile symlinks, shell activation, and login shell.

Re-run from the adopted config
```sh
cd ~/.config/mise && mise bootstrap --yes
```

`bootstrap.sh --offline` skips the network phases (packages, repos, tools)
but still applies dotfiles, shell activation, and `chsh`.

