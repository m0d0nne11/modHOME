#!/bin/bash

function latLonSatURLfunc()  {
        echo "$(latLonMapURL.sh $1 $2)"'&t=h'
}

latLonSatURLfunc $1 $2
