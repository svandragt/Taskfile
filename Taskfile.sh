#!/usr/bin/env bash
PATH=./node_modules/.bin:$PATH

edit() {
    # Edit existing .Taskfile or this script.
    file=".Taskfile"
    if [ ! -f "$file" ]; then
        file="$0"
    fi
    echo "Editing $file..."
    $EDITOR "$file"
}

help() {
    # List all tasks
    echo "$0 <task> <args>"
    echo "Tasks:"
    compgen -A function | grep --invert-match "_" | cat -n
}

_main() {
    # Load parent .Taskfile files
    IFS='/' read -ra dirs <<< "$(pwd)"
    dir=''
    for i in "${dirs[@]}"; do
        # Skip empty directories
        [ -z "$i" ] && continue
        dir="${dir}/${i}"   

        tfiles=("${dir}/.Taskfile" "${dir}/.Taskfile.local")
        for tf in "${tfiles[@]}"; do
            # Skip if the file doesn't exist
            [ ! -f $tf] && continue
            echo "Using: $tf"; source "$tf"
        done
    done
    echo

    ${@:-help}    
}
_main $@
