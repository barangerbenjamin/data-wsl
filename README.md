The point of the this repo is to keep track of problems that might occurs on a data WSL2 setup

# Jupyter

To make Jupyter work by default it is necessary to deactivate windows defender on public network interface (WSL2 uses that!).
TODO => Add entries to whitelist WSL2 requests in Windows Defender.

# SQLITE3

Using `pyenv` to install Python 3.7.7 seems to ship it with sqlite3 3.22.0
SQL Window Functions are only supported in SQLITE3 > 3.25.0
TODO => Find a work around
Jupyter might support Python 3.8 by then and the problem will be no more