function 1wordPerLineFunc() { rq ' ' | eat | fmt -1 | sed -e 's/^ //' | cat -s ; }

1wordPerLineFunc
