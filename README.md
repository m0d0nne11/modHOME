 This file is part of modHOME, a portable (and almost entirely
 non-invasive) home directory implementation that I (mod=Michael
 O'Donnell) sometimes inflict on systems where I'll be working
 so that I can have familiar surroundings (aliases, functions,
 environment variables, init scripts, etc) that reflect my
 preferences.  The modHOME environment can be installed/initialized
 for any user, thus:

    cd; git clone https://github.com/m0d0nne11/modHOME

 ...or (assuming tarball available) thus:

    cd; tar xvzf modHOME.tgz

 ...followed thus:

    . modHOME/Bmod; pathPreen; rememberPATH

 Subsequent uses then require only sourcing this Bmod script:

    . modHOME/Bmod

 ...or if you first do this:

    cd ; ln -s modHOME/Bmod Bmod

 ...you'll subsequently be able to do this:

    . Bmod

 ...saving yourself YUUUUUGE amounts of typing.  Huge!

 Normally, this modHOME stuff can be safely left in place since it
 has (essentially) no effect on other users who do not explicitly
 put it into effect via the Bmod script.

 Since local modifications/customizations are maintained under the
 parallel modHOME.custom directory the modHOME hierarchy is usually
 in pristine condition and should technically be usable even if its
 contents are set Read-Only; best example of a local customization
 would be .../PATH

 Since I generally don't leave precious files in the modHOME*
 hierarchies it should always be OK to delete them without notice
 if you feel the need to tidy things up, though it'd be good manners
 to talk to me first, if possible...  ;->

 REMOVAL:

    rm -rf ~/modHOME* ~/Bmod

 should pretty much do it, though check for dangling symlinks in ~/.
 pointing into modHOME/...

 (RE)CREATING TARBALL:

    modHOME/modHOMEtarballUpdate.sh

 ...though please note that since git is now the preferred method
 of propagation that script may possibly show signs of neglect.

 ROOT USAGE:

 I frequently install/use this modHOME stuff as root in root's
 home directory but security-conscious folks will, of course,
 not just take my word for it that there's nothing nasty herein!
 Once you've satisified yourself that all's well, though, you'll
 want to then do something like:

    chown -R 0.0 ~/modHOME*

 ...or otherwise ensure that ownerships/permissions suit the
 circumstances and protect your godlike powers.

 mod.modHOME@spineless.org
