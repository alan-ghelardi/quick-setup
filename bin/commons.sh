#!/usr/bin/env bash

function contains() {
    echo "${1}" | grep "${2}" -q
    echo $?
}

function interpolate() {
    local placeholder=$1
    local replacement=$(echo $2 | sed 's/\//\\\//g')
    local input=${3:-$(</dev/stdin )}
    echo $input | sed -e "s/{{$placeholder}}/$replacement/g"
}

function choice_list() {
    local message=$1
    local list=$2

    PS3=$message

    select answer in $list; do
        if [ -n $answer ]
        then
            echo $answer
        fi
        break
    done
}

function y_or_n_question() {
    local question="$1 [y|n]: "
    read -p "$question" answer
    case $answer in
        y|Y )
            echo "yes"
            ;;
        * )
            echo "no"
            ;;
    esac
}
