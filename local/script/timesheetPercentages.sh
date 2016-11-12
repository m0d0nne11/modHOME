declare -a dataBase=("")

# Program number/percentage/description

dataBase=(
    "1904_12  0.10 MADL"
    "2090_11  0.05 ATHENA"
    "2120_11  0.05 ATDL"
    "2180_11  0.25 FAB-T"
    "2360_11  0.20 ACEnet"
    "2430_11  0.05 MIDS-JTRS"
    "2550_11  0.05 ComNtwkg4airDominance"
    "2560_11  0.20 DTCN"
    "2575_421 0.05 HCBdesign"
)

###############################################################################
#
function mathFunc()  {
    local x

    while read x ; do
        echo "$x" = $(echo "$x" | bc -l)
    done
}

###############################################################################
#
function timesheetPercentagesFor()  {
    local index;
    local row;

    index=0;
    while [ $index -lt ${#dataBase[*]} ]; do      # Until indexLimit reached...
        row=(${dataBase[$index]});              # Index the database for a row.
        echo "$(echo "${row[1]} * $1" | mathFunc)" hours ${row[0]} ${row[2]}
        let index++
    done
}

if [ $# -lt 1 ] ; then
	echo Usage: $0 hours
	exit 1
fi

timesheetPercentagesFor $1

cat <<EOF

Example for 5 days:                    Example for 4 days:
 4.00 hrs 1904_12 MADL                  3.00 hrs 1904_12 MADL
 2.00 hrs 2090_11 ATHENA                1.50 hrs 2090_11 ATHENA
 2.00 hrs 2120_11 ATDL                  2.00 hrs 2120_11 ATDL
10.00 hrs 2180_11 FAB-T                 7.50 hrs 2180_11 FAB-T
 8.00 hrs 2360_11 ACEnet                6.00 hrs 2360_11 ACEnet
 2.00 hrs 2430_11 MIDS-JTRS             2.00 hrs 2430_11 MIDS-JTRS
 2.00 hrs 2550_11 ComNtwkg4airDominance 2.00 hrs 2550_11 ComNtwkg4airDominance
 8.00 hrs 2560_11 DTCN                  6.00 hrs 2560_11 DTCN
 2.00 hrs 2575_421 HCBdesign            2.00 hrs 2575_421 HCBdesign

Example for 3 days:                    Example for 2 days:
 2.50 hrs 1904_12 MADL                  1.50 hrs 1904_12 MADL
 1.00 hrs 2090_11 ATHENA                1.00 hrs 2090_11 ATHENA
 1.00 hrs 2120_11 ATDL                  1.00 hrs 2120_11 ATDL
 6.25 hrs 2180_11 FAB-T                 3.75 hrs 2180_11 FAB-T
 5.00 hrs 2360_11 ACEnet                3.00 hrs 2360_11 ACEnet
 1.00 hrs 2430_11 MIDS-JTRS             1.00 hrs 2430_11 MIDS-JTRS
 1.00 hrs 2550_11 ComNtwkg4airDominance 0.75 hrs 2550_11 ComNtwkg4airDominance
 5.00 hrs 2560_11 DTCN                  3.00 hrs 2560_11 DTCN
 1.25 hrs 2575_421 HCBdesign            1.00 hrs 2575_421 HCBdesign

Example for 1 day:                     3.5 days(28 hrs)[any two 1.5s S/B 1.25]
 0.75 hrs 1904_12 MADL                  2.75 hrs 1904_12 MADL
  .50 hrs 2090_11 ATHENA                1.50 hrs 2090_11 ATHENA
  .25 hrs 2120_11 ATDL                  1.50 hrs 2120_11 ATDL
 2.00 hrs 2180_11 FAB-T                 7.00 hrs 2180_11 FAB-T
 2.00 hrs 2360_11 ACEnet                5.50 hrs 2360_11 ACEnet
  .25 hrs 2430_11 MIDS-JTRS             1.50 hrs 2430_11 MIDS-JTRS
  .25 hrs 2550_11 ComNtwkg4airDominance 1.50 hrs 2550_11 ComNtwkg4airDominance
 1.50 hrs 2560_11 DTCN                  5.75 hrs 2560_11 DTCN
  .50 hrs 2575_421 HCBdesign            1.50 hrs 2575_421 HCBdesign

Example for 4.5 days:
-3.50 hrs 1904_12 MADL
 4.50 hrs 2180_11 FAB-T
-2.00 hrs 2550_11 ComNtwkg4airDominance
 2.00 hrs 2575_421 HCBdesign
 4.00 hrs 2180_11 FAB-T
-7.00 hrs 2360_11 ACEnet
 1.00 hrs 2430_11 MIDS-JTRS
-2.00 hrs 2090_11 ATHENA
 2.00 hrs 2120_11 ATDL
 1.00 hrs 2430_11 MIDS-JTRS
-7.00 hrs 2560_11 DTCN
EOF
