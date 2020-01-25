# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash
cat <<EOF
  Recovering combination from a "standard" single-dial combination lock:

    NOTE: the following assumes the lock is currently open.  If not,
    it can be opened using shim techniques described elsewhere.

    Observing through the shackle hole, watch the disks rotating as
    you turn the dial.  One will be the first disk, the middle will be
    the second and the other will be the last.  The lock opens when the
    notches in those disks are aligned such that another mechanism is
    unblocked and the shackle released.  This normally takes place out
    of sight inside the lock but if we can cause the disks to be aligned
    in plain view we can learn the relationship between the dial numbers
    and use that information to drastically shrink the number of possible
    combinations we need to try.

    The goal is therefore to align the notches (where you can see them
    while observing through the shackle hole) in each disk with each
    other by turning the dial in "normal" fashion.  In other words: after
    several clockwise spins of the dial to reset the works, continue
    turning until the first disk's notch is in plain view and note the
    number on the dial, then turn the dial left until the middle disk's
    notch is lined up with the first (which should not have moved in
    the meantime) and note that number, then turn the dial right again
    until the last notch is also aligned and note that number.

    When we know those three numbers we then also know the relationship
    between them and therefore we know the relationship between the three
    "real" numbers, which we can now quickly find because (assuming
    a standard 40-number dial) there are only 40 possible variations,
    which we print out here by cycling through them all, modulo 40.

    NOTE: modulus defaults to 40 but any number mentioned
          on the command line will override...

EOF

if [ $# -gt 0 ] ; then
    MODULUS=$1 ;
else
    MODULUS=40 ;
 fi

echo "#### MODULUS is $MODULUS ####"

read -p "Enter the 3 combo numbers that aligned the disks: " a b c
let a+=25 ; let b+=25 ; let c+=25 # Bias makes early success more likely...
x=$MODULUS ; while [ $x -gt 0 ] ; do
    printf "%2d %2d %2d\n" $[$a % $MODULUS] $[$b % $MODULUS] $[$c % $MODULUS]
    let a++ ; let b++ ; let c++ ; let x--
done

