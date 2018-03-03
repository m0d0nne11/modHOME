# hashBang line disabled to accommodate Termux's nonstandard filesystem layout...
#! /bin/bash
# PUBLIC DOMAIN
# See http://www.purposeful.co.uk/software/places2bookmarks/

IFS=$'\t\n'

conv(){
  echo "$3<DL><p>"
  sqlite3 -separator $'\t' "$1" "select moz_bookmarks.id, type, moz_bookmarks.title, url from moz_bookmarks left join moz_places on moz_bookmarks.fk=moz_places.id where parent=$2 and type in (1,2,3) order by position" | sed 's/&/\&amp;/g;s/"/\&quot;/g;s/</\&lt;/g' | while read -r id type title url
  do
    if [ "$type" = 1 ]
    then
      echo "$3  <A HREF=\"$url\">$title</A>"

    elif [ "$type" = 2 ]
    then
      echo "$3  <DT><H3>$title</H3>"
      conv "$1" "$id" "$3  "

    else
      echo "$3  <HR>"
    fi
  done
  echo "$3</DL><p>"
}

echo $'<!DOCTYPE NETSCAPE-Bookmark-file-1>\n<TITLE>Bookmarks</TITLE>\n<H1>Bookmarks</H1>'

conv "$1" 0 ''

exit

# CREATE TABLE moz_bookmarks (
#     id           INTEGER      PRIMARY KEY,
#     type         INTEGER,
#     fk           INTEGER      DEFAULT NULL,
#     parent       INTEGER,
#     position     INTEGER,
#     title        LONGVARCHAR,
#     keyword_id   INTEGER,
#     folder_type  TEXT,
#     dateAdded    INTEGER,
#     lastModified INTEGER,
#     guid         TEXT
# );

# select moz_bookmarks.id, type, moz_bookmarks.title, url from moz_bookmarks left join moz_places on moz_bookmarks.fk=moz_places.id where parent=$2 and type in (1,2,3) order by position



# A different, quick'n'dirty approach suggested on http://stackoverflow.com/questions/11769524/how-can-i-restore-firefox-bookmark-files-from-sqlite-files
#
# sqlite3 places.sqlite 'select "<a href={" || url || "}>" || moz_bookmarks.title || "</a><br/>" as ahref  from moz_bookmarks left join moz_places on fk=moz_places.id where url<>"" and moz_bookmarks.title<>""'
