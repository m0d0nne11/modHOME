# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/sh

# Rather than executing an NVIDIA installer against a single
# kernel (thereby uninstalling the NVIDIA driver for all other
# kernels if invoked in the usual manner) this script will execute
# that installer against all specified kernels ensuring that they
# all can be used without having to rerun the installer for each.
#
# Example usage in chroot'd systemImage:
#   installNVIDIA.sh NVIDIA-Linux-x86-1.0-9631-pkg1.run  2.4.21-52.ELsmp.4GbUserVM 2.4.21-52.ELsmp
# ...or:
#   installNVIDIA.sh NVIDIA-Linux-x86-165.33.08-pkg1.run 2.4.21-52.ELsmp.4GbUserVM 2.4.21-52.ELsmp
# ...or even:
#   installNVIDIA.sh NVIDIA-Linux-x86-165.33.08-pkg1.run `ls /lib/modules`

##############################################################################

# Usage:   installNVIDIA NVIDIAinstallerScript               kernelVersionString[s]
# Example: installNVIDIA NVIDIA-Linux-x86-165.33.08-pkg1.run 2.4.21-52.ELsmp.4GbUserVM 2.4.21-52.ELsmp
#

##############################################################################
# Executes the specified NVIDIA installer script against the specified kernel,
# allowing it do its search-and-destroy of other kernel modules and X plugins.
#
function installNVIDIAmain()  {
    $1 --no-backup                \
       --no-network               \
       --no-precompiled-interface \
       --no-rpms                  \
       --no-runlevel-check        \
       --no-x-check               \
       --silent                   \
       --kernel-name="$2"
}

##############################################################################
# Executes the specified NVIDIA installer script against the specified kernel,
# preventing it from doing the search-and-destroy thing.
#
function installNVIDIAsecondary()  {
    rm -f /lib/modules/$2/kernel/drivers/video/nvidia.o

    $1 --no-backup                \
       --no-network               \
       --no-precompiled-interface \
       --no-rpms                  \
       --no-runlevel-check        \
       --no-x-check               \
       --accept-license           \
       --no-questions             \
       --kernel-module-only       \
       --ui=none                  \
       --kernel-name="$2"
}

if [ $# -lt 2 ]
then
    echo Usage: $0 'officialNVIDIAinstallerScript PrimaryKernelVersion [secondaryKernelVersions ...]'
    exit 1
fi

# Do the first kernel...

installer=$1 ; shift
kernel=$1    ; shift

installNVIDIAmain $installer $kernel

# Any more?

for kernel in $@
do
    installNVIDIAsecondary $installer $kernel
done

exit 0

# Example HELP from an NVIDIA installer script:
##############################################################################
# ./NVIDIA-Linux-x86-165.33.08-pkg1.run [options]
#
# This program will install the NVIDIA Accelerated Graphics Driver for
# Linux-x86 165.33.08 by unpacking the embedded tarball and executing
# the ./nvidia-installer  installation utility.
#
# --info
#   Print embedded info (title, default target directory) and exit.
#
# --lsm
#   Print embedded lsm entry (or no LSM) and exit.
#
# --pkg-history
#   Print the package history of this file and exit.
#
# --list
#   Print the list of files in the archive and exit.
#
# --check
#   Check integrity of the archive and exit.
#
# -x, --extract-only
#   Extract the contents of ./NVIDIA-Linux-x86-165.33.08-pkg1.run, but do not
#   run 'nvidia-installer'.
#
# --add-this-kernel
#   Build a precompiled kernel interface for the currently running
#   kernel and repackage the .run file to include this newly built
#   precompiled kernel interface.  The new .run file will be placed
#   in the current directory and the string "-custom" appended
#   to its name, unless already present, to distinguish it from the
#   original .run file.
#
# --apply-patch [Patch]
#   Apply the patch 'Patch' to the kernel interface files included
#   in the .run file, remove any precompiled kernel interfaces
#   and then repackage the .run file.  The new .run file will be
#   placed in the current directory and the string "-custom"
#   appended to its name, unless already present, to distinguish it
#   from the original .run file.
#
# --keep
#   Do not delete target directory when done.
#
# --target [NewDirectory]
#   Extract contents in 'NewDirectory'
#
# The following arguments will be passed on to the ./nvidia-installer
# utility:
#
# COMMON OPTIONS:
#
#   -a, --accept-license
#       Bypass the display and prompting for acceptance of the
#       NVIDIA Software License Agreement.  By passing this option
#       to nvidia-installer, you indicate that you have read and
#       accept the License Agreement contained in the file
#       'LICENSE' (in the top level directory of the driver
#       package).
#
#   --update
#       Connect to the NVIDIA FTP server '
#       ftp://download.nvidia.com ' and determine the latest
#       available driver version.  If there is a more recent driver
#       available, automatically download and install it.  Any
#       other options given on the commandline will be passed on to
#       the downloaded driver package when installing it.
#
#   -v, --version
#       Print the nvidia-installer version and exit.
#
#   -h, --help
#       Print usage information for the common commandline options
#       and exit.
#
#   -A, --advanced-options
#       Print usage information for the common commandline options
#       as well as the advanced options, and then exit.
#
# ADVANCED OPTIONS:
#
#   -a, --accept-license
#       Bypass the display and prompting for acceptance of the
#       NVIDIA Software License Agreement.  By passing this option
#       to nvidia-installer, you indicate that you have read and
#       accept the License Agreement contained in the file
#       'LICENSE' (in the top level directory of the driver
#       package).
#
#   --update
#       Connect to the NVIDIA FTP server '
#       ftp://download.nvidia.com ' and determine the latest
#       available driver version.  If there is a more recent driver
#       available, automatically download and install it.  Any
#       other options given on the commandline will be passed on to
#       the downloaded driver package when installing it.
#
#   -v, --version
#       Print the nvidia-installer version and exit.
#
#   -h, --help
#       Print usage information for the common commandline options
#       and exit.
#
#   -A, --advanced-options
#       Print usage information for the common commandline options
#       as well as the advanced options, and then exit.
#
#   -i, --driver-info
#       Print information about the currently installed NVIDIA
#       driver version.
#
#   --uninstall
#       Uninstall the currently installed NVIDIA driver.
#
#   --sanity
#       Perform basic sanity tests on an existing NVIDIA driver
#       installation.
#
#   -e, --expert
#       Enable 'expert' installation mode; more detailed questions
#       will be asked, and more verbose output will be printed;
#       intended for expert users.  The questions may be suppressed
#       with the '--no-questions' commandline option.
#
#   -q, --no-questions
#       Do not ask any questions; the default (normally 'yes') is
#       assumed for all yes/no questions, and the default string is
#       assumed in any situation where the user is prompted for
#       string input.  The one question that is not bypassed by
#       this option is license acceptance; the license may be
#       accepted with the commandline option '--accept-license'.
#
#   -s, --silent
#       Run silently; no questions are asked and no output is
#       printed, except for error messages to stderr.  This option
#       implies '--ui=none --no-questions --accept-license'.
#
#   --x-prefix=X-PREFIX
#       The prefix under which the X components of the NVIDIA
#       driver will be installed; the default is '/usr/X11R6'
#       unless nvidia-installer detects that X.Org >= 7.0 is
#       installed, in which case the default is '/usr'.  Only under
#       rare circumstances should this option be used.
#
#   --xfree86-prefix=XFREE86-PREFIX
#       This is a deprecated synonym for --x-prefix.
#
#   --x-module-path=X-MODULE-PATH
#       The path under which the NVIDIA X server modules will be
#       installed.  If this option is not specified,
#       nvidia-installer uses the following search order and
#       selects the first valid directory it finds: 1) `X
#       -showDefaultModulePath`, 2) `pkg-config
#       --variable=moduledir xorg-server`, or 3) the X library path
#       (see the '--x-library-path' option) plus either 'modules'
#       (for X servers older than X.Org 7.0) or 'xorg/modules' (for
#       X.Org 7.0 or later).
#
#   --x-library-path=X-LIBRARY-PATH
#       The path under which the NVIDIA X libraries will be
#       installed.  If this option is not specified,
#       nvidia-installer uses the following search order and
#       selects the first valid directory it finds: 1) `X
#       -showDefaultLibPath`, 2) `pkg-config --variable=libdir
#       xorg-server`, or 3) the X prefix (see the '--x-prefix'
#       option) plus 'lib' on 32bit systems, and either 'lib64' or
#       'lib' on 64bit systems, depending on the installed Linux
#       distribution.
#
#   --opengl-prefix=OPENGL-PREFIX
#       The prefix under which the OpenGL components of the NVIDIA
#       driver will be installed; the default is: '/usr'.  Only
#       under rare circumstances should this option be used.  The
#       Linux OpenGL ABI
#       (http://oss.sgi.com/projects/ogl-sample/ABI/) mandates this
#       default value.
#
#   --opengl-libdir=OPENGL-LIBDIR
#       The path relative to the OpenGL library installation prefix
#       under which the NVIDIA OpenGL components will be installed.
#       The default is 'lib' on 32bit systems, and 'lib64' or 'lib'
#       on 64bit systems, depending on the installed Linux
#       distribution.  Only under very rare circumstances should
#       this option be used.
#
#   --installer-prefix=INSTALLER-PREFIX
#       The prefix under which the installer binary will be
#       installed; the default is: '/usr'.  Note: please use the
#       '--utility-prefix' option instead.
#
#   --utility-prefix=UTILITY-PREFIX
#       The prefix under which the NVIDIA utilities
#       (nvidia-installer, nvidia-settings, nvidia-xconfig,
#       nvidia-bug-report.sh) and the NVIDIA utility libraries will
#       be installed; the default is: '/usr'.
#
#   --utility-libdir=UTILITY-LIBDIR
#       The path relative to the utility installation prefix under
#       which the NVIDIA utility libraries will be installed.  The
#       default is 'lib' on 32bit systems, and 'lib64' or 'lib' on
#       64bit systems, depending on the installed Linux
#       distribution.
#
#   --documentation-prefix=DOCUMENTATION-PREFIX
#       The prefix under which the documentation files for the
#       NVIDIA driver will be installed.  The default is: '/usr'.
#
#   --kernel-include-path=KERNEL-INCLUDE-PATH
#       The directory containing the kernel include files that
#       should be used when compiling the NVIDIA kernel module.
#       This option is deprecated; please use
#       '--kernel-source-path' instead.
#
#   --kernel-source-path=KERNEL-SOURCE-PATH
#       The directory containing the kernel source files that
#       should be used when compiling the NVIDIA kernel module.
#       When not specified, the installer will use
#       '/lib/modules/`uname -r`/build', if that directory exists.
#       Otherwise, it will use '/usr/src/linux'.
#
#   --kernel-output-path=KERNEL-OUTPUT-PATH
#       The directory containing any KBUILD output files if either
#       one of the 'KBUILD_OUTPUT' or 'O' parameters were passed to
#       KBUILD when building the kernel image/modules.  When not
#       specified, the installer will assume that no separate
#       output directory was used.
#
#   --kernel-install-path=KERNEL-INSTALL-PATH
#       The directory in which the NVIDIA kernel module should be
#       installed.  The default value is either
#       '/lib/modules/`uname -r`/kernel/drivers/video' (if
#       '/lib/modules/`uname -r`/kernel' exists) or
#       '/lib/modules/`uname -r`/video'.
#
#   --proc-mount-point=PROC-MOUNT-POINT
#       The mount point for the proc file system; if not specified,
#       then this value defaults to '/proc' (which is normally
#       correct).  The mount point of the proc filesystem is needed
#       because the contents of '<proc filesystem>/version' is used
#       when identifying if a precompiled kernel interface is
#       available for the currently running kernel.  This option
#       should only be needed in very rare circumstances.
#
#   --log-file-name=LOG-FILE-NAME
#       File name of the installation log file (the default is:
#       '/var/log/nvidia-installer.log').
#
#   --tmpdir=TMPDIR
#       Use the specified directory as a temporary directory when
#       downloading files from the NVIDIA ftp site; if not given,
#       then the following list will be searched, and the first one
#       that exists will be used: /tmp, /tmp, ., /root/rootMOD.
#
#   -m, --ftp-mirror=FTP-MIRROR
#       Use the specified FTP mirror rather than the default '
#       ftp://download.nvidia.com ' when downloading driver
#       updates.
#
#   -l, --latest
#       Connect to the NVIDIA FTP server '
#       ftp://download.nvidia.com ' (or use the ftp mirror
#       specified with the '--ftp-mirror' option) and query the
#       most recent Linux-x86 driver version number.
#
#   -f, --force-update
#       Forces an update to proceed, even if the installer thinks
#       the latest driver is already installed; this option implies
#       '--update'.
#
#   --ui=UI
#       Specify what user interface to use, if available.  Valid
#       values for UI are 'ncurses' (the default) or 'none'. If the
#       ncurses interface fails to initialize, or 'none' is
#       specified, then a simple printf/scanf interface will be
#       used.
#
#   -c, --no-ncurses-color
#       Disable use of color in the ncurses user interface.
#
#   --no-opengl-headers
#       Normally, installation will install NVIDIA's OpenGL header
#       files.  This option disables installation of the NVIDIA
#       OpenGL header files.
#
#   --force-tls=FORCE-TLS
#       NVIDIA's OpenGL libraries are compiled with one of two
#       different thread local storage (TLS) mechanisms: 'classic
#       tls' which is used on systems with glibc 2.2 or older, and
#       'new tls' which is used on systems with tls-enabled glibc
#       2.3 or newer.  nvidia-installer will select the OpenGL
#       libraries appropriate for your system; however, you may use
#       this option to force the installer to install one library
#       type or another.  Valid values for FORCE-TLS are 'new' and
#       'classic'.
#
#   -k, --kernel-name=KERNEL-NAME
#       Build and install the NVIDIA kernel module for the
#       non-running kernel specified by KERNEL-NAME (KERNEL-NAME
#       should be the output of `uname -r` when the target kernel
#       is actually running).  This option implies
#       '--no-precompiled-interface'.  If the options
#       '--kernel-install-path' and '--kernel-source-path' are not
#       given, then they will be inferred from KERNEL-NAME; eg:
#       '/lib/modules/KERNEL-NAME/kernel/drivers/video/' and
#       '/lib/modules/KERNEL-NAME/build/', respectively.
#
#   -n, --no-precompiled-interface
#       Disable use of precompiled kernel interfaces.
#
#   --no-runlevel-check
#       Normally, the installer checks the current runlevel and
#       warns users if they are in runlevel 1: in runlevel 1, some
#       services that are normally active are disabled (such as
#       devfs), making it difficult for the installer to properly
#       setup the kernel module configuration files.  This option
#       disables the runlevel check.
#
#   --no-abi-note
#       The NVIDIA OpenGL libraries contain an OS ABI note tag,
#       which identifies the minimum kernel version needed to use
#       the library.  This option causes the installer to remove
#       this note from the OpenGL libraries during installation.
#
#   --no-rpms
#       Normally, the installer will check for several rpms that
#       conflict with the driver (specifically: NVIDIA_GLX and
#       NVIDIA_kernel), and remove them if present.  This option
#       disables this check.
#
#   -b, --no-backup
#       During driver installation, conflicting files are backed
#       up, so that they can be restored when the driver is
#       uninstalled.  This option causes the installer to simply
#       delete conflicting files, rather than back them up.
#
#   -N, --no-network
#       This option instructs the installer to not attempt to
#       connect to the NVIDIA ftp site (for updated precompiled
#       kernel interfaces, for example).
#
#   --no-recursion
#       Normally, nvidia-installer will recursively search for
#       potentially conflicting libraries under the default OpenGL
#       and X server installation locations.  With this option set,
#       the installer will only search in the top-level
#       directories.
#
#   -K, --kernel-module-only
#       Install a kernel module only, and do not uninstall the
#       existing driver.  This is intended to be used to install
#       kernel modules for additional kernels (in cases where you
#       might boot between several different kernels).  To use this
#       option, you must already have a driver installed, and the
#       version of the installed driver must match the version of
#       this kernel module.
#
#   --no-kernel-module
#       Install everything but the kernel module, and do not remove
#       any existing, possibly conflicting kernel modules.  This
#       can be useful in some DEBUG environments.  If you use this
#       option, you must be careful to ensure that a NVIDIA kernel
#       module matching this driver version is installed
#       seperately.
#
#   --no-x-check
#       Do not abort the installation if nvidia-installer detects
#       that an X server is running.  Only under very rare
#       circumstances should this option be used.
#
#   --precompiled-kernel-interfaces-path=PRECOMPILED-KERNEL-INTERFA
#   CES-PATH
#       Before searching for a precompiled kernel interface in the
#       .run file, search in the specified directory.
#
#   -X, --run-nvidia-xconfig
#       nvidia-installer can optionally invoke the nvidia-xconfig
#       utility.  This will update the system X configuration file
#       so that the NVIDIA X driver is used.  The pre-existing X
#       configuration file will be backed up.  At the end of
#       installation, nvidia-installer will ask the user if they
#       wish to run nvidia-xconfig; the default response is 'no'.
#       Use this option to make the default response 'yes'.  This
#       is useful with the '--no-questions' or '--silent' options,
#       which assume the default values for all questions.
#
#   --force-selinux=FORCE-SELINUX
#       Linux installations using SELinux (Security-Enhanced Linux)
#       require that the security type of all shared libraries be
#       set to 'shlib_t' or 'textrel_shlib_t', depending on the
#       distribution. nvidia-installer will detect when to set the
#       security type, and set it using chcon(1) on the shared
#       libraries it installs.  Use this option to override
#       nvidia-installer's detection of when to set the security
#       type.  Valid values for FORCE-SELINUX are 'yes' (force
#       setting of the security type), 'no' (prevent setting of the
#       security type), and 'default' (let nvidia-installer decide
#       when to set the security type).
#
#   --selinux-chcon-type=SELINUX-CHCON-TYPE
#       When SELinux support is enabled, nvidia-installer will try
#       to determine which chcon argument to use by first trying
#       'textrel_shlib_t', then 'texrel_shlib_t', then 'shlib_t'.
#       Use this option to override this detection logic.
#
#   --no-sigwinch-workaround
#       Normally, nvidia-installer ignores the SIGWINCH signal
#       before it forks to execute commands, e.g. to build the
#       kernel module, and restores the SIGWINCH signal handler
#       after the child process has terminated.  This option
#       disables this behavior.
#

