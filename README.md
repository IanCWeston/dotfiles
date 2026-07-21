# Dotfiles
My dot files, managed via [mise](https://mise.jdx.dev/)

## Installing

```sh
# 1. Install mise
curl https://mise.run | sh

# 2. Install git if not already present (distro-dependent)
sudo apt install -y git   # or: sudo dnf install -y git

# 3. Clone dotfiles and run bootstrap
git clone https://github.com/IanCWeston/dotfiles.git ~/.dotfiles
mise trust
mise bootstrap --yes
```
