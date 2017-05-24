#!/bin/bash

declare -r SOURCE_CHARS='ABCD123'
declare -r DEST_CHARS='321BCDA'

function swapChars () {
	local line="$@"
	local outline=""
	local charpos=0
	local char
	local pos
    while [[ $charpos -lt ${#line} ]] ; do
        char="${line:$charpos:1}"
        pos="${SOURCE_CHARS%%$char*}"
        [[ ${#pos} -lt ${#SOURCE_CHARS} ]] && \
            [[ "$char" = "${SOURCE_CHARS:$(( ${#pos}  )):1}" ]] && \
            char="${DEST_CHARS:$(( ${#pos}  )):1}"
        outline="${outline}${char}"
        (( charpos++ ))
    done;
    echo "$outline"
}

swapChars "$@"