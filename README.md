# Dot Files

This repository contains configuration files for tools that I use during development and terminal navigation and usage. This file was created to be used in a Fedora distribution with Gnome, therefore it uses dnf to install packages and configure some Gnome extensions.

## Installation script

The `install.sh` file will install all necessary packages, tools and dependencies in addition to guide the user through the configuration of some of them:

- installs zsh, oh-my-zsh, zsh-autosuggestions, zsh-syntax-highlighting, spaceship theme, sets zsh as default shell and copies the `.zshrc` file to the home directory (a backup file named .zshrc.bak is created);
- installs neovim and dependencies used by some plugins and copies neovim config to `~/.config` directory;
- installs nvm, the latest LTS node version and uses npm to install some global packages to be used with nvim plugins;
- installs go and gopls;
- configures git with given user name and email (user input is needed) and create a new ssh key at `~/.ssh` directory;
- installs solaar (to improve usage of logitech peripherals) and copies its config file;
- installs ruff to format and lint python code;
- installs lua-language-server;
- installs some gnome extensions;
- installs docker and insomnia;
- initialize zsh.

## Configurations

All the configurations provided by this repository are described bellow along with some settings that should be done manually.

### Nvim

The nvim folder contains all files that provides general and plugin specific settings. The configured plugins (using lazy package manager) provides the following features:

- lsp, code formatting and linting for typescript, go, c and python;
- code completion with lsp;
- copilot and copilot chat with suggestions using completion box;
- noice for UI customization;
- telescope for files and text search;
- hover to provide lsp information;
- statusline to provide general information;
- git information such as blame and file/line modification;
- oxocarbon theme;
- better code highlighting;
- general improvements for code reading and writting.

### Solaar

The solaar configuration file was created to be used with the MX Master 3S mouse and provides the following features:

- navigate between workspaces using the thumb wheel;
- show the applications menu using the middle (Smart Shift) button;
- show workspace windows using the thumb (Mouse Gestures) button.

To improve solaar icon at the top panel, add `-b solaar` at the end of the `Exec` options of the `/etc/xdg/autostart/solaar.desktop` file.

### Cloud Drive Integration

With Gnome is possible to link an account to access files inside a Cloud Drive (such as Google Drive or OneDrive), but it uses the email to name the virtual volume which can become a problem if you use multiple drives with the same email.

To address this problem we can change the `PresentationIdentity` setting of the `~/.config/goa-1.0/accounts.conf` file for each integration, this way we can choose the name that will be used to identify each integration.

