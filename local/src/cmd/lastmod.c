/*
 * Many other Linux enthusiasts besides myself have mentioned
 * having the same trouble that I am having - so much is happening
 * on tsx-11 that we are unable to keep up with all the activity!!!
 * I hope you will therefore consider this humble suggestion to
 * use this program in the FTP hierarchy every night as follows:
 *
 *     find pub/linux -print | thisProgram >pub/linux/fileTimes
 *
 * Anyone could then grab a copy of that output file and easily
 * determine (by sorting) which files have changed most recently.
 *
 * Thank you.
 *
 * ------------------------------------------------------------------
 * Michael O'Donnell     mod@westford.ccur.com     uunet!masscomp!mod
 * Concurrent Computer Corporation     Westford, MA     (508)392-2915
 * ------------------------------------------------------------------
 */

/* #define __USE_LARGEFILE64 */
#define _GNU_SOURCE

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>
#include <string.h>

main(
    int         argc,
    char      **argv	)
{
    struct tm  *time;
    struct stat status;
    char        buffer[ 10008 ];
    size_t      len;


    while( fgets( buffer, 10000, stdin )  )  {
        len = strlen( buffer );
        if( len )  {
            if( buffer[ len - 1 ] == '\n' )  {
                buffer[ len - 1 ] = 0;
            }
        }
        if(     (stat( buffer, &status )  == -1)
            && (lstat( buffer, &status )  == -1)  )
        {
            fprintf( stdout, " ## Can't [l]stat() <%s>\n", buffer );
            continue;
        }

        time = gmtime( &(status.st_mtime)  );
        printf( "%010u %04d/%02d/%02d %02d:%02d:%02d %s\n",
                 status.st_size,  (time->tm_year + 1900),
                 time->tm_mon + 1, time->tm_mday,
                 time->tm_hour,    time->tm_min,
                 time->tm_sec,     buffer                     );
    }

    return( 0 );
}

