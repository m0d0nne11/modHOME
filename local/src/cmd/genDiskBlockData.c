
#include <stdio.h>
#include <stdlib.h>

#ifdef	ENABLE_THESE_IF_NEEDED
#include <unistd.h>
#include <ctype.h>
#include <strings.h>
#endif                                      /* #ifdef ENABLE_THESE_IF_NEEDED */

/*
 * ----------------------------------------------------------------------------
 * Constant #definitions
 */
#ifdef	ENABLE_THESE_IF_NEEDED
#undef  TRUE
#undef  FALSE

#define FALSE               (0)
#define TRUE                (!(FALSE))
#endif                                      /* #ifdef ENABLE_THESE_IF_NEEDED */

typedef unsigned       char u8;
typedef   signed       char s8;
typedef unsigned short int  u16;
typedef   signed short int  s16;
typedef   signed long  int  s32;
typedef unsigned long  int  u32;
typedef long unsigned long longUlong;


/*
 * ----------------------------------------------------------------------------
 * GENERAL:
 *  - A "limit" is an asymptotic value - one which cannot be reached.
 *  - A "maximum" is the highest value which CAN be reached.
 */

/*
 * For use with one-dimensional arrays whose size is known at compile time:
 */
#define ARRAY_ELEMENT_COUNT( array ) (sizeof((array)) / sizeof(((array)[0])))
#define ARRAY_INDEX_LIMIT(   array )           ARRAY_ELEMENT_COUNT(array)
#define ARRAY_POINTER_LIMIT( array ) (&((array)[ ARRAY_INDEX_LIMIT(array) ]))
#define ARRAY_INDEX_MAX(     array )            (ARRAY_INDEX_LIMIT(array) - 1)
#define ARRAY_POINTER_MAX(   array ) (&((array)[   ARRAY_INDEX_MAX(array) ]))

/*
 * SAFE_{COPY,CAT} only usable when compiler can determine sizeof(dest)
 */
#define SAFE_COPY( dest, src )                  \
do  {                                           \
        strncpy( (dest), (src), sizeof(dest) ); \
        (dest)[ARRAY_INDEX_MAX(dest)] = 0;      \
} while( 0 )

/*
 * Efficiently append as much as possible of src onto dest
 * without overrunning it.  Not guaranteed to copy all (or
 * even any) of src, but last byte of dest is guaranteed to
 * be NULL afterwards, even if it previously wasn't.
 */
#define SAFE_CAT( dest, src )                   \
do  {                                           \
        size_t l = strlen( dest );              \
                                                \
        if( l < ARRAY_INDEX_MAX(dest) )  {      \
                strncpy( &((dest)[ l ]), (src), (ARRAY_INDEX_MAX(dest) - l)); \
        }                                       \
        (dest)[ARRAY_INDEX_MAX(dest)] = 0;      \
} while( 0 )

/*
 * Slightly less obtusely named string-match operations..
 */
#define MATCH(  x, y )    !strcmp(  (x), (y) )
#define MATCHN( x, y, n ) !strncmp( (x), (y), (n) )

/*
 * Examples of primitive (name,value) mapping
 */
typedef enum  {
	MOE,
	LARRY,
	CURLY,
} thingamajig;

typedef struct nameValueMapEntryStruct  {
    char       *name;
    thingamajig value;
} nameValueMapEntry;

#define NAME_VALUE_MAP_ENTRY( tag ) { name: #tag, value: tag }
#define BOGUS_MAP_VALUE ~0

nameValueMapEntry nameValueMap[] =  {
    NAME_VALUE_MAP_ENTRY( MOE ),
    NAME_VALUE_MAP_ENTRY( LARRY ),
    NAME_VALUE_MAP_ENTRY( CURLY ),
};

/*
 * Binary search; assumes entries are sorted by "value"
 */
char *
entryNameFor(
    u32                value )
{
    nameValueMapEntry *entry;
    signed int         lo = 0;
    signed int         hi = ARRAY_INDEX_MAX( nameValueMap );
    signed int         mid;

    while( lo <= hi ) {                               /* Trouble if unsigned */
        mid = (hi + lo) / 2;
        entry = &(nameValueMap[mid]);

        if( entry->value == value )  {
            return( entry->name );
        }
        if( entry->value > value )  {
            hi = mid - 1;
        } else  {
            lo = mid + 1;
        }
    }
    return 0;
}

/*
 * Linear search; completely unoptimized; should use a hash or something...
 */
u32
entryValueFor(
    char              *name )
{
    nameValueMapEntry *entry;

    for( entry = nameValueMap;
         entry < ARRAY_POINTER_LIMIT( nameValueMap );
         entry++ )
    {
        if( MATCH(  entry->name, name )  )  {
            return( entry->value );
        }
    }
    return( BOGUS_MAP_VALUE );                                      /* Fail. */
}

/*
 * ----------------------------------------------------------------------------
 * "map" is a pointer to an array of unsigned ints.
 * Size of that array is unspecified but is assumed
 * to be large enough to hold the necessary bits.
 */
u32
setBitMapBit(
    u32  index,
    u32 *map    )
{
    u32  bit;
    u32  field;

    bit          = 1 << (index & 0x1f);                         /* Modulo 32 */
    index      >>= 5;                                        /* Divide by 32 */
    field        = map[ index ];
    map[ index ] = field | bit;
    return( field & bit );                          /* Previous state of bit */
}

u32
clearBitMapBit(
    u32  index,
    u32 *map    )
{
    u32  bit;
    u32  field;

    bit          = 1 << (index & 0x1f);                         /* Modulo 32 */
    index      >>= 5;                                        /* Divide by 32 */
    field        = map[ index ];
    map[ index ] = field & ~bit;
    return( field & bit );                          /* Previous state of bit */
}

/*
 * A boolean function
 */
u32
bitMapBitIsSet(
    u32  index,
    u8  *map    )
{
    return( map[ index >> 5 ]  &  (1 << (index & 0x1f)) );
}

unsigned char bitmap[ 0x4000 / 8 ];

/*
 * Macro versions of above
 */
#define SET_BITMAP_BIT(    bit, map )  \
              do { (map)[  (bit) >> 5] |=  (1 << ((bit) & 0x1f));  } while( 0 )
#define CLEAR_BITMAP_BIT(  bit, map )  \
              do { (map)[  (bit) >> 5] &= ~(1 << ((bit) & 0x1f));  } while( 0 )
#define BITMAP_BIT_IS_SET( bit, map )  \
              do { ((map)[ (bit) >> 5] &   (1 << ((bit) & 0x1f))); } while( 0 )

/*
 * ----------------------------------------------------------------------------
 * Create/destroy/reverse a singly-linked list.
 */
typedef struct elementStruct  {
    struct elementStruct *next;
    int                   value;
} element;

element  rawElementPool[ 100 ];
element *elementListHead = 0;

/*
 * Return specified element to the free list.
 */
void freeElement( element *e )
{
    e->next         = elementListHead;
    elementListHead = e;
}

/*
 * Construct the free list, using the pool of raw elements.
 */
void initElements()
{
    element *e = ARRAY_POINTER_MAX(rawElementPool);

    while( e >= rawElementPool )  {
        freeElement( e-- );
    }
}

/*
 * Return each element on the specified chain to the free list.
 */
void freeChain( element *chain )
{
    element *e;

    while( chain )  {
        e     = chain->next;
        freeElement( chain );
        chain = e;
    }
}

/*
 * Allocate an element from the free list.
 */
element *newElement( void )
{
    element *e;

    e = elementListHead;
    if( e )  {
        elementListHead = e->next;
        e->next         = 0;
    }
    return( e );
}

/*
 * Construct an element chain of the specified length.
 * No way to indicate fewer available elements than
 * requested so return NULL if not enough elements.
 */
element *elementChainOf( int len )
{
    element *e;
    element *chain;

    chain = 0;
    while( len-- )  {
        e = newElement();
        if( !e )  {
            freeChain( chain );
            return( e );
        }
        e->next = chain;
        chain   = e;
    }

    return( chain );
}

/*
 * Reverse the specified chain, returning a pointer to its new anchor.
 */
element *reversedChain( element *chain )
{
    element *e;

    if( !chain || !(chain->next) )  {
        return( chain );
    }

    e                 = reversedChain( chain->next );
    chain->next->next = chain;
    chain->next       = 0;

    return( e );
}

/*
 * DEBUG - display values from the specified chain.
 */
void dumpChain( element *e )
{
    while( e )  {
        printf( " (0x%08x[%2d]->0x%08x)", e, e->value, e->next );
        e = e->next;
    }
    printf( "\n" );
}

/*
 * ***************************************************************************
 * Circular buffer with generation numbers for tracking events during debug.
 * Needs mutex or something to be thread-safe.
 */
extern void MIKE_capture_one( void *val, const char *func, int line, char *comment );
#define MIKE_CAPTURE( val, comment ) MIKE_capture_one( val, __func__, __LINE__, comment )

/*
 * ***************************************************************************
 */
#include <assert.h>

#define MIKE_INFO_SLOT_COUNT 100

typedef struct mikeInfoStruct {
	unsigned    generation;
	void       *val;
	const char *func;
	int         line;
	char       *comment;
} mikeInfo;

mikeInfo mikeInfoSlot[ MIKE_INFO_SLOT_COUNT ];
unsigned mikeBusy       = 0;
unsigned mikeRotor      = 0;
unsigned mikeGeneration = 0;

void MIKE_capture_one(
	void       *val,
	const char *func,
	int         line,
	char       *comment )
{
	mikeInfo *p;

	assert( !mikeBusy );
	mikeBusy = 1;

	p = &(mikeInfoSlot[mikeRotor]);
	mikeRotor++;
	if( mikeRotor > ARRAY_INDEX_MAX(mikeInfoSlot) ) {
		mikeRotor = 0;
	}
	p->generation = mikeGeneration++;
	p->val        = val;
	p->func       = func;
	p->line       = line;
	p->comment    = comment;

	mikeBusy = 0;
}

/*
 * ----------------------------------------------------------------------------
 * Return nonzero if an anchored scan of field matches target.
 * The NULL string is a substring of every string.
 */
int
isSubMatch(
    char *field,
    char *target )
{
    char  byteT;
    char  byteF;

    while( 1 )  {
        if( !(byteT = *(target++)) )  {
            return( 1 );
        }
        if( !(byteF = *(field++)) )  {
            return( 0 );
        }
        if( byteF != byteT )  {
            return( 0 );
        }
    }
}

/*
 * ----------------------------------------------------------------------------
 * Return nonzero if an unanchored scan of field matches target.
 * The NULL string is a substring of every string.
 */
int
isSubString(
    char *field,
    char *target )
{
    if( !(*target) )  {
        return( 1 );
    }
    while( *field )  {
        if( isSubMatch( field, target )  )  {
            return( 1 );
        }
        ++field;
    }
    return( 0 );
}

/*
 * ----------------------------------------------------------------------------
 * Structure and union templates
 */

/*
 * ----------------------------------------------------------------------------
 * Data
 */
extern               char    *optarg;
extern               int      opterr;
extern               int      optind;
extern               int      optopt;

                     char   **origArgv;
                     int      origArgc;

/*
 * ----------------------------------------------------------------------------
 */
void genDiskBlockData64(void)
{
    longUlong offset;


    offset = 0;
    do  {
        printf( "#Byte       0x%016llx#\n",      offset );
        printf( "(%29u)\n",           offset );
        offset += 64;
        printf( "#512b       0x%016llx#\n",     (offset /                 512)   );
        printf( "(%29u)\n",          (offset /                 512)   );
        offset += 64;
        printf( "#1Kb        0x%016llx#\n",     (offset /                1024)   );
        printf( "(%29u)\n",          (offset /                1024)   );
        offset += 64;
        printf( "#4Kb        0x%016llx#\n",     (offset /           (4 * 1024))  );
        printf( "(%29u)\n",          (offset /           (4 * 1024))  );
        offset += 64;
        printf( "#64Kb       0x%016llx#\n",     (offset /          (64 * 1024))  );
        printf( "(%29u)\n",          (offset /          (64 * 1024))  );
        offset += 64;
        printf( "#1Mb        0x%016llx#\n",     (offset /        (1024 * 1024))  );
        printf( "(%29u)\n",          (offset /        (1024 * 1024))  );
        offset += 64;
        printf( "#256m       0x%016llx#\n",     (offset /  (256 * 1024 * 1024))  );
        printf( "(%29u)\n",          (offset /  (256 * 1024 * 1024))  );
        offset += 64;
        printf( "#1Gb        0x%016llx#\n",     (offset / (1024 * 1024 * 1024))  );
        printf( "(%29u)\n",          (offset / (1024 * 1024 * 1024))  );
        offset += 64;
    } while ( offset );
}

void genDiskBlockData(void)
{
    longUlong offset;


    offset = 0;
    do  {
        printf( "#Byte0x%08x\n",      offset );
        printf( "(%13u)\n",           offset );
        offset += 32;
        printf( "#512b0x%08x\n",     (offset /                 512)   );
        printf( "(%13u)\n",          (offset /                 512)   );
        offset += 32;
        printf( "#1Kb 0x%08x\n",     (offset /                1024)   );
        printf( "(%13u)\n",          (offset /                1024)   );
        offset += 32;
        printf( "#4Kb 0x%08x\n",     (offset /           (4 * 1024))  );
        printf( "(%13u)\n",          (offset /           (4 * 1024))  );
        offset += 32;
        printf( "#64Kb0x%08x\n",     (offset /          (64 * 1024))  );
        printf( "(%13u)\n",          (offset /          (64 * 1024))  );
        offset += 32;
        printf( "#1Mb 0x%08x\n",     (offset /        (1024 * 1024))  );
        printf( "(%13u)\n",          (offset /        (1024 * 1024))  );
        offset += 32;
        printf( "#256m0x%08x\n",     (offset /  (256 * 1024 * 1024))  );
        printf( "(%13u)\n",          (offset /  (256 * 1024 * 1024))  );
        offset += 32;
        printf( "#1Gb 0x%08x\n",     (offset / (1024 * 1024 * 1024))  );
        printf( "(%13u)\n",          (offset / (1024 * 1024 * 1024))  );
        offset += 32;
    } while ( offset );
}

/*
 * ----------------------------------------------------------------------------
 * Data
 */
extern               char    *optarg;
extern               int      opterr;
extern               int      optind;
extern               int      optopt;

                     char   **origArgv;
                     int      origArgc;

/*
 * ----------------------------------------------------------------------------
 */
int
localMain( int    argc,
           char **argv,
           char **envp  )
{
    int showShortStyle = 1;


    optarg    = NULL;

    if( argc < 2 )  {
	fprintf( stderr, "usage:\n\t%s [-s] [-l]\n", origArgv[ 0 ]  );
	exit( 1 );
    }

    while( 1 )  {
        unsigned long int  byte;

        byte = getopt( argc, argv, "sl" );

        if( byte == -1 )  {
            break;
        }
        switch( byte )  {
        case 's': showShortStyle = 1; break;
        case 'l': showShortStyle = 0; break;          /* DEFAULT: long style */
        default:
            localMain( 1, origArgv, envp );
            exit( 1 );                                         /* NOTREACHED */
        }
    }

#ifdef	ENABLE_THESE_IF_NEEDED
    if( someKindOfProblemDeservingUsageMessageAndExit )  {
        localMain( 1, origArgv, envp );       /* Explain usage and bail out. */
    }

    srandom( time(0) * getpid() );
#endif                                      /* #ifdef ENABLE_THESE_IF_NEEDED */

    if( showShortStyle ) {
        genDiskBlockData();
    } else {
        genDiskBlockData64();
    }

    return( 0 );
}


/*
 * ----------------------------------------------------------------------------
 * So recursive calls to "main()" can work without reinvoking __main()
 */
int
main( int    argc,
      char **argv,
      char **envp  )
{
    origArgv = argv;
    origArgc = argc;

    return( localMain( argc, argv, envp )  );
}

