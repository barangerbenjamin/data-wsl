Work in progress on the automation of LW DS Bootcamp

# Plan of action

## Automation

- [x] WSL prerequisites
- [x]  Utilities install
- [ ] WSL install
- [x] Shell utilities (vim, curl ...)
- [x] Oh-My-Zsh
- [x] Ssh key generation
- [x] Check effective connection
- [ ] Implement gh cli
- [x] Dotfiles install + git setup
- [x] Python install
- [ ] Python virtual env
- [x] Python packages
- [ ] Run all option
## Documentation
- [ ] Write how to use

# Installation

```bash
sudo apt update
sudo apt install -y dialog
cd ~
curl https://raw.githubusercontent.com/barangerbenjamin/data-wsl/master/setup.sh > setup.sh
curl https://raw.githubusercontent.com/barangerbenjamin/data-wsl/master/dialogrc > .dialogrc
sudo chmod +x setup.sh
./setup.sh
```

# Known issues on WSL

## Jupyter

To make Jupyter work by default it is necessary to deactivate windows defender on public network interface (WSL2 uses that!).

TODO => Add entries to whitelist WSL2 requests in Windows Defender.

Jupyter does not automatically opens a new tab in the default browser.

## SQLITE3

Using `pyenv` to install Python 3.7.7 seems to ship it with sqlite3 3.22.0
SQL Window Functions are only supported in SQLITE3 > 3.25.0

TODO => Find a work around

Jupyter might support Python 3.8 by then and the problem will be no more

EDIT: Fixed by using Python 3.8.5 for the new setup!

## Matplotlib in python file

Getting the following error *qt.qpa.screen: QXcbConnection: Could not connect to display 172.27.48.1:0
Could not connect to any X display.* instead of seeing a new window with the graph

**FIX**

Install Xming.

add `export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0` to `~/.zshrc`.

Start xming with `-ac` additional parameters.

Add entry for Xming in Windows Defender

## Running code from VsCode

VsCode `Ctrl + F5` equivalent to Sublime `Cmd + B` get a *connection refused*.

Fix is same as above with Xming.

Need entries for VsCode in Windows Defender.

Need to hit `Ctrl + Shift +f5` to reload.
