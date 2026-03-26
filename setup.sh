#!/bin/sh

## Debian
if [ -f /etc/debian_version ]; then
	printf "Build neovim? [y/N]: "
	read -r choice
	if [ "$choice" = "y" ]; then
		sudo apt install -y ninja-build gettext cmake curl
		git clone --depth=1 https://github.com/neovim/neovim.git ~/.cache/neovim
		cd ~/.cache/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
		cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
	fi

	sudo apt install -y npm fd-find ripgrep imagemagick
	# go install github.com/jesseduffield/lazygit@latest
fi

# Requirements
[ -f /etc/arch-release ] && sudo pacman -S --noconfirm npm fd ripgrep imagemagick lazygit
command -v npm >/dev/null 2>&1 && sudo npm i -g tree-sitter-cli live-server
