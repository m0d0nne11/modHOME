# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/sh

# install or update Adobe Flash with dpkg

# Adobe offers Flash in a dpkg package, suitable for use with Debian, Ubuntu
# and other Linux systems using dpkg.  However, the only APT repository
# which includes Flash is Ubuntu, and that doesn't always work on Debian,
# due to incompatible dependencies.
#
# This script retrieves the dpkg file from Adobe (if needed), and then
# installs it if the downloaded package file is a newer/different version
# than what's currently installed (if anything).

# ---------- constants ----------

PKGFILE="install_flash_player_10_linux.deb"
PKGURL="http://fpdownload.macromedia.com/get/flashplayer/current/$PKGFILE"
PKGDIR="/var/cache/install_update_flash"

# ---------- functions ----------

function die () {
	echo "FATAL ERROR: $@"
	exit 1
}

function decho () {
# debug echo
	[ -n "$DEBUG" ] || return
	echo "$@"
}

# ---------- program ----------

# chdir to cache dir, creating if needed
[ -e "$PKGDIR" ] || mkdir "$PKGDIR" || die "mkdir trouble"
cd "$PKGDIR" || die "chdir trouble"

# get latest version, if newer than what we have (or if we have nothing)
wget --no-verbose --timestamping "$PKGURL" || die "wget trouble"

# download file should be size greater than zero
[ -s "$PKGFILE" ] || die "package file is missing/empty/bogus after download attempt"

# get package name and version from file we downloaded
PKGNAME=$( dpkg-deb --field "$PKGFILE" Package ) || die "trouble examining downloaded package file"
FILEVER=$( dpkg-deb --field "$PKGFILE" Version ) || die "trouble examining downloaded package file"

decho "PKGNAME=$PKGNAME"
decho "FILEVER=$FILEVER"

# get version of installed package of same name (if any)
unset INSTVER
INSTVER=$( dpkg-query --show --showformat='${Version}\n' "$PKGNAME" )
RC=$?
if [ "$RC" = 1 ]; then
	INSTVER=none
elif [ "$RC" -gt 1 ]; then
	die "trouble querying installed packages"
fi
# RC=0 means we got an installed package version

decho "INSTVER=$INSTVER"

# exit no-op if same version already installed
if [ "$INSTVER" = "$FILEVER" ]; then
	decho "installed version same as download version, nothing to do"
	exit 0
fi

echo "New/different version downloaded.  Installing downloaded package file..."
echo "Installed : $INSTVER"
echo "Downloaded: $FILEVER"

# dpkg exit code becomes our exit code
dpkg --install "$PKGFILE"

# ---------- EOF ----------
