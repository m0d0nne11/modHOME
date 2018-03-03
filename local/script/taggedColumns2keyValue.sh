# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash

# m0d0nne11@mitll 20160802
# Given a text file representing data where the first line is a
# series of column-tags (i.e. the keys) and the remaining lines
# are textual representations (no embedded spaces!  Also, embedded
# equals signs confuse things...) of corresponding values in the
# implied columnar format, we convert things to a key=value type
# of presentation, so this:
#
# key1     key2     key3
# key1val1 key2val1 key3val1
# key1val2 key2val2 key3val2
# key1val3 key2val3 key3val3
#
# ...becomes this:
#
# key1=key1val1
# key2=key2val1
# key3=key3val1
#
# key1=key1val2
# key2=key2val2
# key3=key3val2
#
# key1=key1val3
# key2=key2val3
# key3=key3val3
#

tempFile=/tmp/Columns2keyValueTEMP$$

cat > ${tempFile}

keyList="$(sed -n -e 1p < ${tempFile} | fmt -1 | sed -e 's/$/=/')"

sed -e 1d < ${tempFile} | while read vals ; do paste <(echo "${keyList}") <(echo $vals | fmt -1) | lineupequals ; echo ; done

rm -f ${tempFile}

exit

