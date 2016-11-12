#!/bin/bash

function latLonMapURLfunc()  {
        local lat=$1  
        local lon=$2
        echo 'http://maps.google.com/maps?saddr='"${lat}"','"${lon}"'&mrsp=0&sll='"${lat}"','"${lon}"'&z=18&sz=18'
}

read lat lon < <(echo $@ | tr '=,&' '   ' | fmt -1 | grep -v -e '[[:alpha:]]' | head -2 | fmt -2400)

latLonMapURLfunc $lat $lon
