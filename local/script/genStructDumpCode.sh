# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#!/bin/bash

# reads lines of the form
#
#    structName memberName [memberName ...]
#
# from stdin and generates debug code that will use
# printf to dump the sizes and offsets of the members.


printf '\n#define printk printf\n\n'
printf '\n#define SHOW printk(KERN_ERR "%%s",staging)\n\n'

while read tag rest
do
    tagList="$tagList dump_$tag"
    printf "void dump_%s()\n{ /* %s %s */\n" $tag $tag "$rest"
    printf "    typedef struct %s t;\n    t s;\n    char staging[300];\n\n" $tag
    printf '    sprintf( staging, "\\n\\nSTRUCT_SIZE_%s=%%ld\\n", sizeof( struct %s ) ); SHOW;\n' $tag $tag
    for t in $rest
    do
        printf '    sprintf( staging, "  OFFSET_%s=%%ld SIZE_%s=%%ld\\n", __builtin_offsetof(t,%s), sizeof(s.%s) ); SHOW;\n' $t $t $t $t
    done
    printf "\n}\n\n"
done


printf "void dumpStructs()\n{\n"
for t in $tagList
do
    printf "    %s();\n" $t
done
printf "}\n\n"

