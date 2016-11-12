BEGIN  {
    mostFields = 0
}

{
    if( NF > mostFields )  {
        mostFields = NF
    }
    for( i = 1;  i <= NF;  ++i )  {
        width = length( $i );
        if( width > widest[ i ] )  {
            widest[ i ] = width;
        }
    }
}

END  {
    if( mostFields > 0 )  {
        printf( "{ printf( \"%%%ds", widest[ 1 ] );

        if( mostFields > 1 )  {
            for( i = 2;  i <= mostFields;  ++i )  {
                printf( " %%%ds", widest[ i ] );
            }
        }
        printf( "\\n\"" );
        for( i = 1;  i <= mostFields;  ++i )  {
            printf( ", $%d", i );
        }
        printf( " ); }\n" );
    }
}
