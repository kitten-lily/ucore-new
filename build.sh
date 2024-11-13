#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Add rpmfusion
# Not installed by default on ucore
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$RELEASE.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$RELEASE.noarch.rpm

### Install latest rclone to get Proton support
rpm-ostree override replace https://downloads.rclone.org/rclone-current-linux-amd64.rpm

### Install packages
rpm-ostree install intel-media-driver \
    libva libva-utils \
    fish \
    bat eza fd-find fzf gh micro ripgrep zoxide

### Add Starship
# Starship Shell Prompt
curl -Lo /tmp/starship.tar.gz "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz"
tar -xzf /tmp/starship.tar.gz -C /tmp
install -c -m 0755 /tmp/starship /usr/bin

### Add chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/bin
