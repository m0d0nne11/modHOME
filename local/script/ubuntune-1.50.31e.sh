# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#! /bin/bash
#
# UbunTUNE 1.50.31e-nlfv-pre-2.0-wrbs
#
# Turns any Ubuntu-based Linux distribution into a desktop system to be primarily used by network and system
# administrators, power users, or anyone who wants a Linux distribution with the extras added.
#
# Written and Maintained by by Ron S rezphreak@hotmail.com
#
# Download the latest version from http://sourceforge.net/projects/ubuntune/
#
# ---------------------------------------------------------------------------------------------------------------------
# /////////////////////////////////////////////////// GNU LICENSING \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# ---------------------------------------------------------------------------------------------------------------------
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either version 2 of the License, or (at your option) any later
# version.
#
# http://www.gnu.org/licenses/gpl-2.0.html
#
# This script adds software from repositories which are not under its control.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# No Warranty or guarantee of suitability exists for this software
# Use at your own risk. The author is not responsible if your system breaks.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>
#
# ---------------------------------------------------------------------------------------------------------------------
# ///////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# ---------------------------------------------------------------------------------------------------------------------
#
# #####################################################################################################################
# Installation Logging
# #####################################################################################################################
#
# script -a $HOME/$user/Documents/installation-log.txt
#
# #####################################################################################################################
# Set Export Path
# #####################################################################################################################
#
export PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/games
# export PATH=/bin:/usr/bin:/sbin:/usr/sbin
#
# #####################################################################################################################
# Updated Respositories
# #####################################################################################################################
#
apt-get --yes -q --force-yes update
#
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
wget http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list --output-document=/etc/apt/sources.list.d/medibuntu.list
apt-get --yes -q  --force-yes --allow-unauthenticated install medibuntu-keyring
add-apt-repository "deb http://www.geekconnection.org/remastersys/repository karmic/"
add-apt-repository "deb http://ppa.launchpad.net/tualatrix/ppa/ubuntu $(lsb_release -sc) main"
add-apt-repository "deb-src http://ppa.launchpad.net/tualatrix/ppa/ubuntu $(lsb_release -sc) main"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0624A220
#
add-apt-repository "deb http://liveusb.info/multisystem/depot all main"
wget -q http://liveusb.info/multisystem/depot/multisystem.asc -O- | sudo apt-key add -
#
add-apt-repository ppa:am-monkeyd/nautilus-elementary-ppa
add-apt-repository ppa:bisigi
#
# Repo for equinox-ubuntu-theme
add-apt-repository ppa:tiheum/equinox
#
add-apt-repository ppa:ailurus/ppa
add-apt-repository ppa:banshee-team
add-apt-repository ppa:baudm/ppa
add-apt-repository ppa:jkakavas/creepy-lucid
add-apt-repository ppa:s-lagui/ppa
add-apt-repository ppa:danielrichter2007/grub-customizer
add-apt-repository ppa:pmjdebruijn/darktable-release-plus
add-apt-repository ppa:elegant-gnome/ppa
add-apt-repository ppa:fai/ppa
add-apt-repository ppa:ferramroberto/linuxfreedomlucid
add-apt-repository ppa:ferramroberto/vlc
add-apt-repository ppa:freenx-team
add-apt-repository ppa:freetuxtv/freetuxtv
add-apt-repository ppa:gdm2setup/gdm2setup
add-apt-repository ppa:gpredict-team/ppa
add-apt-repository ppa:haliner/ppa
add-apt-repository ppa:kevin-mehall/pithos-daily
add-apt-repository ppa:kubuntu-ppa/backports
add-apt-repository ppa:libreoffice/ppa
add-apt-repository ppa:llyzs/ppa
add-apt-repository ppa:luckybackup-maintainers
#
# Repositories for Mozilla Firefox 4.0
add-apt-repository ppa:mozillateam/firefox-stable
#
# Repositories for light-themes
# add-apt-repository ppa:murrine-daily/ppa
#
add-apt-repository ppa:nanny
add-apt-repository ppa:nagiosinc/ppa
add-apt-repository ppa:nikount/orta-desktop
add-apt-repository ppa:pkg-games/ppa
add-apt-repository ppa:realtime.sunlight.wallpaper/rsw
add-apt-repository ppa:rohangarg/kde-extra
add-apt-repository ppa:shutter/ppa
add-apt-repository ppa:timekpr-maintainers
add-apt-repository ppa:webcontentcontrol/webcontentcontrol
#
wget http://www.openastro.org/sources.list.d/lucid.list -O /etc/apt/sources.list.d/openastro.list
wget -q http://www.openastro.org/openastro.asc -O- | sudo apt-key add -
#
# Repository for xplanetFX
#
sudo wget -O - http://repository.mein-neues-blog.de:9000/PublicKey | sudo apt-key add -
sudo echo "deb http://repository.mein-neues-blog.de:9000/ /" | sudo tee -a /etc/apt/sources.list
#
#
# Repositories for Get-Deb
#
add-apt-repository "deb http://archive.getdeb.net/ubuntu $(lsb_release -sc)-getdeb apps"
wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
#
add-apt-repository "deb http://archive.getdeb.net/ubuntu $(lsb_release -sc)-getdeb games"
wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
#
apt-get --yes -q install -f
apt-get --yes -q --force-yes update
apt-get --yes -q --force-yes upgrade
#
# #####################################################################################################################
# Sources.list Backup
# #####################################################################################################################
#
cp -f /etc/apt/sources.list /etc/apt/sources.list.backup
#
# #####################################################################################################################
# Removing Unwanted Software
# #####################################################################################################################
#
apt-get --yes -q --force-yes remove amarok
apt-get --yes -q --force-yes remove empathy
apt-get --yes -q --force-yes remove gimp
apt-get --yes -q --force-yes remove gufw
apt-get --yes -q --force-yes remove gwibber
apt-get --yes -q --force-yes purge "openoffice*.*"
apt-get --yes -q --force-yes remove transmission-gtk
#
# #####################################################################################################################
# Lucid Button Fix
# #####################################################################################################################
#
gconftool-2 --set /apps/metacity/general/button_layout --type string "menu:minimize,maximize,close"
#
# #####################################################################################################################
# Software Installation via Repositories
# #####################################################################################################################
#
apt-get --yes -q --force-yes install acpi
apt-get --yes -q --force-yes install abcde
apt-get --yes -q --force-yes install adept
apt-get --yes -q --force-yes install ailurus
apt-get --yes -q --force-yes install alarm-clock
apt-get --yes -q --force-yes install album
apt-get --yes -q --force-yes install app-install-data-medibuntu
apt-get --yes -q --force-yes install aptoncd
apt-get --yes -q --force-yes install apt-show-versions
apt-get --yes -q --force-yes install ardour
apt-get --yes -q --force-yes install arista
apt-get --yes -q --force-yes install arpwatch
apt-get --yes -q --force-yes install atolm-theme
apt-get --yes -q --force-yes install atop
apt-get --yes -q --force-yes install audacity
apt-get --yes -q --force-yes install avidemux
apt-get --yes -q --force-yes install banshee
apt-get --yes -q --force-yes install bisigi-themes
# apt-get --yes -q --force-yes install bleachbit
apt-get --yes -q --force-yes install bmon
apt-get --yes -q --force-yes install calibre
apt-get --yes -q --force-yes install checkservice
apt-get --yes -q --force-yes install chkconfig
apt-get --yes -q --force-yes install chkrootkit
apt-get --yes -q --force-yes install chntpw
apt-get --yes -q --force-yes install cmatrix
apt-get --yes -q --force-yes install cmus
apt-get --yes -q --force-yes install compiz
apt-get --yes -q --force-yes install compiz-core
apt-get --yes -q --force-yes install compiz-fusion-*
apt-get --yes -q --force-yes install compiz-gnome
apt-get --yes -q --force-yes install compiz-plugins
apt-get --yes -q --force-yes install compizconfig-settings-manager
apt-get --yes -q --force-yes install community-themes
apt-get --yes -q --force-yes install cowsay
apt-get --yes -q --force-yes install crack-common
apt-get --yes -q --force-yes install chromium-browser
apt-get --yes -q --force-yes install creepy
apt-get --yes -q --force-yes install darkstat
apt-get --yes -q --force-yes install darktable
apt-get --yes -q --force-yes install denyhosts
apt-get --yes -q --force-yes install desktopnova
apt-get --yes -q --force-yes install devede
apt-get --yes -q --force-yes install dia
apt-get --yes -q --force-yes install dict-gcide
apt-get --yes -q --force-yes install digikam
apt-get --yes -q --force-yes install doc-rfc
apt-get --yes -q --force-yes install doc-rfc-0001-0999
apt-get --yes -q --force-yes install doc-rfc-1000-1999
apt-get --yes -q --force-yes install doc-rfc-2000-2999
apt-get --yes -q --force-yes install doc-rfc-3000-3999
apt-get --yes -q --force-yes install doc-rfc-experimental
apt-get --yes -q --force-yes install doc-rfc-fyi-bcp
apt-get --yes -q --force-yes install doc-rfc-misc
apt-get --yes -q --force-yes install doc-rfc-old-std
apt-get --yes -q --force-yes install doc-rfc-std
apt-get --yes -q --force-yes install doc-rfc-std-proposed

apt-get --yes -q --force-yes install dpkg-repack
apt-get --yes -q --force-yes install dsniff
apt-get --yes -q --force-yes install dvdbackup
apt-get --yes -q --force-yes install easytag
apt-get --yes -q --force-yes install electricsheep
apt-get --yes -q --force-yes install elegant-gnome
apt-get --yes -q --force-yes install etherape
apt-get --yes -q --force-yes install ethtool
#
# For equinox-ubuntu-theme
apt-get --yes -q --force-yes install gtk2-engines-equinox
apt-get --yes -q --force-yes install equinox-theme
apt-get --yes -q --force-yes install equinox-ubuntu-theme
apt-get --yes -q --force-yes install faenza-icon-theme
#
# apt-get --yes -q --force-yes install fai-client
# apt-get --yes -q --force-yes install fai-server
apt-get --yes -q --force-yes install ffmpeg
apt-get --yes -q --force-yes install flash-plugin-installer
apt-get --yes -q --force-yes install fontforge
#
# ----------------------------------------------------------------------------------------------------------------------
# These are Forensics programs, which is why they are located here
# ----------------------------------------------------------------------------------------------------------------------
#
apt-get --yes -q --force-yes install autopsy
apt-get --yes -q --force-yes install foremost
apt-get --yes -q --force-yes install testdisk
#
# --------------------------------------------------------------------------------------------------------------------
#
apt-get --yes -q --force-yes install fotoxx
apt-get --yes -q --force-yes install fping
apt-get --yes -q --force-yes install freetuxtv
#
# For OpenShot
apt-get --yes -q --force-yes install frei0r-plugins
#
apt-get --yes -q --force-yes install fslint
apt-get --yes -q --force-yes install fwbuilder
apt-get --yes -q --force-yes install fwlogwatch
apt-get --yes -q --force-yes install g3dviewer
apt-get --yes -q --force-yes install gadmin-bind
apt-get --yes -q --force-yes install gadmin-dhcpd
apt-get --yes -q --force-yes install gadmin-proftpd
apt-get --yes -q --force-yes install gadmin-openvpn-client
apt-get --yes -q --force-yes install gadmin-openvpn-server
apt-get --yes -q --force-yes install gadmin-rsync
apt-get --yes -q --force-yes install gadmin-samba
apt-get --yes -q --force-yes install gadmin-squid
apt-get --yes -q --force-yes install gadmintools
apt-get --yes -q --force-yes install gbrainy
apt-get --yes -q --force-yes install gecko-mediaplayer
apt-get --yes -q --force-yes install geekcode
apt-get --yes -q --force-yes install gftp
apt-get --yes -q --force-yes install gisomount
apt-get --yes -q --force-yes install git-core
apt-get --yes -q --force-yes install glabels
apt-get --yes -q --force-yes install glunarclock
apt-get --yes -q --force-yes install gmanedit
apt-get --yes -q --force-yes install gmediafinder
apt-get --yes -q --force-yes install gmountiso
apt-get --yes -q --force-yes install gnash
apt-get --yes -q --force-yes install gnome-backgrounds
apt-get --yes -q --force-yes install gnome-breakout
apt-get --yes -q --force-yes install gnome-colors
apt-get --yes -q --force-yes install gnome-colors-common
apt-get --yes -q --force-yes install gnome-device-manager
apt-get --yes -q --force-yes install gnome-extra-icons
apt-get --yes -q --force-yes install gnome-human-icon-theme
apt-get --yes -q --force-yes install gnome-icon-theme
apt-get --yes -q --force-yes install gnome-network-admin
apt-get --yes -q --force-yes install gnome-schedule
apt-get --yes -q --force-yes install gnome-themes
apt-get --yes -q --force-yes install gnome-themes-extras
apt-get --yes -q --force-yes install gnome-themes-more
apt-get --yes -q --force-yes install gnomebaker
apt-get --yes -q --force-yes install gnotime
apt-get --yes -q --force-yes install googleearth
apt-get --yes -q --force-yes install gpaint
apt-get --yes -q --force-yes install gparted
apt-get --yes -q --force-yes install gphoto2
apt-get --yes -q --force-yes install gpredict
apt-get --yes -q --force-yes install gramps
apt-get --yes -q --force-yes install grsync
apt-get --yes -q --force-yes install grub2-splashimages
apt-get --yes -q --force-yes install grub-customizer
apt-get --yes -q --force-yes install gsmartcontrol
apt-get --yes -q --force-yes install gshutdown
apt-get --yes -q --force-yes install gstreamer0.10-ffmpeg
apt-get --yes -q --force-yes install gstreamer0.10-plugins*
apt-get --yes -q --force-yes install gtg
#
# For light-themes
# apt-get --yes -q --force-yes install gtk2-engines-murrine
# apt-get --yes -q --force-yes install light-themes
#
apt-get --yes -q --force-yes install gtkorphan
apt-get --yes -q --force-yes install gtk-recordmydesktop
apt-get --yes -q --force-yes install gtk-sunlight
apt-get --yes -q --force-yes install gtkterm
apt-get --yes -q --force-yes install gtweakui
apt-get --yes -q --force-yes install gweled
apt-get --yes -q --force-yes install handbrake*
apt-get --yes -q --force-yes install hardinfo
apt-get --yes -q --force-yes install hearts
apt-get --yes -q --force-yes install hicolor-icon-theme
apt-get --yes -q --force-yes install homebank
apt-get --yes -q --force-yes install howtime-theme
apt-get --yes -q --force-yes install hping3
apt-get --yes -q --force-yes install htop
apt-get --yes -q --force-yes install humanity-icon-theme
apt-get --yes -q --force-yes install ifstat
apt-get --yes -q --force-yes install iftop
apt-get --yes -q --force-yes install imagemagick
apt-get --yes -q --force-yes install infinity-theme
apt-get --yes -q --force-yes install inkscape
apt-get --yes -q --force-yes install ipcalc
apt-get --yes -q --force-yes install iperf
apt-get --yes -q --force-yes install iptables-persistent
apt-get --yes -q --force-yes install iptraf
apt-get --yes -q --force-yes install iptstate
apt-get --yes -q --force-yes install iptux
apt-get --yes -q --force-yes install isomaster
apt-get --yes -q --force-yes install java-common
apt-get --yes -q --force-yes install k3b
apt-get --yes -q --force-yes install k9copy
apt-get --yes -q --force-yes install kdenlive
apt-get --yes -q --force-yes install keychain
apt-get --yes -q --force-yes install knocker
apt-get --yes -q --force-yes install kubuntu-restricted-extras
apt-get --yes -q --force-yes install kolourpaint4
apt-get --yes -q --force-yes install kompozer
apt-get --yes -q --force-yes install konversation
# apt-get --yes -q --force-yes install kraft
apt-get --yes -q --force-yes install kstreamripper
#
apt-get --yes -q --force-yes install lbreakout2
apt-get --yes -q --force-yes install libdvdcss4
apt-get --yes -q --force-yes install libg3d-plugins
apt-get --yes -q --force-yes install libnotify-bin
apt-get --yes -q --force-yes install libreoffice-base
apt-get --yes -q --force-yes install libreoffice-base-core
apt-get --yes -q --force-yes install libreoffice-calc
apt-get --yes -q --force-yes install libreoffice-common
apt-get --yes -q --force-yes install libreoffice-core
apt-get --yes -q --force-yes install libreoffice-draw
apt-get --yes -q --force-yes install libreoffice-dtd-officedocument1.0
apt-get --yes -q --force-yes install libreoffice-dtd-officedocument1.0
apt-get --yes -q --force-yes install libreoffice-emailmerge
apt-get --yes -q --force-yes install libreoffice-evolution
apt-get --yes -q --force-yes install libreoffice-filter-binfilter
apt-get --yes -q --force-yes install libreoffice-gnome
apt-get --yes -q --force-yes install libreoffice-gtk
apt-get --yes -q --force-yes install libreoffice-help-en-us
apt-get --yes -q --force-yes install libreoffice-impress
apt-get --yes -q --force-yes install libreoffice-java-common
apt-get --yes -q --force-yes install libreoffice-math
apt-get --yes -q --force-yes install libreoffice-mysql-connector
apt-get --yes -q --force-yes install libreoffice-pdfimport
apt-get --yes -q --force-yes install libreoffice-report-builder
apt-get --yes -q --force-yes install libreoffice-report-builder-bin
apt-get --yes -q --force-yes install libxine1-ffmpeg
apt-get --yes -q --force-yes install lives
apt-get --yes -q --force-yes install lm-sensors
apt-get --yes -q --force-yes install logwatch
apt-get --yes -q --force-yes install luckybackup
apt-get --yes -q --force-yes install macchanger
apt-get --yes -q --force-yes install macchanger-gtk
apt-get --yes -q --force-yes install mcrypt
apt-get --yes -q --force-yes install maelstrom
apt-get --yes -q --force-yes install metacity-themes
apt-get --yes -q --force-yes install monkey-bubble
apt-get --yes -q --force-yes install mountmanager
apt-get --yes -q --force-yes install mozilla-libreoffice
apt-get --yes -q --force-yes install mozilla-plugin-vlc
apt-get --yes -q --force-yes install mtpaint
apt-get --yes -q --force-yes install multisystem
apt-get --yes -q --force-yes install mypaint
apt-get --yes -q --force-yes install mypasswordsafe
apt-get --yes -q --force-yes install mytop
apt-get --yes -q --force-yes install nast
apt-get --yes -q --force-yes install nautilus-bzr
apt-get --yes -q --force-yes install nautilus-gksu
apt-get --yes -q --force-yes install nautilus-open-terminal
apt-get --yes -q --force-yes install nautilus-wallpaper
apt-get --yes -q --force-yes install netcat
apt-get --yes -q --force-yes install nethogs
apt-get --yes -q --force-yes install netmask
apt-get --yes -q --force-yes install nanny
apt-get --yes -q --force-yes install netspeed
apt-get --yes -q --force-yes install network-manager-openvpn-gnome
apt-get --yes -q --force-yes install network-manager-pptp
apt-get --yes -q --force-yes install network-manager-vpnc
apt-get --yes -q --force-yes install network-manager-vpnc-gnome
apt-get --yes -q --force-yes install neverball
apt-get --yes -q --force-yes install ngrep
apt-get --yes -q --force-yes install nmap
apt-get --yes -q --force-yes install non-free-codecs
apt-get --yes -q --force-yes install ntfs-config
#
# --------------------------------------------------------------------------------------------------------------------
# These additional programs intergrate with the ntop application
# --------------------------------------------------------------------------------------------------------------------
#
apt-get --yes -q --force-yes install ntop
apt-get --yes -q --force-yes install gawk
apt-get --yes -q --force-yes install graphviz
apt-get --yes -q --force-yes install man2html
#
# --------------------------------------------------------------------------------------------------------------------
# These settings intergrate with the ntop application
# --------------------------------------------------------------------------------------------------------------------
#
sudo chown -R ntop:ntop /var/lib/ntop/
sudo chown -R ntop:ntop /usr/share/ntop/
sudo ls -s /usr/share/ntop/html /var/lip/ntop/
#
# --------------------------------------------------------------------------------------------------------------------
#
apt-get --yes -q --force-yes install ntp
apt-get --yes -q --force-yes install oggconvert
apt-get --yes -q --force-yes install openastro.org
apt-get --yes -q --force-yes install openmovieeditor
apt-get --yes -q --force-yes install openshot
apt-get --yes -q --force-yes install openssh-blacklist
apt-get --yes -q --force-yes install openssh-blacklist-extra
apt-get --yes -q --force-yes install openssh-client
apt-get --yes -q --force-yes install openssh-server
apt-get --yes -q --force-yes install p7zip
apt-get --yes -q --force-yes install p7zip-full
apt-get --yes -q --force-yes install p7zip-rar
apt-get --yes -q --force-yes install p0f
apt-get --yes -q --force-yes install partimage
apt-get --yes -q --force-yes install pastebinit
apt-get --yes -q --force-yes install pcal
apt-get --yes -q --force-yes install pdfedit
apt-get --yes -q --force-yes install phatch
apt-get --yes -q --force-yes install phatch-nautilus
apt-get --yes -q --force-yes install pidgin
apt-get --yes -q --force-yes install pidgin-plugin-pack
apt-get --yes -q --force-yes install pipewalker
apt-get --yes -q --force-yes install pithos
apt-get --yes -q --force-yes install pktstat
apt-get --yes -q --force-yes install planner
apt-get --yes -q --force-yes install ppa-purge
apt-get --yes -q --force-yes install preload
apt-get --yes -q --force-yes install procinfo
apt-get --yes -q --force-yes install putty
apt-get --yes -q --force-yes install pysdm
apt-get --yes -q --force-yes install pwgen
apt-get --yes -q --force-yes install qdvdauthor
apt-get --yes -q --force-yes install remastersys
apt-get --yes -q --force-yes install remmina
apt-get --yes -q --force-yes install remmina-gnome
apt-get --yes -q --force-yes install remmina-plugin-data
apt-get --yes -q --force-yes install remmina-plugin-nx
apt-get --yes -q --force-yes install remmina-plugin-rdp
apt-get --yes -q --force-yes install remmina-plugin-telepathy
apt-get --yes -q --force-yes install remmina-plugin-vnc
apt-get --yes -q --force-yes install remmina-plugin-xdmcp
apt-get --yes -q --force-yes install rss-glx
apt-get --yes -q --force-yes install samba
apt-get --yes -q --force-yes install sbackup
apt-get --yes -q --force-yes install scalpel
apt-get --yes -q --force-yes install scribus
apt-get --yes -q --force-yes install shares-admin
apt-get --yes -q --force-yes install shutter
apt-get --yes -q --force-yes install sipcalc
apt-get --yes -q --force-yes install soundconverter
apt-get --yes -q --force-yes install sshfs
apt-get --yes -q --force-yes install sshmenu
apt-get --yes -q --force-yes install sun-java6-bin
apt-get --yes -q --force-yes install sun-java6-fonts
apt-get --yes -q --force-yes install sun-java6-jre
apt-get --yes -q --force-yes install sun-java6-plugin
apt-get --yes -q --force-yes install supertux
apt-get --yes -q --force-yes install sysstat
apt-get --yes -q --force-yes install system-config-kickstart
apt-get --yes -q --force-yes install system-config-samba
apt-get --yes -q --force-yes install tcpdump
apt-get --yes -q --force-yes install testdisk
apt-get --yes -q --force-yes install traceroute
apt-get --yes -q --force-yes install tree
apt-get --yes -q --force-yes install ttf-ubuntu-font-family
apt-get --yes -q --force-yes install ubuntu-restricted-extras
apt-get --yes -q --force-yes install ubuntu-tweak
apt-get --yes -q --force-yes install ubuntu-wallpapers-extra
apt-get --yes -q --force-yes install ufw-gtk
apt-get --yes -q --force-yes install unetbootin
apt-get --yes -q --force-yes install unison-gtk
apt-get --yes -q --force-yes install unrar-free
apt-get --yes -q --force-yes install virtualbox-ose
apt-get --yes -q --force-yes install vlc
apt-get --yes -q --force-yes install vlc-plugin-pulse
apt-get --yes -q --force-yes install winff
apt-get --yes -q --force-yes install wipe
apt-get --yes -q --force-yes install wireshark
apt-get --yes -q --force-yes install x11vnc
apt-get --yes -q --force-yes install xnest
apt-get --yes -q --force-yes install xpdf
# apt-get --yes -q --force-yes install xplanetFX
apt-get --yes -q --force-yes install xserver-xephyr
apt-get --yes -q --force-yes install xtightvncviewer
apt-get --yes -q --force-yes install youtube-dl
apt-get --yes -q --force-yes install zenmap
#
# #####################################################################################################################
# Get-DEB Installs
# #####################################################################################################################
#
apt-get --yes -q --force-yes install gnucash
apt-get --yes -q --force-yes install pokerth
apt-get --yes -q --force-yes install speed-dreams
apt-get --yes -q --force-yes install steghide
#
aptitude install nautilus-image-converter
#
# Update Repositories
apt-get --yes -q install -f
apt-get --yes -q update
apt-get --yes -q upgrade
#
# Install CSS-DVD Support
apt-get install libdvdread4 && sudo /usr/share/doc/libdvdread4/install-css.sh
#
# Configure Java
update-alternatives --config java
#
# #####################################################################################################################
# iptables Setup and Configuration 1.42
# #####################################################################################################################
#
# The following is a script for setting up and configuring iptables on a desktop computer running Ubuntu.
#
# #####################################################################################################################
# Flushing Tables - Standard Default Setup
# #####################################################################################################################
#
iptables -F
#
# #####################################################################################################################
# Setting up tables - Standard Default Setup
# #####################################################################################################################
#
iptables -N LOGDROP
iptables -N OUTPUT
#
# #####################################################################################################################
# Logging INVALID packets - Standard Default Setup
# #####################################################################################################################
#
iptables -A INPUT -m state --state INVALID -j LOG --log-level 4 --log-prefix 'INVALID-DROP '
iptables -A INPUT -m state --state INVALID -j DROP
#
# #####################################################################################################################
# Loopback - INPUT - Standard Default Setup
# #####################################################################################################################
#
iptables -A INPUT -i lo -j ACCEPT
#
# #####################################################################################################################
# Logging of income packets - IN-DROP - Part 1 - Standard Default Setup
# #####################################################################################################################
#
iptables -A INPUT -m limit --limit 2/min -j LOG --log-level 4 --log-prefix 'IN-DROP '
#
# #####################################################################################################################
# Banned IP Addresses - Standard Default Setup
# #####################################################################################################################
#
iptables -A INPUT -s 203.194.0.0/18 -j LOGDROP
iptables -A INPUT -s 60.208.0.0/12 -j LOGDROP
iptables -A INPUT -s 202.96.0.0/12 -j LOGDROP
iptables -A INPUT -s 60.0.0.0/11 -j LOGDROP
iptables -A INPUT -s 222.192.0.0/11 -j LOGDROP
iptables -A INPUT -s 203.193.128.0/18 -j LOGDROP
#
# #####################################################################################################################
# Accepted INPUT - SECTION 1 - General - Standard Default Setup
# #####################################################################################################################
#
iptables -A INPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
#
iptables -A INPUT -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT
#
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# |||||||||||||||||||||||||||||||||||||||||||| ----- CUSTOM ----- |||||||||||||||||||||||||||||||||||||||||||||||||||||
# /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#
# #####################################################################################################################
# Accepted INPUT - SECTION 2 - Port Forwarding (INPUT)
# #####################################################################################################################
#
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 113 -j ACCEPT
#
# #####################################################################################################################
# Accepted INPUT - SECTION 3 - icmp, INPUT and ports setup
# #####################################################################################################################
#
iptables -A INPUT -p icmp --icmp-type 0 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 3 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 4 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -m limit --limit 10/second -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 11 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 12 -j ACCEPT
iptables -A INPUT -p icmp -j REJECT --reject-with icmp-port-unreachable
#
# #####################################################################################################################
# Accepted INPUT - SECTION 4 - Securing Input (INPUT)
# #####################################################################################################################
#
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,RST FIN,RST -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,ACK FIN -j DROP
iptables -A INPUT -p tcp -m tcp --tcp-flags ACK,URG URG -j DROP
iptables -A INPUT -p tcp -m tcp ! --tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -j DROP
#
# 
# The folowing part of this iptables setup script falls into two sections with each section being broken down into two
# sub-sections:
#
# SEC-1-A - SECURE - Remote Access via SSH and VNC
# SEC-1-B - NON-SECURE - Remote Access via SSH and VNC
#
# SEC-2-A - SECURE - Server Daemons, Ports and Processes
# SEC-2-B - NON-SECURE - Server Daemons, Ports and Processes
#
# The more secure method of "SEC-1-A - SECURE - Remote Access via SSH and VNC" is enabled by default, which forces eth0
# to be used for VNC and SSH ports, with SSH using a custom port number versus the default one of 22. If you're using a
# wireless setup, eth0 will need to be changed to whatever your wireless NIC is, such as wifi0.
#
# If you wish to use VNC and SSH where it's not bound to a certain interface and isn't as secure, then simply comment
# out everything in SEC-1-A and UNCOMMENT everything in SEC-1-B.
#
# SEC-2-A deals with various servers (daemons) and their ports, which are bound to eth0. By default, both of sections
# SEC-2-A and SEC-2-B are commented out, with the exception of IPERF on port 5001. Simply uncomment out whatever you
# want available either from SEC-2-A for the more secure method where it is bound to eth0 or from SEC-2-B where it is
# not bound to eth0. Again, if you are using wireless, this will need to be changed in SEC-2-A from eth0 to whatever
# your wirless NIC is such as wifi0
#
# #####################################################################################################################
# SEC-1-A - SECURE - Remote Access via SSH and VNC ( **** SECURE METHOD **** )
# #####################################################################################################################
#
# This method is much more secure for SSH
iptables -A INPUT -i eth0 -p tcp --dport 9922 -m state --state NEW -m recent --set --name SSH
iptables -A INPUT -i eth0 -p tcp --dport 9922 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name SSH -j DROP
#
# This method is much more secure for VNC on port 5500
iptables -A INPUT -i eth0 -p tcp --dport 5500 -m state --state NEW -m recent --set --name VNC5500
iptables -A INPUT -i eth0 -p tcp --dport 5500 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name VNC5500 -j DROP
#
# This method is much more secure for VNC on port 5800
iptables -A INPUT -i eth0 -p tcp --dport 5800 -m state --state NEW -m recent --set --name VNC5800
iptables -A INPUT -i eth0 -p tcp --dport 5800 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name VNC5800 -j DROP
#
# This method is much more secure for VNC on port 5900
iptables -A INPUT -i eth0 -p tcp --dport 5900 -m state --state NEW -m recent --set --name VNC5900
iptables -A INPUT -i eth0 -p tcp --dport 5900 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name VNC5900 -j DROP
#
# #####################################################################################################################
# SEC-1-B - NON-SECURE - Remote Access via SSH and VNC - (NON-SECURE METHOD)
# #####################################################################################################################
#
# For VNC
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5500 -j ACCEPT
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5800 -j ACCEPT
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5900 -j ACCEPT
#
# For SSH
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9922 -j ACCEPT
#
# #####################################################################################################################
# SEC-2-A - SECURE - Server Daemons, Ports and Processes - Uncomment As Needed - ( **** SECURE METHOD **** )
# #####################################################################################################################
#
# This method is much more secure for FTP on ports 20 and 21
# iptables -A INPUT -i eth0 -p tcp --dport 20 -m state --state NEW -m recent --set --name FTP20
# iptables -A INPUT -i eth0 -p tcp --dport 20 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name FTP20 -j DROP
#
# iptables -A INPUT -i eth0 -p tcp --dport 21 -m state --state NEW -m recent --set --name FTP21
# iptables -A INPUT -i eth0 -p tcp --dport 21 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name FTP21 -j DROP
#
# Enable if you have an SMTP server - HIGHLY SUGGEST BLOCKING PORT 25 AND USING AN ALTERNATIVE SECURED PORT FOR SMTP
# iptables -A INPUT -i eth0 -p tcp --dport 25 -m state --state NEW -m recent --set --name SMTP25
# iptables -A INPUT -i eth0 -p tcp --dport 25 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name SMTP25 -j DROP
#
# Enable if you have a HTTP server
# iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW -m recent --set --name HTTP80
# iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name HTTP80 -j DROP
#
# Enable if you have a POP server
# iptables -A INPUT -i eth0 -p tcp --dport 110 -m state --state NEW -m recent --set --name POP110
# iptables -A INPUT -i eth0 -p tcp --dport 110 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name POP110 -j DROP
#
# ------------------------------------------------
# Enable if you are access a remote syslog server
# ------------------------------------------------
#
# NOTE: IF YOU ARE RUNNING SYSLOG ON YOUR OWN PC AND DO NOT NEED TO CONNECT TO A REMOTE SYSLOG SERVER, THEN YOU DO NOT
# NEED TO ENABLE THIS OPTION.
#
# If this is a client PC that must access the syslogd (daemon) on another PC (running as a syslogd server)
# you'll need to configure the iptables to allow this client PC to access that server PC.
#
# For this example, we'll assume that the IP of this machine is 192.168.1.100 and our syslog server's IP is 192.168.1.2
# So, just enter the command below:
#
# sudo iptables -I INPUT -p udp -i eth0 -s 192.168.1.100 -d 192.168.1.2 --dport 514 -j ACCEPT
#
# ** Remember to change the IPs above to the actual IP of your client PC and also your server's IP
#
# To check if your syslog is listening on port 514, run the command below:-
#
# netstat -a | grep syslog
#
# and you should see the line below, else your syslog is not listening for remote log.
#
# udp    26880      0 *:syslog                *:*
#
# Done. you just setup your syslog server in Unbuntu Linux. Happy logging :)
#
# --------------------------------------------------------------------------
#
# Enable if you have OTRS
# iptables -A INPUT -i eth0 -p tcp --dport 888 -m state --state NEW -m recent --set --name OTRS888
# iptables -A INPUT -i eth0 -p tcp --dport 888 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name OTRS888 -j DROP
#
# This method is much more secure for NTOP on port 3000
# iptables -A INPUT -i eth0 -p tcp --dport 3000 -m state --state NEW -m recent --set --name NTOP3000
# iptables -A INPUT -i eth0 -p tcp --dport 3000 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name NTOP3000 -j DROP
#
# This method is much more secure for IPERF on port 5001
iptables -A INPUT -i eth0 -p tcp --dport 5001 -m state --state NEW -m recent --set --name IPERF5001
iptables -A INPUT -i eth0 -p tcp --dport 5001 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name IPERF5001 -j DROP
#
# ---------------------------------------------------------------------------------------------------------------------
# Enable if you have a Nagios Setup
# iptables -A INPUT -i eth0 -p tcp --dport 3998 -m state --state NEW -m recent --set --name NAGIOS3998
# iptables -A INPUT -i eth0 -p tcp --dport 3998 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name NAGIOS3998 -j DROP
#
# *** SPECIAL NOTE: Port 10000 is also used for WebMin so enable it if you use WebMin and/or Nagios ***
#
# iptables -A INPUT -i eth0 -p tcp --dport 10000 -m state --state NEW -m recent --set --name NAGIOS10000
# iptables -A INPUT -i eth0 -p tcp --dport 10000 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name NAGIOS10000 -j DROP
#
# iptables -A INPUT -i eth0 -p tcp --dport 12489 -m state --state NEW -m recent --set --name NAGIOS12489
# iptables -A INPUT -i eth0 -p tcp --dport 12489 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name NAGIOS12489 -j DROP
# ---------------------------------------------------------------------------------------------------------------------
#
# Enable if you have a Usermin Setup
# This method is much more secure for USERMIN on port 20000
# iptables -A INPUT -i eth0 -p tcp --dport 20000 -m state --state NEW -m recent --set --name USERMIN20000
# iptables -A INPUT -i eth0 -p tcp --dport 20000 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name USERMIN20000 -j DROP
#
# #####################################################################################################################
# SEC-2-B - NON-SECURE - Server Daemons, Ports and Processes - Uncomment As Needed - (NON-SECURE METHOD)
# #####################################################################################################################
#
# Enable if you are running an FTP server
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 20 -j ACCEPT
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT
#
# Enable if you have an SMTP server - HIGHLY SUGGEST BLOCKING PORT 25 AND USING AN ALTERNATIVE SECURED PORT FOR SMTP
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 25 -j ACCEPT
# 
# Enable if you have a HTTP server
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
#
# Enable if you have a POP server
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 110 -j ACCEPT
#
# NOTE: You canno't use an unsecure option for port 514 for a remote syslog server so that's why there isn't an entry here
#
# Enable if you have OTRS
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 888 -j ACCEPT
#
# For ntop
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3000 -j ACCEPT
#
# Enable if you have a Nagios Setup
# SPECIAL NOTE: Port 10000 is also used for WebMin so enable it if you use WebMin and/or Nagios
#
# For iperf
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5001 -j ACCEPT
#
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3998 -j ACCEPT
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 10000 -j ACCEPT
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 12489 -j ACCEPT
#
# Enable if you have a Usermin Setup
# iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 20000 -j ACCEPT
#
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#
# #####################################################################################################################
# Enable IP Forwarding - Standard Default Setup
# #####################################################################################################################
#
echo 1 > /proc/sys/net/ipv4/ip_forward
#
# #####################################################################################################################
# IP Masquerading - Standard Default Setup
# #####################################################################################################################
#
# (not needed if intranet is not using private ip-addresses)
iptables -t nat -A POSTROUTING -o ppp+ -j MASQUERADE
#
# #####################################################################################################################
# iptables-anti-attack-measures-policies - Standard Default Setup
# #####################################################################################################################
#
# In the following section set it 1 to enable the feature or 0 to disable the feature
#
# TCP SYN cookie protection from SYN floods
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
#
# Drop ICMP echo-request messages sent to broadcast or multicast addresses
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
#
# Drop ICMP echo-request messages (Permenantly block ICMP)
# echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
#
# Drop source routed packets
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route
#
# Don't accept ICMP redirect messages
echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects
#
# Don't send ICMP redirect messages
echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
#
# Enable source address spoofing protection
echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter
#
# Log packets with impossible source addresses
echo 1 > /proc/sys/net/ipv4/conf/all/log_martians
#
# #####################################################################################################################
# Logging of income packets - IN-DROP - Part 2 - Standard Default Setup
# #####################################################################################################################
#
iptables -A INPUT -j LOG --log-level 4 --log-prefix 'IN-DROP '
iptables -A INPUT -j DROP
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -m limit --limit 6/hour -j LOG --log-level 4 --log-prefix 'allowed-out '
iptables -A OUTPUT -j ACCEPT
iptables -A LOGDROP -j LOG --log-level 4 --log-prefix '*** HACKERS *** '
iptables -A LOGDROP -j DROP
#
# #####################################################################################################################
# iptables-save workaround - Standard Default Setup
# #####################################################################################################################
#
sudo iptables-save -c > $HOME/$user/iptables.rules
sudo iptables-restore < $HOME/$user/iptables.rules
sudo cp -f $HOME/$user/iptables.rules /etc/iptables.rules
sleep 3s
sudo rm -f $HOME/$user/iptables.rules
#
#
#
#
# #####################################################################################################################
# #####################################################################################################################
# /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# #####################################################################################################################
# |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# #####################################################################################################################
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# #####################################################################################################################
# #####################################################################################################################
#
#
#
#
# PLEASE NOTE THAT THE FOLLOWING SECTIONS ARE FOR THE SETUP AND CONFIGURATION OF OF IP6TABLES WHICH IS USED EXCLUSIVELY
# FOR IP VERSION 6 (IPV6) AND IT RUNS IN CONJUNCTION WITH THE REGULAR IPTABLES AND *** NOT *** AS A REPLACEMENT FOR IT.
#
# JUST LIKE WITH THE IPTABLES SCRIPT, THE FOLLOWING SECTIONS EXIST HERE AS WELL AND MAY ALSO BE CONFIGURED AS SUCH.
#
# SEC-1-A - SECURE - Remote Access via SSH and VNC
# SEC-1-B - NON-SECURE - Remote Access via SSH and VNC
#
# SEC-2-A - SECURE - Server Daemons, Ports and Processes
# SEC-2-B - NON-SECURE - Server Daemons, Ports and Processes
#
# #####################################################################################################################
# ip6tables Setup and Configuration 1.42
# #####################################################################################################################
#
# The following is a script for setting up and configuring ip6tables on a desktop computer running Ubuntu.
#
# #####################################################################################################################
# Flushing Tables - Standard Default Setup
# #####################################################################################################################
#
ip6tables -F
#
# #####################################################################################################################
# Setting up tables - Standard Default Setup
# #####################################################################################################################
#
ip6tables -N LOGDROP
ip6tables -N OUTPUT
#
# #####################################################################################################################
# Logging INVALID packets - Standard Default Setup
# #####################################################################################################################
#
ip6tables -A INPUT -m state --state INVALID -j LOG --log-level 4 --log-prefix 'INVALID-DROP '
ip6tables -A INPUT -m state --state INVALID -j DROP
#
# #####################################################################################################################
# Loopback - INPUT - Standard Default Setup
# #####################################################################################################################
#
ip6tables -A INPUT -i lo -j ACCEPT
#
# #####################################################################################################################
# Logging of income packets - IN-DROP - Part 1 - Standard Default Setup
# #####################################################################################################################
#
ip6tables -A INPUT -m limit --limit 2/min -j LOG --log-level 4 --log-prefix 'IN-DROP '
#
# #####################################################################################################################
# Banned IP Addresses - Standard Default Setup
# #####################################################################################################################
#
# ip6tables -A INPUT -s IP-HERE -j LOGDROP
#
# #####################################################################################################################
# Accepted INPUT - SECTION 1 - General - Standard Default Setup
# #####################################################################################################################
#
ip6tables -A INPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
#
ip6tables -A INPUT -p tcp --sport 80 -j ACCEPT
ip6tables -A INPUT -p udp --sport 53 -j ACCEPT
#
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# |||||||||||||||||||||||||||||||||||||||||||| ----- CUSTOM ----- |||||||||||||||||||||||||||||||||||||||||||||||||||||
# /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#
# #####################################################################################################################
# Accepted INPUT - SECTION 2 - Port Forwarding (INPUT)
# #####################################################################################################################
#
ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 113 -j ACCEPT
#
# #####################################################################################################################
# Accepted INPUT - SECTION 3 - icmp, INPUT and ports setup
# #####################################################################################################################
#
ip6tables -A INPUT -p ipv6-icmp -j ACCEPT
ip6tables -A INPUT -p icmp -j REJECT --reject-with icmp6-adm-prohibited
#
# #####################################################################################################################
# Accepted INPUT - SECTION 4 - Securing Input (INPUT)
# #####################################################################################################################
#
ip6tables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
ip6tables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
ip6tables -A INPUT -p tcp -m tcp --tcp-flags SYN,RST SYN,RST -j DROP
ip6tables -A INPUT -p tcp -m tcp --tcp-flags FIN,RST FIN,RST -j DROP
ip6tables -A INPUT -p tcp -m tcp --tcp-flags FIN,ACK FIN -j DROP
ip6tables -A INPUT -p tcp -m tcp --tcp-flags ACK,URG URG -j DROP
ip6tables -A INPUT -p tcp -m tcp ! --tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -j DROP
#
# #####################################################################################################################
# #####################################################################################################################
#
# The folowing part of this ip6tables setup script falls into two sections with each section being broken down into two
# sub-sections:
#
# SEC-1-A - SECURE - Remote Access via SSH and VNC
# SEC-1-B - NON-SECURE - Remote Access via SSH and VNC
#
# SEC-2-A - SECURE - Server Daemons, Ports and Processes
# SEC-2-B - NON-SECURE - Server Daemons, Ports and Processes
#
# The more secure method of "SEC-1-A - SECURE - Remote Access via SSH and VNC" is enabled by default, which forces eth0
# to be used for VNC and SSH ports, with SSH using a custom port number versus the default one of 22. If you're using a
# wireless setup, eth0 will need to be changed to whatever your wireless NIC is, such as wifi0.
#
# If you wish to use VNC and SSH where it's not bound to a certain interface and isn't as secure, then simply comment
# out everything in SEC-1-A and UNCOMMENT everything in SEC-1-B.
#
# SEC-2-A deals with various servers (daemons) and their ports, which are bound to eth0. By default, both of sections
# SEC-2-A and SEC-2-B are commented out, with the exception of IPERF on port 5001. Simply uncomment out whatever you
# want available either from SEC-2-A for the more secure method where it is bound to eth0 or from SEC-2-B where it is
# not bound to eth0. Again, if you are using wireless, this will need to be changed in SEC-2-A from eth0 to whatever
# your wirless NIC is such as wifi0
#
# #####################################################################################################################
# SEC-1-A - SECURE - Remote Access via SSH and VNC ( **** SECURE METHOD **** )
# #####################################################################################################################
#
# This method is much more secure for SSH
ip6tables -A INPUT -i eth0 -p tcp --dport 9922 -m state --state NEW -m recent --set --name SSH
ip6tables -A INPUT -i eth0 -p tcp --dport 9922 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name SSH -j DROP
#
# This method is much more secure for VNC on port 5500
ip6tables -A INPUT -i eth0 -p tcp --dport 5500 -m state --state NEW -m recent --set --name VNC5500
ip6tables -A INPUT -i eth0 -p tcp --dport 5500 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name VNC5500 -j DROP
#
# This method is much more secure for VNC on port 5800
ip6tables -A INPUT -i eth0 -p tcp --dport 5800 -m state --state NEW -m recent --set --name VNC5800
ip6tables -A INPUT -i eth0 -p tcp --dport 5800 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name VNC5800 -j DROP
#
# This method is much more secure for VNC on port 5900
ip6tables -A INPUT -i eth0 -p tcp --dport 5900 -m state --state NEW -m recent --set --name VNC5900
ip6tables -A INPUT -i eth0 -p tcp --dport 5900 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name VNC5900 -j DROP
#
# #####################################################################################################################
# SEC-1-B - NON-SECURE - Remote Access via SSH and VNC - (NON-SECURE METHOD)
# #####################################################################################################################
#
# For VNC
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5500 -j ACCEPT
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5800 -j ACCEPT
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5900 -j ACCEPT
#
# For SSH
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 9922 -j ACCEPT
#
# #####################################################################################################################
# SEC-2-A - SECURE - Server Daemons, Ports and Processes - Uncomment As Needed - ( **** SECURE METHOD **** )
# #####################################################################################################################
#
# This method is much more secure for FTP on ports 20 and 21
# ip6tables -A INPUT -i eth0 -p tcp --dport 20 -m state --state NEW -m recent --set --name FTP20
# ip6tables -A INPUT -i eth0 -p tcp --dport 20 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name FTP20 -j DROP
#
# ip6tables -A INPUT -i eth0 -p tcp --dport 21 -m state --state NEW -m recent --set --name FTP21
# ip6tables -A INPUT -i eth0 -p tcp --dport 21 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name FTP21 -j DROP
#
# Enable if you have an SMTP server - HIGHLY SUGGEST BLOCKING PORT 25 AND USING AN ALTERNATIVE SECURED PORT FOR SMTP
# ip6tables -A INPUT -i eth0 -p tcp --dport 25 -m state --state NEW -m recent --set --name SMTP25
# ip6tables -A INPUT -i eth0 -p tcp --dport 25 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name SMTP25 -j DROP
#
# Enable if you have a HTTP server
# ip6tables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW -m recent --set --name HTTP80
# ip6tables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name HTTP80 -j DROP
#
# Enable if you have a POP server
# ip6tables -A INPUT -i eth0 -p tcp --dport 110 -m state --state NEW -m recent --set --name POP110
# ip6tables -A INPUT -i eth0 -p tcp --dport 110 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name POP110 -j DROP
#
# Enable if you have OTRS
# ip6tables -A INPUT -i eth0 -p tcp --dport 888 -m state --state NEW -m recent --set --name OTRS888
# ip6tables -A INPUT -i eth0 -p tcp --dport 888 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name OTRS888 -j DROP
#
# This method is much more secure for NTOP on port 3000
# ip6tables -A INPUT -i eth0 -p tcp --dport 3000 -m state --state NEW -m recent --set --name NTOP3000
# ip6tables -A INPUT -i eth0 -p tcp --dport 3000 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name NTOP3000 -j DROP
#
# This method is much more secure for IPERF on port 5001
ip6tables -A INPUT -i eth0 -p tcp --dport 5001 -m state --state NEW -m recent --set --name IPERF5001
ip6tables -A INPUT -i eth0 -p tcp --dport 5001 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name IPERF5001 -j DROP
#
# ---------------------------------------------------------------------------------------------------------------------
# Enable if you have a Nagios Setup
# ip6tables -A INPUT -i eth0 -p tcp --dport 3998 -m state --state NEW -m recent --set --name NAGIOS3998
# ip6tables -A INPUT -i eth0 -p tcp --dport 3998 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name NAGIOS3998 -j DROP
#
# *** SPECIAL NOTE: Port 10000 is also used for WebMin so enable it if you use WebMin and/or Nagios ***
#
# ip6tables -A INPUT -i eth0 -p tcp --dport 10000 -m state --state NEW -m recent --set --name NAGIOS10000
# ip6tables -A INPUT -i eth0 -p tcp --dport 10000 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name NAGIOS10000 -j DROP
#
# ip6tables -A INPUT -i eth0 -p tcp --dport 12489 -m state --state NEW -m recent --set --name NAGIOS12489
# ip6tables -A INPUT -i eth0 -p tcp --dport 12489 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name NAGIOS12489 -j DROP
# ---------------------------------------------------------------------------------------------------------------------
#
# Enable if you have a Usermin Setup
# This method is much more secure for USERMIN on port 20000
# ip6tables -A INPUT -i eth0 -p tcp --dport 20000 -m state --state NEW -m recent --set --name USERMIN20000
# ip6tables -A INPUT -i eth0 -p tcp --dport 20000 -m state --state NEW -m recent --update --seconds 60 --hitcount 8 --rttl --name USERMIN20000 -j DROP
#
# #####################################################################################################################
# SEC-2-B - NON-SECURE - Server Daemons, Ports and Processes - Uncomment As Needed - (NON-SECURE METHOD)
# #####################################################################################################################
#
# Enable if you are running an FTP server
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 20 -j ACCEPT
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT
#
# Enable if you have an SMTP server - HIGHLY SUGGEST BLOCKING PORT 25 AND USING AN ALTERNATIVE SECURED PORT FOR SMTP
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 25 -j ACCEPT
# 
# Enable if you have a HTTP server
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
#
# Enable if you have a POP server
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 110 -j ACCEPT
#
# Enable if you have OTRS
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 888 -j ACCEPT
#
# For ntop
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3000 -j ACCEPT
#
# Enable if you have a Nagios Setup
# SPECIAL NOTE: Port 10000 is also used for WebMin so enable it if you use WebMin and/or Nagios
#
# For iperf
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 5001 -j ACCEPT
#
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 3998 -j ACCEPT
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 10000 -j ACCEPT
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 12489 -j ACCEPT
#
# Enable if you have a Usermin Setup
# ip6tables -A INPUT -m state --state NEW -m tcp -p tcp --dport 20000 -j ACCEPT
#
# \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
# |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
# /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#
# #####################################################################################################################
# Enable IP Forwarding - Standard Default Setup
# #####################################################################################################################
#
echo 1 > /proc/sys/net/ipv6/conf/all/forwarding
echo 1 > /proc/sys/net/ipv6/conf/default/forwarding
#
# #####################################################################################################################
# ip6tables-anti-attack-measures-policies - Standard Default Setup
# #####################################################################################################################
#
# In the following section set it 1 to enable the feature or 0 to disable the feature
#
# TCP SYN cookie protection from SYN floods
# Search Google - Not implemented within this script - May require a kernel modification or other patch
#
# Drop ICMP echo-request messages sent to broadcast or multicast addresses
# Search Google - Not implemented within this script
#
# Drop source routed packets
echo 1 > /proc/sys/net/ipv6/conf/all/accept_source_route
echo 1 > /proc/sys/net/ipv6/conf/default/accept_source_route
#
# Don't accept ICMP redirect messages
# Search Google - Not implemented within this script
#
# Don't send ICMP redirect messages
# Search Google - Not implemented within this script
#
# Enable source address spoofing protection
# Search Google - Not implemented within this script
#
# Log packets with impossible source addresses
# Search Google - Not implemented within this script
#
# #####################################################################################################################
# Logging of income packets - IN-DROP - Part 2 - Standard Default Setup
# #####################################################################################################################
#
ip6tables -A INPUT -j LOG --log-level 4 --log-prefix 'IN-DROP '
ip6tables -A INPUT -j DROP
ip6tables -A OUTPUT -o lo -j ACCEPT
ip6tables -A OUTPUT -m limit --limit 6/hour -j LOG --log-level 4 --log-prefix 'allowed-out '
ip6tables -A OUTPUT -j ACCEPT
ip6tables -A LOGDROP -j LOG --log-level 4 --log-prefix '*** HACKERS *** '
ip6tables -A LOGDROP -j DROP
#
# #####################################################################################################################
# ip6tables-save workaround - Standard Default Setup
# #####################################################################################################################
#
sudo ip6tables-save -c > $HOME/$user/ip6tables.rules
sudo ip6tables-restore < $HOME/$user/ip6tables.rules
sudo cp -f $HOME/$user/ip6tables.rules /etc/ip6tables.rules
sleep 3s
sudo rm -f $HOME/$user/ip6tables.rules
#
# #####################################################################################################################
# Banned Domains
# #####################################################################################################################
#
echo "ALL : .am" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .cat" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .cc" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .cm" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .gg" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .kp" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .ro" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .ru" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .vn" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .ws" | sudo tee -a >> /etc/hosts.deny
echo "ALL : .xxx" | sudo tee -a >> /etc/hosts.deny
#
# #####################################################################################################################
# syslog Setup - Standard Default Setup
# #####################################################################################################################
#
# ---------------------------------------------------------------------------------------------------------------------
# Installation
# ---------------------------------------------------------------------------------------------------------------------
#
sudo apt-get --yes -q --force-yes install sysklogd
#
# #####################################################################################################################
# Configuration
# #####################################################################################################################
#
sudo /etc/init.d/sysklogd stop
sudo /sbin/syslogd -ru syslog
#
sudo sed -i 's/SYSLOGD=""/SYSLOGD="-r"/g' /etc/default/syslogd
# sudo sed -i 's/XXX/yyy/g' /etc/syslogd.conf
#
# sudo update-rc.d sysklogd defaults
# sudo update-rc.d /etc/init.d/sysklogd defaults
#
cd /var/log
sleep 3s
sudo touch auth.log
sudo touch cron.log
sudo touch daemon.log
sudo touch debug
sudo touch iptables.log
sudo touch kern.log
sudo touch mail.err
sudo touch mail.info
sudo touch mail.log
sudo touch mail.warn
sudo touch syslog
sudo touch user.log
#
# Setting syslog as the owner of the logfiles
#
sudo chown syslog:adm auth.log
sudo chown syslog:adm cron.log
sudo chown syslog:adm daemon.log
sudo chown syslog:adm debug
sudo chown syslog:adm iptables.log
sudo chown syslog:adm kern.log
sudo chown syslog:adm mail.err
sudo chown syslog:adm mail.info
sudo chown syslog:adm mail.log
sudo chown syslog:adm mail.warn
sudo chown syslog:adm syslog
sudo chown syslog:adm user.log
#
cd $HOME/$user/Desktop
sleep 3s
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/denyhosts.conf
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/interfaces
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/logrotate.conf
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/ssh_config
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/syslog.conf
#
sudo cp -f denyhosts.conf /etc/denyhosts.conf
sudo cp -f interfaces /etc/network/interfaces
sudo cp -f logrotate.conf /etc/logrotate.conf
sudo cp -f ssh_config /etc/ssh/ssh_config
sudo cp -f syslog.conf /etc/syslog.conf
#
sudo cp -f denyhosts.conf /etc/denyhosts.conf.backup
sudo cp -f interfaces /etc/network/interfaces.backup
sudo cp -f logrotate.conf /etc/logrotate.conf.backup
sudo cp -f ssh_config /etc/ssh/ssh_config.backup
sudo cp -f syslog.conf /etc/syslog.conf.backup
#
sudo rm -f denyhosts.conf
sudo rm -f interfaces
sudo rm -f logrotate.conf
sudo rm -f ssh_config
sudo rm -f syslog.conf
sudo rm -f logrotate.conf
#
# Setup logrotate to run daily at Midnight
sudo sed -i 's/30 7/0 0/g' /etc/cron.d/anacron
#
# -----------------------------------------------------------------------
#
# Be sure to cat /usr/share/logwatch/default.conf/services/syslogd.conf
# and make sure that logfile = messages like in the example below.
# logfile = messages
#
# Also check out cat /usr/share/logwatch/dist.conf/services/syslogd.conf
# -----------------------------------------------------------------------
#
sudo /etc/init.d/sysklogd start
sudo service denyhosts force-reload
#
# #####################################################################################################################
# Install extra-community-themes
# #####################################################################################################################
#
apt-get --yes -q --force-yes install bzr && bzr branch lp:~nilarimogard/+junk/extra-community-themes && cd extra-community-themes/ && chmod +x install && sudo ./install && sleep 20s && cd $HOME/$user/Desktop && sudo rm -Rf extra-community-themes
#
# #####################################################################################################################
# Install Optional Software
# #####################################################################################################################
# Remove the pound sign in front of the software that you wish to install
#
# To lockdown your computer's user accounts - USE WITH CAUTION
# sudo apt-get --yes -q --force-yes install pessulus
#
# ---------------------------------------------------------------------------------------------------------------------
# For the musicians who may install this distro and want some specialized music-related software, simply uncomment the
# following lines and these programs will install when you run this bash script
# ---------------------------------------------------------------------------------------------------------------------
#
# apt-get --yes -q --force-yes install abcm2ps
# apt-get --yes -q --force-yes install alsa-tools-gui
# apt-get --yes -q --force-yes install amsynth
# apt-get --yes -q --force-yes install fluidsynth
# apt-get --yes -q --force-yes install fmit
# apt-get --yes -q --force-yes install freepats
# apt-get --yes -q --force-yes install gnometab
# apt-get --yes -q --force-yes install gstreamer0.10-fluendo-mp3
# apt-get --yes -q --force-yes install gstreamer0.10-plugins-bad
# apt-get --yes -q --force-yes install gtkguitune
# apt-get --yes -q --force-yes install hydrogen
# apt-get --yes -q --force-yes install hydrogen-drumkits
# apt-get --yes -q --force-yes install jack-rack
# apt-get --yes -q --force-yes install jackeq
# apt-get --yes -q --force-yes install jamin
# apt-get --yes -q --force-yes install libasound2-plugins
# apt-get --yes -q --force-yes install lilypond
# apt-get --yes -q --force-yes install qsampler
# apt-get --yes -q --force-yes install qsynth
# apt-get --yes -q --force-yes install rakarrack
# apt-get --yes -q --force-yes install rosegarden
# apt-get --yes -q --force-yes install sox
# apt-get --yes -q --force-yes install swh-plugins
# apt-get --yes -q --force-yes install tagtool
# apt-get --yes -q --force-yes install tap-plugins
# apt-get --yes -q --force-yes install terminatorx
# apt-get --yes -q --force-yes install timemachine
# apt-get --yes -q --force-yes install totem-gstreamer
# apt-get --yes -q --force-yes install tuxguitar
# apt-get --yes -q --force-yes install vkeybd
# apt-get --yes -q --force-yes install vorbis-gain
# apt-get --yes -q --force-yes install vorbis-tools
# apt-get --yes -q --force-yes install zynaddsubfx
#
# ---------------------------------------------------------------------------------------------------------------------
# The following is additional administration tools you can install
# ---------------------------------------------------------------------------------------------------------------------
#
# apt-get --yes -q --force-yes webmin
#
# ---------------------------------------------------------------------------------------------------------------------
# cairo-dock
# ---------------------------------------------------------------------------------------------------------------------
#
# apt-get --yes -q --force-yes install cairo-dock
# apt-get --yes -q --force-yes install cairo-dock-core
# apt-get --yes -q --force-yes install cairo-dock-data
# apt-get --yes -q --force-yes install cairo-dock-plug-ins
# apt-get --yes -q --force-yes install cairo-dock-plug-ins-data
# apt-get --yes -q --force-yes install cairo-dock-plug-ins-integration
#
# #####################################################################################################################
# Nautilus Elemantry Extras
# #####################################################################################################################
#
cd $HOME/$user/Desktop
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/nautilus-breadcrumbs-hack.tar.gz
cp -f nautilus-breadcrumbs-hack.tar.gz $HOME/$user
tar -xvf nautilus-breadcrumbs-hack.tar.gz
# Lastest version wget http://gnaag.k2city.eu/nautilus-breadcrumbs-hack.tar.gz
#
# #####################################################################################################################
# Thumbnail Hack
# #####################################################################################################################
#
cd $HOME/$user/Desktop
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/thumbnail-hack/modified/thumbnailframe.png
sleep 5s
mv -f thumbnailframe.png /usr/share/pixmaps/nautilus/thumbnail_frame.png
#
# #####################################################################################################################
# Sounds
# #####################################################################################################################
#
cd $HOME/$user/Desktop
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/sounds/ogg/desktop-startup.ogg
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/sounds/ogg/desktop-shutdown.ogg
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/sounds/ogg/startup.ogg
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/sounds/ogg/shutdown.ogg
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/sounds/ogg/desktop-login.ogg
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/sounds/ogg/desktop-logout.ogg
sleep 15s
cp -f desktop-startup.ogg /usr/share/sounds
cp -f desktop-shutdown.ogg /usr/share/sounds
cp -f startup.ogg /usr/share/sounds
cp -f shutdown.ogg /usr/share/sounds
cp -f desktop-login.ogg /usr/share/sounds/ubuntu/stereo
cp -f desktop-logout.ogg /usr/share/sounds/ubuntu/stereo
sleep 30s
rm -f desktop-startup.ogg
rm -f desktop-shutdown.ogg
rm -f startup.ogg
rm -f shutdown.ogg
rm -f desktop-login.ogg
rm -f desktop-logout.ogg
#
# #####################################################################################################################
# Applications
# #####################################################################################################################
#
cd $HOME/$user/Desktop
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/bleachbit_0.8.8-1_all_ubuntu1004.deb
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/bleachbit-bonus_0.8.2-1_all.deb
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/busyhot-2.0-i686.deb
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/gimpshop_2.2.11-1_i386.deb
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/gnaural_1.0.20101115-1_i386.deb
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/ipscan_3.0-beta6_i386.deb
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/nautilus-dropbox_0.6.8_i386.deb
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/teamviewer_linux.deb
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/youtube-dl
sleep 30s
dpkg -i bleachbit_0.8.8-1_all_ubuntu1004.deb
dpkg -i bleachbit-bonus_0.8.2-1_all.deb
dpkg -i busyhot-2.0-i686.deb
dpkg -i gimpshop_2.2.11-1_i386.deb
dpkg -i gnaural_1.0.20101115-1_i386.deb
dpkg -i ipscan_3.0-beta6_i386.deb
dpkg -i nautilus-dropbox_0.6.8_i386.deb
dpkg -i teamviewer_linux.deb
sleep 60s
cp -f youtube-dl /usr/bin/youtube-dl
rm -f bleachbit_0.8.8-1_all_ubuntu1004.deb
rm -f bleachbit-bonus_0.8.2-1_all.deb
rm -f busyhot-2.0-i686.deb
rm -f gimpshop_2.2.11-1_i386.deb
rm -f gnaural_1.0.20101115-1_i386.deb
rm -f ipscan_3.0-beta6_i386.deb
rm -f nautilus-dropbox_0.6.8_i386.deb
rm -f teamviewer_linux.deb
rm -f youtube-dl
#
# JDisk Report Installation
cd $HOME/$user/Desktop
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/jdiskreport/jdiskreport-1.3.2.jar
sudo cp -f jdiskreport-1.3.2.jar /bin/jdiskreport-1.3.2.jar
rm -f jdiskreport-1.3.2.jar
#
# #####################################################################################################################
# Google-Earth Files
# #####################################################################################################################
#
cd $HOME/$user/Documents
sleep 2s
mkdir google-earth
sleep 2s
cd $HOME/$user/Documents/google-earth
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/google-earth/grand-canyon.kmz
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/google-earth/niagara-falls.kmz
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/google-earth/pyramids-of-giza.kmz
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/google-earth/stonehenge.kmz
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/google-earth/tyler_erickson.kmz
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/applications/google-earth/uvg-grid.kmz
cp -f *.kmz $HOME/$user/Documents/google-earth
#
# #####################################################################################################################
# Background Images
# #####################################################################################################################
#
cd $HOME/$user/Desktop
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/backgrounds/WhiteOrchid.jpg
sleep 10s
cp -f WhiteOrchid.jpg /usr/share/backgrounds
sleep 5s
rm -f WhiteOrchid.jpg
#
cd $HOME/$user/Documents
sleep 3s
sudo wget -c -t0 http://dl.dropbox.com/u/914191/install-script/public/backgrounds.tar.gz
sudo tar -xvf backgrounds.tar.gz
sleep 3s
cd $HOME/$user/Documents/backgrounds
sleep 3s
sudo mv -f *.jpg *.png *.bmp /usr/share/backgrounds
sleep 30s
cd $HOME/$user/Documents
sudo rm -Rf backgrounds
sudo rm -Rf backgrounds.tar.gz
#
# #####################################################################################################################
# ufw-app-profiles
# #####################################################################################################################
#
cd $HOME/$user/Documents
sleep 3s
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/ufw-app-profiles.tar.gz
cp -f ufw-app-profiles.tar.gz
tar -xvf ufw-app-profiles.tar.gz
sleep 3s
cd $HOME/$user/Documents/ufw-app-profiles
sleep 3s
cp -f $HOME/$user/Documents/ufw-app-profiles/*.* /etc/ufw/applications.d
cd $HOME/$user/Documents
rm -Rf ufw-app-profiles
#
# #####################################################################################################################
# Cleanup Process
# #####################################################################################################################
#
apt-get autoclean
apt-get clean
nautilus -q
#
# #####################################################################################################################
# bashrc Backup and Customized Aliases Installation
# #####################################################################################################################
#
cp -f $HOME/$user/.bashrc $HOME/$user/.bashrc-backup-original
cd $HOME/$user/Desktop
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/bash_aliases
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/bashrc
cp -f bash_aliases $HOME/$user/.bash_aliases
cp -f bash_aliases /etc/skel/.bash_aliases
cp -f bashrc $HOME/$user/.bashrc
cp -f bashrc /etc/skel/.bashrc
rm -f bash_aliases
rm -f bashrc
cd $HOME/$user
source .bashrc
cp -f $HOME/$user/.bashrc $HOME/$user/.bashrc-backup-modified
#
# #####################################################################################################################
# Firefox Extensions
# #####################################################################################################################
# FIX CODE TO INSTALL XPI
# cd $HOME/$user/Desktop
# wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/firefox-extensions.xpi
# sleep 60s
# rm -f firefox-extensions.xpi
#
# #####################################################################################################################
# Installing Documentation
# #####################################################################################################################
#
cd $HOME/$user/Documents
sleep 5s
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/6-Reasons-I-Wont-Take-Windows-Seriously.doc > 6-Reasons-I-Wont-Take-Windows-Seriously.doc
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Book-Free-Culture.pdf > Book-Free-Culture.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Book-Free-For-All.pdf > Book-Free-For-All.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Book-Free-Software-Free-Society-by-Richard-M-Stallman.pdf > Book-Free-Software-Free-Society-by-Richard-M-Stallman.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Book-Introduction-to-Linux-A-Hands-on-Guide.pdf > Book-Introduction-to-Linux-A-Hands-on-Guide.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Book-Linux-Starter-Pack.pdf > Book-Linux-Starter-Pack.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Book-Newbies-Getting-Started-Guide-to-Linux.pdf > Book-Newbies-Getting-Started-Guide-to-Linux.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Book-The-Easiest-Linux-Guide-Youll-Ever-Read-An-Introduction-to-Linux.pdf > Book-The-Easiest-Linux-Guide-Youll-Ever-Read-An-Introduction-to-Linux.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Command-Line-Tools-Summary.pdf > Command-Line-Tools-Summary.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Command-Reference.pdf > Command-Reference.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Custom-Aliases.xls > Custom-Aliases.xls
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/FS-layout.png > FS-layout.png
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Getting-Started-with-Ubuntu-10.04-Second-Edition.pdf > Getting-Started-with-Ubuntu-10.04-Second-Edition.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Introduction-to-the-Command-Line-Second-Edition.pdf > Introduction-to-the-Command-Line-Second-Edition.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux-Administrators-Quick-Reference.pdf > Linux-Administrators-Quick-Reference.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux-Criticisms.pdf > Linux-Criticisms.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux.doc > Linux.doc
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux-FHS.pdf > Linux-FHS.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux-Folders.doc > Linux-Folders.doc
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux-is-Not-Windows.pdf > Linux-is-Not-Windows.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux-Permissions.doc > Linux-Permissions.doc  
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux-Security-Quick-Reference.pdf > Linux-Security-Quick-Reference.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Linux-tips-everyone-should-know.pdf > Linux-tips-everyone-should-know.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Microsoft-Scams.doc > Microsoft-Scams.doc
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/One-Page-Linux-Manual.pdf > One-Page-Linux-Manual.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Open-Source-Software-vs-Commercial-Software-Migration-from-Windows-to-Linux.pdf > Open-Source-Software-vs-Commercial-Software-Migration-from-Windows-to-Linux.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Organizational-Planning-and-User-Segmentation-Regarding-DesktopPC-Migration.pdf > Organizational-Planning-and-User-Segmentation-Regarding-DesktopPC-Migration.pdf
#
wget -c -t0 http://iana.org/assignments/port-numbers > port-numbers
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Reference.pdf > Reference.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/speeding-up-the-boot-process.txt > speeding-up-the-boot-process.txt
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/The-Tragedy-of-Linux-You-Can-Hack-an-OS-But-You-Cant-Hack-People.pdf > The-Tragedy-of-Linux-You-Can-Hack-an-OS-But-You-Cant-Hack-People.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Ubuntu-Pocket-Guide-1.1.pdf > Ubuntu-Pocket-Guide-1.1.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Ubuntu-Reference-Cheat-Sheet.pdf > Ubuntu-Reference-Cheat-Sheet.pdf
#
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/documentation/Windows-is-Easier-Just-Like-Stabbing-Your-Own-Eyeballs-is-Easier.doc > Windows-is-Easier-Just-Like-Stabbing-Your-Own-Eyeballs-is-Easier.doc
#
# #####################################################################################################################
# Changing Documenation Ownership To The Current User
# #####################################################################################################################
#
cd $HOME/$user/Documents
sleep 5s
chown $LOGNAME 6-Reasons-I-Wont-Take-Windows-Seriously.doc
chown $LOGNAME Book-Free-Culture.pdf
chown $LOGNAME Book-Free-For-All.pdf
chown $LOGNAME Book-Free-Software-Free-Society-by-Richard-M-Stallman.pdf
chown $LOGNAME Book-Introduction-to-Linux-A-Hands-on-Guide.pdf
chown $LOGNAME Book-Linux-Starter-Pack.pdf
chown $LOGNAME Book-Newbies-Getting-Started-Guide-to-Linux.pdf
chown $LOGNAME Book-The-Easiest-Linux-Guide-Youll-Ever-Read-An-Introduction-to-Linux.pdf
chown $LOGNAME Command-Line-Tools-Summary.pdf
chown $LOGNAME Command-Reference.pdf
chown $LOGNAME Custom-Aliases.xls
chown $LOGNAME FS-layout.png
chown $LOGNAME Getting-Started-with-Ubuntu-10.04-Second-Edition.pdf
chown $LOGNAME Introduction-to-the-Command-Line-Second-Edition.pdf
chown $LOGNAME Linux-Administrators-Quick-Reference.pdf
chown $LOGNAME Linux-Criticisms.pdf
chown $LOGNAME Linux.doc
chown $LOGNAME Linux-FHS.pdf
chown $LOGNAME Linux-Folders.doc
chown $LOGNAME Linux-is-Not-Windows.pdf
chown $LOGNAME Linux-Permissions.doc
chown $LOGNAME Linux-Security-Quick-Reference.pdf
chown $LOGNAME Linux-tips-everyone-should-know.pdf
chown $LOGNAME Microsoft-Scams.doc
chown $LOGNAME One-Page-Linux-Manual.pdf
chown $LOGNAME Open-Source-Software-vs-Commercial-Software-Migration-from-Windows-to-Linux.pdf
chown $LOGNAME Organizational-Planning-and-User-Segmentation-Regarding-DesktopPC-Migration.pdf
chown $LOGNAME port-numbers
chown $LOGNAME Reference.pdf
chown $LOGNAME speeding-up-the-boot-process.txt
chown $LOGNAME The-Tragedy-of-Linux-You-Can-Hack-an-OS-But-You-Cant-Hack-People.pdf
chown $LOGNAME Ubuntu-Pocket-Guide-1.1.pdf
chown $LOGNAME Ubuntu-Reference-Cheat-Sheet.pdf
chown $LOGNAME Windows-is-Easier-Just-Like-Stabbing-Your-Own-Eyeballs-is-Easier.doc
#
# #####################################################################################################################
# Icons
# #####################################################################################################################
#
apt-get --yes -q --force-yes install aquadreams-theme
apt-get --yes -q --force-yes install bamboo-zen-theme
apt-get --yes -q --force-yes install eco-theme
apt-get --yes -q --force-yes install ellanna-theme
apt-get --yes -q --force-yes install exotic-theme
apt-get --yes -q --force-yes install faenza-icon-theme
apt-get --yes -q --force-yes install gnome-accessibility-themes-extras
apt-get --yes -q --force-yes install gnome-applets-data
apt-get --yes -q --force-yes install gnome-brave-icon-theme
apt-get --yes -q --force-yes install gnome-color-chooser
apt-get --yes -q --force-yes install gnome-colors
apt-get --yes -q --force-yes install gnome-colors-common
apt-get --yes -q --force-yes install gnome-dust-icon-theme
apt-get --yes -q --force-yes install gnome-extra-icons
apt-get --yes -q --force-yes install gnome-human-icon-theme
apt-get --yes -q --force-yes install gnome-humility-icon-theme
apt-get --yes -q --force-yes install gnome-icon-theme
apt-get --yes -q --force-yes install gnome-icon-theme-blankon
apt-get --yes -q --force-yes install gnome-icon-theme-dlg-neu
apt-get --yes -q --force-yes install gnome-icon-theme-gartoon
apt-get --yes -q --force-yes install gnome-icon-theme-gperfection2
apt-get --yes -q --force-yes install gnome-icon-theme-nuovo
apt-get --yes -q --force-yes install gnome-icon-theme-suede
apt-get --yes -q --force-yes install gnome-icon-theme-yasis
apt-get --yes -q --force-yes install gnome-illustrious-icon-theme
apt-get --yes -q --force-yes install gnome-noble-icon-theme
apt-get --yes -q --force-yes install gnome-theme-gilouche
apt-get --yes -q --force-yes install gnome-themes-extras
apt-get --yes -q --force-yes install gnome-themes-more
apt-get --yes -q --force-yes install gnome-wine-icon-theme
apt-get --yes -q --force-yes install gnome-wise-icon-theme
apt-get --yes -q --force-yes install gtkhash
apt-get --yes -q --force-yes install gtk-smooth-themes
apt-get --yes -q --force-yes install gtk-theme-switch
apt-get --yes -q --force-yes install hicolor-icon-theme
apt-get --yes -q --force-yes install human-icon-theme
apt-get --yes -q --force-yes install human-theme
apt-get --yes -q --force-yes install humanity-icon-theme
apt-get --yes -q --force-yes install icon-aquadreams-theme
apt-get --yes -q --force-yes install icon-bamboo-zen-theme
apt-get --yes -q --force-yes install icon-eco-theme
apt-get --yes -q --force-yes install icon-ellanna-theme
apt-get --yes -q --force-yes install icon-exotic-theme
apt-get --yes -q --force-yes install icon-infinity-theme
apt-get --yes -q --force-yes install icon-showtime-theme
apt-get --yes -q --force-yes install icon-step-into-freedom-theme
apt-get --yes -q --force-yes install icon-tropical-theme
apt-get --yes -q --force-yes install icon-ubuntu-sunrise-theme
apt-get --yes -q --force-yes install icon-wild-shine-theme
apt-get --yes -q --force-yes install industrialtango-theme
apt-get --yes -q --force-yes install infinity-theme
apt-get --yes -q --force-yes install legacyhuman-theme
apt-get --yes -q --force-yes install konq-plugins
apt-get --yes -q --force-yes install moblin-icon-theme
apt-get --yes -q --force-yes install notify-osd-icons
apt-get --yes -q --force-yes install oxygen-icon-theme-complete
apt-get --yes -q --force-yes install resilience-theme
apt-get --yes -q --force-yes install shiki-colors
apt-get --yes -q --force-yes install showtime-theme
apt-get --yes -q --force-yes install step-into-freedom-theme
apt-get --yes -q --force-yes install tangerine-icon-theme
apt-get --yes -q --force-yes install tango-icon-theme
apt-get --yes -q --force-yes install tango-icon-theme-common
apt-get --yes -q --force-yes install tango-icon-theme-extras
apt-get --yes -q --force-yes install tropical-theme - tropical theme
apt-get --yes -q --force-yes install ubuntu-mono
apt-get --yes -q --force-yes install ubuntu-sunrise-theme
apt-get --yes -q --force-yes install wild-shine-theme
#
# #####################################################################################################################
# Secure the /home/user's directory
# #####################################################################################################################
#
# Secure the home user directory
#
# sudo sed -i 's/0755/0750/g' /etc/adduser.conf
#
# #####################################################################################################################
# Changing the SSH port from 22 to 9922 and securing SSH a bit better
# #####################################################################################################################
#
sudo sed -i 's/22/9922/g' /etc/ssh/sshd_config
#
cd $HOME/$user/Desktop
sudo wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/issue.net
sudo cp -f issue.net /etc/issue.net
sudo rm -f issue.net
#
cd $HOME/$user/Desktop
sudo wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/ssh-motd/00-header > 00-header
sudo cp -f 00-header /etc/update-motd.d
sleep 3s
sudo rm -f 00-header
cd /etc/update-motd.d
sudo rm -f 10*
sudo rm -f 20*
sudo rm -f 90*
sudo rm -f 91*
sudo rm -f 98*
sudo chmod 755 00-header
#
sudo sed -i 's/LoginGraceTime 120/LoginGraceTime 20/g' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i '\|#Banner /etc/issue.net|s|#||' /etc/ssh/sshd_config
#
sudo mkdir ~/.ssh
sudo chmod go-w ~/
sudo chmod 700 ~/.ssh
sudo chmod 600 ~/.ssh/authorized_keys
#
sudo /etc/init.d/ssh reload
sudo /etc/init.d/ssh restart
#
# #####################################################################################################################
# Stop non-administrative users from issue the su command
# #####################################################################################################################
#
sudo dpkg-statoverride --update --add root admin 4750 /bin/su
#
# #####################################################################################################################
# Zenmap Setup
# #####################################################################################################################
#
# Create Zenmap Directory for the user
cd $HOME/$user/Desktop
sudo wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/zenmap/scan_profile.usp > scan_profile.usp
sudo mkdir -p /$HOME/$user/.zenmap
sudo cp -f scan_profile.usp /$HOME/$user/.zenmap
sudo rm -f scan_profile.usp
#
# Create Zenmap Directory for root user
cd $HOME/$user/Desktop
sudo wget -c -t0 http://dl.dropbox.com/u/914191/install-script/settings/zenmap/scan_profile.usp > scan_profile.usp
sudo mkdir -p /root/.zenmap
sudo cp -f scan_profile.usp /root/.zenmap
sudo rm -f scan_profile.usp
#
# #####################################################################################################################
# Create old-logs Directory for log storage and apply custom logrotate configuration
# #####################################################################################################################
#
cd /var/log
sleep 3s
sudo mkdir -p old-logs
sleep 1s
#
# #####################################################################################################################
# Scripts - Bash
# #####################################################################################################################
#
cd $HOME/$user/Desktop
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/bleachbit-clean.sh > bleachbit-clean.sh
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/create-logs.sh > create-logs.sh
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/gnome-settings-backup.sh > gnome-settings-backup.sh
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/cs-extra.sh > cs-extra.sh
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/gnome-terminal-default-settings.sh > gnome-terminal-default-settings.sh
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/iptables-blacklist.sh > iptables-blacklist.sh
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/monitoring.sh > monitoring.sh
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/oldlogs.sh > oldlogs.sh
wget -c -t0 http://dl.dropbox.com/u/914191/install-script/scripts/zenity-2.24.0-focus.patch > zenity-2.24.0-focus.patch
sudo cp -f bleachbit-clean.sh /bin/bleachbit-clean.sh
sudo cp -f create-logs.sh /bin/create-logs.sh
sudo cp -f cs-extra.sh /bin/cs-extra.sh
sudo cp -f gnome-settings-backup.sh /bin/gnome-settings-backup.sh
sudo cp -f gnome-settings-backup.sh /bin/gnome-terminal-default-settings.sh
sudo cp -f iptables-blacklist.sh /bin/iptables-blacklist.sh
sudo cp -f monitoring.sh /bin/monitoring.sh
sudo cp -f oldlogs.sh /bin/oldlogs.sh
sudo chmod +x /bin/bleachbit-clean.sh
sudo chmod +x /bin/create-logs.sh
sudo chmod +x /bin/cs-extra.sh
sudo chmod +x /bin/gnome-settings-backup.sh
sudo chmod +x /bin/gnome-terminal-default-settings.sh
sudo chmod +x /bin/iptables-blacklist.sh
sudo chmod +x /bin/monitoring.sh
sudo chmod +x /bin/oldlogs.sh
cd $HOME/$user/Desktop
sudo rm -f bleachbit-clean.sh
sudo rm -f create-logs.sh
sudo rm -f cs-extra.sh
sudo rm -f gnome-settings-backup.sh
sudo rm -f gnome-terminal-default-settings.sh
sudo rm -f iptables-blacklist.sh
sudo rm -f monitoring.sh
sudo rm -f oldlogs.sh
#
# For the gnome-settings-backup.sh
sudo patch -f -s -p0 /usr/share/zenity/zenity.glade < zenity-2.24.0-focus.patch > /dev/null
sleep 3s
sudo rm -f zenity-2.24.0-focus.patch
#
# #####################################################################################################################
# gnome-terminal Default Profile Settings
# #####################################################################################################################
#
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/allow_bold true
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/alternate_screen_scroll true
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/background_color black
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/background_darkness 0.5
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/background_type solid
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/backspace_binding ascii-del
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/bold_color black
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/bold_color_same_as_fg true
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_blink_mode system
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block
gconftool-2 --unset /apps/gnome-terminal/profiles/Default/custom_command
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/default_show_menubar true
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/default_size_columns 80
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/default_size_rows 24
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/delete_binding escape-sequence
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/exit_action close
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/font "Monospace 12"
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/foreground_color "#0000FFFF0000"
gconftool-2 --unset /apps/gnome-terminal/profiles/Default/icon
gconftool-2 --unset /apps/gnome-terminal/profiles/Default/login_shell
#
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/palette "#2E2E34343636:#CCCC00000000:#4E4E9A9A0606:#C4C4A0A00000:#34346565A4A4:#757550507B7B:#060698209A9A:#D3D3D7D7CFCF:#555557575353:#EFEF29292929:#8A8AE2E23434:#FCFCE9E94F4F:#72729F9FCFCF:#ADAD7F7FA8A8:#3434E2E2E2E2:#EEEEEEEEECEC"
#
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/scroll_background true
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/scrollback_lines 5000
gconftool-2 --unset /apps/gnome-terminal/profiles/Default/scrollback_unlimited
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/scrollbar_position right
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/scroll_on_keystroke True
gconftool-2 --unset /apps/gnome-terminal/profiles/Default/scroll_on_output
gconftool-2 --unset /apps/gnome-terminal/profiles/Default/silent_bell
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/title Terminal
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/title_mode replace
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/update_records True
gconftool-2 --unset /apps/gnome-terminal/profiles/Default/use_custom_command
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/use_skey True
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/use_system_font True
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/use_theme_background True
#
gconftool-2 -s /apps/gnome-terminal/profiles/Default/use_theme_colors -t bool false
#
gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/visible_name Default
#
# #####################################################################################################################
# Final Cleanup Process
# #####################################################################################################################
#
apt-get --yes -q install -f
apt-get --yes -q --force-yes update
apt-get --yes -q --force-yes upgrade
#
cd $HOME/$user && sleep 3s && source .bashrc
#
# #####################################################################################################################
# Reboot
# #####################################################################################################################
#
clear;
echo "\n";
echo "\033[1m 1] Reboot System";
echo "\033[1m 2] Exit";
read -p "->> 1 or 2 ?: " choice
if [ $choice -eq 1 ];
then
clear
sudo shutdown -r now
fi
if [ $choice -eq 2 ];
then
echo "The installation script has finished and will now exit in 10 seconds.";
echo "Please reboot your system as soon as possible to complete the installation.";
echo "Thank you for using Ron's Installation Script for Ubuntu.";
exit
fi
