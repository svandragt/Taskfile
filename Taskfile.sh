#!/usr/bin/env bash
PATH=./node_modules/.bin:$PATH

_await-docker() {
    until docker ps; do
	echo -n . && sleep 1
    done
}

edit() {
    edit-file ".Taskfile"
}

edit-local() {
    edit-file ".Taskfile.local"
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
            [ ! -f $tf ] && continue
            echo "Using: $tf"; source "$tf"
        done
    done
    ${@:-"_help"}    
}
_main $@
