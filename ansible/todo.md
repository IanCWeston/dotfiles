# Todo for Ansible config

## Ideas

- [Install github cli](https://github.com/cli/cli/blob/trunk/docs/install_linux.md#debian-ubuntu-linux-raspberry-pi-os-apt) and then use gh to download latest binaries

Go Binaries

```
gh release download  -R { repo_owner }/{ repo_name } -p '*inux*[^am,x86]64*'
```

Rust Binaries

```
gh release download  -R { repo_owner }/{ repo_name } -p '*x86_64*linux*'
```
