#!/usr/bin/env bash
set -eou pipefail

cur_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
source "$cur_dir/commons.sh"

function create_emacs_init_file() {
    local emacspeak_dir=$1
    local speech_server=$2

    cat $cur_dir/resources/init.el \
        | interpolate emacspeak_dir $emacspeak_dir \
        | interpolate speech_server $speech_server |
        > .emacs.el
}

emacspeak_repo="https://github.com/tvraman/emacspeak"

emacspeak_dir="~/srcemacspeak"

mkdir -p $emacspeak_dir

cd $emacspeak_dir

git clone $emacspeak_repo .

choice_list "Which version of Emacspeak would you like to install?" \
            "Latest $(git tag -l --sort -v:refname | grep -P '^\d+.\d+.\d+$')"
version=$answer

if [ $(contains $version Latest) != 0 ]
then
    git checkout $version
fi

make config

make

choice_list "Which speech server would you like to use?" "espeak outloud"
speech_server=$answer

make $speech_server

create_emacs_init_file $emacspeak_dir $speech_server

emacs
