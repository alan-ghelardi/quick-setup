#!/usr/bin/env bash
set -eou pipefail

cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
source "$cur_dir/commons.sh"

function create_emacs_init_file() {
    local emacspeak_dir=$1
    local speech_server=$2
    cat "${cur_dir}/resources/init.el" \
        | interpolate emacspeak-dir $emacspeak_dir \
        | interpolate speech-server $speech_server \
                      > ~/.emacs.el
}

emacspeak_repo="https://github.com/tvraman/emacspeak"

emacspeak_dir="${1:-~/src}/emacspeak"

mkdir -p $emacspeak_dir

cd $emacspeak_dir

if [ ! -d .git ]
then
    git clone $emacspeak_repo .
fi

choice_list "Which version of Emacspeak would you like to install?" \
            "Latest $(git tag -l --sort -v:refname | grep -P '^\d+.\d+.\d+$')"
version=$answer

if [ $(contains $version Latest) != 0 ]
then
    git checkout $version
fi

make config && make

choice_list "Which speech server would you like to use?" "espeak outloud"
speech_server=$answer

make $speech_server

if [ $(y_or_n_question "Shall I create a basic Emacs init file for you?") == "yes" ]
then
    create_emacs_init_file $emacspeak_dir $speech_server
fi

if [ $(y_or_n_question "Would you like to start Emacs right now?") == "yes" ]
then
    emacs
fi
