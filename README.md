# Taskfile

This is a task runner using taskfiles containing bash functions. See https://github.com/adriancooney/Taskfile for the original project. It's a nicer menu and shorthand for sourcing a bash file with functions.

This repository contains the runner `Taskfile.sh` for getting started in your own projects. It runs task files, a bash (or zsh etc.) script that contains functions that can be called via the runner. The runner detects any task files in the current, parent, grandparent etc directory  of the directory you're in. These must be called `.Taskfile` or `.Taskfile.local`. The difference is only in that the former should be added to a project's version control, and the latter should be added to `.gitignore`.

The `Taskfile.sh` in this repository, when added to a directory in your PATH, contains the runner and help function which lists all the detected tasks.

An example `.Taskfile` could look like this:

```sh
# Example taskfile
sw() {
  # git fuzzy branch switcher.
  git switch $(git branch | grep $1 | head -n1)
}
```

And to run a task:


    $ t sw CSW-22
    Using: $HOME/.Taskfile
    Using: $HOME/dev/.Taskfile
     
    Switched to branch 'feature/CSW-22-automatic-language-redirection'
    Your branch is up to date with 'origin/feature/CSW-22-automatic-language-redirection'.
    Task completed in 0m0.043s


## Install

To "install", git clone this repo and add a alias to `Taskfile.sh`.
```
$ git clone https://github.com/svandragt/Taskfile && cd Taskfile
$ echo "alias t='/path/to/Taskfile.sh'" >> ~/.bashrc && source ~/.bashrc
$ t
```

## Usage

Create a new `.Taskfile` (shorthand `t _edit`). Edit it with your favourite editor and add your tasks.

To view available tasks, use `t` (which calls the `_help` task):

    $ t
    Using: $HOME/dev/.Taskfile
    $HOME/dev/shell/Taskfile/Taskfile.sh <task> <args>
    
    Tasks:
         1 sw
    
    System tasks: _edit _edit-local _help

