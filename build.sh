#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Add rpmfusion

# Not installed by default on ucore
rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

### Install latest rclone to get Proton support

rpm-ostree install https://downloads.rclone.org/rclone-current-linux-amd64.rpm

### Install packages

rpm-ostree install intel-media-driver \
    libva libva-utils \
    /tmp/rclone.rpm

### Replace rclone for Proton Drive support
