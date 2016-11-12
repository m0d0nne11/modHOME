#!/bin/bash

function reversedHostnameTokensOf() {
	echo "$1" | tr . ' ' | fmt -1 | tac | fmt -2400
}

function reversedHostnameOf() {
	reversedHostnameTokensOf "$1" | tr ' ' .
}

( while read f; do reversedHostnameOf "${f}" ; done ) | column -t | sort -bfd | ( while read f; do reversedHostnameOf "${f}" ; done )

