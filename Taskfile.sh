#!/usr/bin/env bash
PATH=./node_modules/.bin:$PATH

_edit() {
    _edit-file ".Taskfile"
}

_edit-local() {
    _edit-file ".Taskfile.local"
}

_edit-file() {
    local file="$1"
    # Check if the file exists, if not, create it.
    if [ ! -f "$file" ]; then
        touch "$file"
    fi
    echo "Editing $file..."
    $EDITOR "$file"
}

_help() {
    # List all tasks
    echo "$0 <task> <args>"
    echo
    echo "Tasks:"
    compgen -A function | grep -v "^_" | cat -n
    echo 
    echo "System tasks: _edit _edit-local _help"

}

_main() {
    # Load parent .Taskfile files
    IFS='/' read -ra dirs <<< "$(pwd)"
    local dir=''
    for i in "${dirs[@]}"; do
        # Skip empty directories
        [ -z "$i" ] && continue
        dir="${dir}/${i}"   

        local tfiles=("${dir}/.Taskfile" "${dir}/.Taskfile.local")
        for tf in "${tfiles[@]}"; do
            # Skip if the file doesn't exist
            [ ! -f $tf ] && continue
            echo "Using: $tf"; source "$tf"
        done
    done
    ${@:-"_help"}    
}
_main $@
