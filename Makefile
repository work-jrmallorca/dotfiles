# -----------------------------------------------------------------------------
# Xubuntu Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
config:
	cp -R .config ~

# Transfer theme related files.
# NEED TO CHANGE TO NOT OVERWIRTE EXISTING FILES/DIRECTORIES
theme:
	sudo cp -R backgrounds/ /usr/share/
	sudo cp -R themes/ /usr/share/
	sudo cp -R icons/ /usr/share/
	sudo cp -R fonts/ /usr/share/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Install main programs.
general:
	sudo add-apt-repository ppa:kgilmer/speed-ricer
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt update -y
	sudo snap install autotiling ffmpeg
	sudo apt install -y git cmake meson i3-gaps curl wget feh npm daemon \
		slick-greeter neovim lightdm-settings xdotool xclip zathura xcape \
		redshift-gtk

fisher:
	curl -sL https://git.io/fisher | . && fisher install jorgebucaran/fisher

ripgrep:
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
	sudo dpkg -i ripgrep_12.1.1_amd64.deb
	rm ripgrep_12.1.1.amd64.deb

pomo:
	curl -L -s https://kevinschoon.github.io/pomo/install.sh | bash /dev/stdin
	sudo mv pomo /usr/local/bin/

flutter:
	cd ~ && git clone https://github.com/flutter/flutter.git

# weechat (CLI messaging) and bitlbee (For facebook and other stuff)
# UNTESTED
# https://wiki.bitlbee.org/HowtoFacebookMQTT
# https://weechat.org/files/doc/stable/weechat_quickstart.en.html
weechat-bitlbee:
	sudo apt install weechat
	echo "deb http://download.opensuse.org/repositories/home:/jgeboski/xUbuntu_20.04 ./" > /etc/apt/sources.list.d/jgeboski.list
	wget -O- 'https://build.opensuse.org/projects/home:jgeboski/public_key' | sudo apt-key add -
	sudo apt update -y
	sudo apt install bitlbee-facebook

# mpv (Media player)
# mpv https://github.com/mpv-player/mpv-build
mpv:
	sudo add-apt-repository ppa:mc3man/mpv-tests
	sudo apt update
	sudo apt install mpv

# Install terminal colour scheme changer
gogh:
	sudo apt install dconf-cli uuid-runtime
	bash -c "$(wget -qO- https://git.io/vQgMr)"

# Install autotiling for i3
autotiling:
	sudo apt install python3-pip git
	pip3 install i3ipc
	cd ~/gitapps/ && git clone git@github.com:olemartinorg/i3-alternating-layout.git

# Install picom (compositor)
# UNTESTED
picom:
	sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev
	cd ~/gitapps/ && git clone git@github.com:yshui/picom.git && \
		cd picom/ && git submodule update --init --recursive && \
		sudo meson --buildtype=release . build && \
		sudo ninja -C build && \
		sudo ninja -C build install

# Install Vim-Plug. NeoVim configs must be set up.
# UNTESTED
vim-plug:
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install Go.
# UNTESTED
# CHECK VERSION BEFORE MAKING
go:
	wget https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf go1.15.3.linux-amd64.tar.gz
	rm go1.15.3.linux-amd64.tar.gz

# Install googler
googler:
	wget https://github.com/jarun/googler/releases/download/v4.3.1/googler_4.3.1-1_ubuntu20.04.amd64.deb
	sudo apt install ./googler_4.3.1-1_ubuntu20.04.amd64.deb
	rm googler_4.3.1-1_ubuntu20.04.amd64.deb

fd:
	wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb
	sudo apt install ./fd_8.2.1_amd64.deb
	rm fd_8.2.1_amd64.deb

bat:
	wget https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb
	sudo apt install ./bat_0.17.1_amd64.deb
	rm bat_0.17.1_amd64.deb

# Install propreitary software:
# Microsoft Teams
# VSCode
propreitary:
	sudo snap install code --classic
	# spotify

# NEED TO EDIT FROM HERE ------------------------------------------------------
# Install Spotify Terminal UI.
spt:
	sudo snap install spt
	xdg-open https://developer.spotify.com/dashboard/login

# Install Spotifyd.
spotifyd:
	sudo apt install -y libasound2-dev libssl-dev libpulse-dev libdbus-1-dev
	git clone https://github.com/Spotifyd/spotifyd.git
	cd spotifyd && cargo build --release --no-default-features \
		--features pulseaudio_backend,dbus_mpris && \
		cp ../dotfiles/Cargo.toml . && \
		cargo install --path . --locked
	rm -Rf spotifyd

# Install Android Studios
android-studios:
	sudo snap install android-studio
