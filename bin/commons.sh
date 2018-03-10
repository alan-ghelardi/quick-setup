#!/usr/bin/env bash

function contains() {
    echo "${1}" | grep "${2}" -q
    echo $?
}

function interpolate() {
    local placeholder=$1
    local replacement=$2
    local source=$3

    sed -e "s/{{$placeholder}}/$replacement/g" $(echo "$source")
}

function choice_list() {
    local message=$1
    local list=$2

    PS3=$message

    select answer in $list; do
        if [ -n $answer ]
        then
            echo $answerr
        fi
        break
    done
}
