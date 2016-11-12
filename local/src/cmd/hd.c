/*
 * $Log:        hd.c,v $
 * Revision 1.5 Sun Mar  5 14:49:40 EST 1989
 * added -e option which forces all data to be converted.
 * This was done for use with the undump program which was
 * choking on the " - etc..." for duplicated data.
 *
 * Revision 1.4  88/10/31  16:27:56  bin
 * Arranged to intentionally set exit code - this wasn't being done.
 *
 * Revision 1.3  88/09/18  18:23:27  bin
 * Now the hex conversions produce uppercase alphabetics.
 *
 * Revision 1.2  88/07/22  17:30:20  bin
 * Just pointless cosmetic changes.
 *
 * Revision 1.1  88/03/20  14:21:12  root
 * Initial revision
 */

/*
 * Pre-RCS comment log...
 * Sun Jan 24 18:48:25 EST 1988
 *     hd.c - hexdump stdin to stdout
 *     Michael O'Donnell
 * Fri Jan 29 13:40:08 EST 1988
 *     Modified to accept command line arg "+dddd" for seeks.
 *     Should probably use hex, as well, but too lazy...
 */


#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

#ifdef  STANDALONE
#include <sys/types.h>
#include <diag/diaglib.h>
#endif  /* STANDALONE */


#define DEFAULT_REQUEST_SIZE        (16)
#define MAX_REQUEST_SIZE            (30)
#define FROM_BOF                    (0)                 /* fseek() parameter */
#define FALSE                       (0)
#define TRUE                        (!(FALSE))

unsigned char  *memPtr;                             /* Used for dumping RAM. */
unsigned int    dumpingMem;                 /* Indicates we are dumping RAM. */

/*
 * ----------------------------------------------------------------------------
 * Into a field of specified width, copy all printable sourceBytes, replacing
 * the unprintable bytes with dots and padding out the field if enough
 * sourceBytes aren't present.  Only tested with <fieldWidth> value of 16 -
 * designed with the hope that other values will work and look OK, too.
 */
static void
formatASCII( char *textByte,
             char *sourceByte,
    unsigned int   bytesPresent,
    unsigned int   fieldWidth    )
{
    unsigned char  byte;
    unsigned int   count;


    count = 0;
    while( count < bytesPresent )  {
        byte = (unsigned char)*sourceByte++;
        if(    (byte < ' ')   ||   ('~' < byte)   )  {
            byte = '.';
        }
        *textByte++ = byte;

        ++count;
    }

    while( count++ < fieldWidth )  {
        *textByte++ = ' ';
    }

    *textByte++ = 0;
}


/*
 * ----------------------------------------------------------------------------
 * sourceByte points at a field of width specified by bytesPresent, from
 * which we read and translate single binary bytes into two ASCII bytes
 * which are the hexadecimal representations of the binary bytes.  The
 * resulting ASCII bytes are to be deposited in the buffer pointed at by
 * textByte, which is fieldWidth bytes in size.  We pad the text buffer out
 * to fieldWidth with spaces if enough sourceBytes aren't present.  This
 * routine has only tested with <fieldWidth> value of 16 - it's designed
 * with the hope that other values will work and look OK, too.
 */
static void
formatHEX(   char *textByte,
             char *sourceByte,
    unsigned int   bytesPresent,
    unsigned int   fieldWidth    )
{
    unsigned int   count;
    unsigned int   half;
    unsigned char  byte;           /* Watch those high bits during shifts... */

static       char  characterFor[ 16 ] =                       /* binary->hex */
           { '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' };

    if( fieldWidth < 8 )  {
        half = fieldWidth;
    } else  {
        half = (fieldWidth - 1) >> 1;    /* pathetic attempt at optimization */
    }
    count = 0;
    while( count < bytesPresent )  {
        byte        = (unsigned char)*sourceByte++;
        *textByte++ = characterFor[ byte >> 4 ];
        *textByte++ = characterFor[ byte & 0x0f ];
        *textByte++ = ' ';
        if( count == half )  {
            *textByte++ = ' ';
        }

        ++count;
    }

    while( count < fieldWidth )  {          /* Pad out any unused locations. */
        *textByte++ = ' ';
        *textByte++ = ' ';
        *textByte++ = ' ';
        if( count == half )  {
            *textByte++ = ' ';
        }

        ++count;
    }

    *textByte = 0;                                       /* NULL terminator. */
}


/*
 * ----------------------------------------------------------------------------
 * Raw compare of the bytes at the two pointers for
 * count bytes.  Boolean return value.
 */
unsigned int
binary_equal(
             char *ptr1,
             char *ptr2,
    unsigned int   count )

{
    while( count-- )  {
        if( *ptr1++ != *ptr2++ )  {
            return( FALSE );
        }
    }
    return( TRUE );
}


/*
 * ----------------------------------------------------------------------------
 * Just copy bytes to <ptr> from stdin until <count> bytes
 * have been read or EOF.  Return number of bytes read.
 */
unsigned int
get_bytes(
    unsigned char *ptr,
    unsigned int   limit )
{
    unsigned int   count;
    unsigned int   byte;


    count = 0;
    while( count < limit )  {
        if( dumpingMem )  {
            byte = (unsigned int)*memPtr++;
        } else  {
            if(   (byte = getchar()  )  == EOF )  {
                break;
            }
        }
        *ptr++ = (unsigned char)byte;

        ++count;
    }

    return( count );
}


/*
 * ----------------------------------------------------------------------------
 * If civilized seeks don't work we can always just read 'til
 * we bleed...  Nonzero return means error or EOF.
 */
unsigned int
primitive_seek(
    unsigned long int offset )
{
    unsigned      int byte;


    while( offset-- )  {
        if(   (byte = getchar() )  == EOF )  {
            return( -1 );
        }
    }

    return( 0 );
}


/*
 * ----------------------------------------------------------------------------
 */
int main(
    int    argc,
    char **argv,
    char **envp  )
{
    unsigned            int     count;
    unsigned            int     full_disclosure;
    unsigned            int     request_count;
    unsigned    long    int     offset;
    unsigned            char   *last_ptr;
    unsigned            char   *ptr;
    unsigned            char    ascii_text[ 100 ];
    unsigned            char    hex_text[ 100 ];
    unsigned            char    inbufr0[ MAX_REQUEST_SIZE ];
    unsigned            char    inbufr1[ MAX_REQUEST_SIZE ];




    full_disclosure = FALSE;
    request_count = DEFAULT_REQUEST_SIZE;
    offset = 0L;

    if( argc > 1 )  {
        for( count = 1;   count < argc;   count++ )  {
            if( argv[ count ][ 0 ] == '+' )  {      /* Process "+ddd" seeks. */
                if( strlen( argv[ count ] )  > 1 )  {
                    offset  = atol(  &argv[ count ][ 1 ] );
                    offset -= offset % request_count;   /* Prettier display. */
                    if( !fseek( stdin, offset, FROM_BOF )  )
                    {
                        continue;
                    }
                    else if( !primitive_seek( offset )  )
                    {
                        continue;
                    }
                    else
                    {
                        fprintf( stderr, "%s: can't seek %s\n",
                                                    argv[ 0 ], argv[ count ] );
                        exit( 1 );
                    }
                }
                else
                {
                    fprintf( stderr, "%s: incomplete seek arg %s\n",
                                                    argv[ 0 ], argv[ count ] );
                    exit( 1 );

                }
            }
            if(  (argv[ count ][ 0 ] == '-')  &&
                 (argv[ count ][ 1 ] == 'e')      )         /* Process "-e". */
            {
                full_disclosure = TRUE;
                continue;
            }
            if(  (argv[ count ][ 0 ] == '-')  &&
                 (argv[ count ][ 1 ] == 'P')      )         /* Process "-P". */
            {
                if( strlen( argv[ count ] )  > 2 )  {
                    if( sscanf( &argv[ count ][ 2 ], "%x", (unsigned int)&memPtr )  != 1 )  {
                        fprintf( stderr, "%s: can't convert memPtr arg <%s\n",
                                                    argv[ 0 ], argv[ count ] );
                        exit( 1 );
                    }
                    offset = (unsigned long)memPtr;
                    dumpingMem = TRUE;
                }
                else
                {
                    fprintf( stderr, "%s: incomplete memPtr arg %s\n",
                                                    argv[ 0 ], argv[ count ] );
                    exit( 1 );

                }
                continue;
            }
            if( freopen( argv[ count ], "r", stdin )  != stdin )
            {
                fprintf( stderr, "%s: can't open() file <%s>\n",
                                                    argv[ 0 ], argv[ count ] );
                exit( 1 );
            }
        }
    }

    ptr = (unsigned char *)"aN uNlIkElY sTrInG";

    do
    {
        last_ptr = ptr;
        ptr =  (ptr == inbufr0)?  inbufr1:  inbufr0;
        count = get_bytes( ptr, request_count );
        if( !count )  {
            continue;                                  /* GOTO do-while test */
        }

        /*
         *  Here we deal with the case of the bytes we just read being
         *  the same as the bytes we read in the previous pass.  `No point
         *  in displaying a bunch of redundant information...
         *  CHANGE: full_disclosure means still go ahead and show everything.
         */
        if( !full_disclosure   &&   binary_equal( ptr, last_ptr, count )  )  {
            printf( "%08x   - etc...\n", offset );
            offset  += count;
            last_ptr = ptr;
            ptr =  ( ptr == inbufr0 )?  inbufr1:  inbufr0;
            while( count = get_bytes( ptr, request_count )  )  {
                if( binary_equal( ptr, last_ptr, count )  )  {
                    offset += count;
                    continue;
                }

                formatHEX(   hex_text,   ptr, count, request_count );
                formatASCII( ascii_text, ptr, count, request_count );
                printf( "%08x   %s  %s\n", offset, hex_text, ascii_text );
                offset += count;

                break;
            }                                                  /* End while. */

            continue;                                  /* GOTO do-while test */
        }

        formatHEX(   hex_text,   ptr, count, request_count );
        formatASCII( ascii_text, ptr, count, request_count );
        printf( "%08x   %s  %s\n", offset, hex_text, ascii_text );
        offset += count;

    } while( count );                                       /* End do-while. */

    printf( "%08x\n", offset );

    exit( 0 );
}

/* RZQ */

