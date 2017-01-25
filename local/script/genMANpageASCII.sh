#!/bin/bash
#
# Use "script" to capture the ASCII output from "man" executed with
# the terminal set very wide so as to minimize hyphenation, making
# it slightly easier to reformat that output for other purposes.

[ "XXX_MIKE_DEBUG" ] && set -x

RZQlinux=$(uname -a | fgrep -i -e linux) || unset RZQlinux

    cmdFile=/tmp/GMPAtemp"$$".sh
asciiOutput=/tmp/GMPAoutput"$$".sessionLog

# We first generate a skeletal script that we'll have the
# captive shell execute...

cat > $cmdFile << EOF
#!/bin/bash
cd ~
[ -f .bashrc ] && . .bashrc

stty   columns 2400
export COLUMNS=2400

man $@ | cat
EOF

chmod +x $cmdFile

# ...launch the captive shell:

if [ "$RZQlinux" ] ; then
#   script --quiet --command "$cmdFile $@" $asciiOutput # RHEL is apparently dainbramaged
    script  -q      -c       "$cmdFile $@" $asciiOutput
else # assume: Mac OSX
    script  -q                             $asciiOutput $cmdFile $@
fi

# ...tidy the results a bit:

sed -e 's/$//' -e 's/.//g' -e 's/[[:space:]]*$//' < $asciiOutput > $cmdFile

mv        $cmdFile $asciiOutput

echo "#### OUTPUT for $@ captured in $asciiOutput"
