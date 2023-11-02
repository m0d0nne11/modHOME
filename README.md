 This file is part of modHOME, a portable (and almost entirely
 non-invasive) home directory implementation that I (mod=Michael
 O'Donnell) sometimes inflict on systems where I'll be working
 so that I can have familiar surroundings (aliases, functions,
 environment variables, init scripts, etc) that reflect my
 preferences.  The modHOME environment can be installed/initialized
 for any user, thus:

    cd && git clone https://github.com/m0d0nne11/modHOME

 ...or (assuming tarball available) thus:

    cd && tar xvzf modHOME.tgz

 ...or even just by replicating an existing modHOME hierarchy from another
 machine in your home directory as ~/modHOME.

 Subsequent uses then require only sourcing this Bmod script:

    cd && . modHOME/Bmod

 Normally, this modHOME stuff can be safely left in place since it
 has (essentially) no effect on other users who do not explicitly
 put it into effect via the Bmod script.

 Local modifications/customizations are maintained under the parallel
 modHOME.custom directory so the modHOME hierarchy is usually in pristine
 condition and should technically be usable even if its contents are
 set Read-Only; best example of a local customization would be .../PATH

 I generally don't leave precious files in the modHOME* hierarchies
 so it should always be OK to delete them without notice if you feel
 the need to tidy things up, though it'd be good manners to talk to
 me first, if possible...  ;->

 REMOVAL:

    rm -rf ~/modHOME* ~/Bmod

 should pretty much do it, though check for dangling symlinks in ~/.
 pointing into modHOME/...

 (RE)GENERATING THE TARBALL:

 A tarball of this mess can be (re)generated thus:

    cd ; modHOME/modHOMEtarballUpdate.sh

 ...though please note that since git is now the preferred method
 of propagation that script may show signs of neglect.

 ROOT USAGE: (security)

 I frequently install/use this modHOME stuff as root in root's
 home directory but security-conscious folks will, of course,
 NOT just take my word for it that there's nothing nasty herein!

 Since this mess is almost entirely scripts, though, it should
 be possible to verify that all's well, after which you'll want
 to then do something like:

    chown -R 0.0 ~/modHOME* ; chmod -R go-rwx ~/modHOME*

 ...or otherwise ensure that ownerships/permissions suit the
 circumstances and protect your godlike powers.

 Come to think of it, unless you plan to use Git to manage/
 contribute changes to this stuff, you might want to simply:

    rm -rf .git

 ...herein so as to eliminate any possible (yes, it's unlikely)
 source of unknown/unwanted material.

 mod.modHOME@spineless.org
