find . -type f \
 | file -f - \
 | sed -e 's/[[:space:]][[:space:]]*/ /g' -e 's;^\./;;' -e 's/ $//' \
 | fgrep -e 'ELF 32-bit' \
 | fgrep -e 'not stripped' \
 | word1 \
 | sed -e 's/:$//' \
 | grep -v -e '\.ao$' -e '\.lo$' -e '\.msg_ao$' -e '\.msg_lo$' -e '\.msg_o$' -e '\.msg_ro$' -e '\.msg_so$' -e '\.o$' -e '\.po$' -e '\.ro$' -e '\.so$' 
