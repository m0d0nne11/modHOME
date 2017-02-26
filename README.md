 This file is part of modHOME, a portable (and almost
 entirely non-invasive) home directory implementation that I
 (mod=Michael O'Donnell) sometimes inflict on systems (via
 "git clone" or tarball expansion) so that I can have familiar
 surroundings (aliases, functions, environment variables, init
 scripts, etc) that reflect my preferences.  The modHOME
 environment can be installed/initialized for any user, thus:

    cd; git clone https://github.com/m0d0nne11/modHOME

 ...or (assuming tarball available) thus:

    cd; tar xvzf modHOME.tgz

 ...followed thus:

    . modHOME/Bmod; pathPreen; rememberPATH

 Subsequent uses then require only sourcing this Bmod script:

    . modHOME/Bmod

 It should be true that this modHOME stuff can be safely left
 in place since it has essentially no (well, OK - very little...)
 effect on other users who do not explicitly put it into
 effect via the Bmod script.

 The modHOME hierarchy is usually in pristine condition
 and should technically be usable even if its contents are
 set Read-Only; local changes (if any - usually only .../PATH)
 are maintained in the parallel modHOME.custom hierarchy

 Since I generally don't leave precious files in either of
 the modHOME* hierarchies it should always be OK to delete them
 without notice if you feel the need to tidy things up, though
 it'd be good manners to talk to me first, if possible...  ;->

 REMOVAL: rm -rf ~/modHOME* should pretty much do it, though check
          for dangling symlinks in ~/. pointing into modHOME/...
 (RE)CREATING TARBALL: modHOME/modHOMEtarballUpdate.sh
 ROOT USAGE: I frequently install/use this as root in root's
             home directory but security-conscious folks will,
             of course, not just take my word for it that
             there's nothing nasty herein!  Once you've
             verified, though, you'll want to then do something
             like "chown -R 0.0 ~/modHOME*" or otherwise ensure
             that ownerships/permissions suit your circumstances.

 mod.modHOME@spineless.org
