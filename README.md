# dots

My dot files

## Fresh install

```sh
curl -fsSL https://raw.githubusercontent.com/IanCWeston/dotfiles/main/bootstrap.sh | bash -s -- --profile personal
```

The script installs [mise](https://mise.jdx.dev), adopts my mise-config repo
into `~/.config/mise/`, and applies its bootstrap configuration for the
selected profile. The profile defaults to `personal`; use `--profile work` on a
work machine. Shared dotfiles and terminal tooling are applied in either
profile, while profile-specific tools and user settings follow the selected
environment. To bootstrap the system without installing any mise-managed
tools, add `--skip-tools`; tools can be installed later with `mise install`.

```sh
curl -fsSL https://raw.githubusercontent.com/IanCWeston/dotfiles/main/bootstrap.sh | bash -s -- --profile work --skip-tools
```

Re-run from the adopted config:
```sh
cd ~/.config/mise && mise -E personal bootstrap --yes
```

Skip tools during a later bootstrap directly with mise:
```sh
mise -E work bootstrap --yes --skip tools
```

For an offline re-run, mise and the config repo must already be present locally:
```sh
./bootstrap.sh --offline --profile work
```

Offline mode sets `MISE_OFFLINE=1` and skips package, repository, and tool
installation phases. It still applies available local dotfiles and profile
settings; it does not install mise, update apt metadata, clone repositories, or
download tools.
