#! /bin/bash

# Contants; add more if necessary
MISSING_ARGS_MSG="src and dest missing"
MORE_ARGS_MSG="Exactly 2 arguments required"
INVALID_SRC_MSG="src not found"

dirrec() { #workingdirectory, destdirectory
    skip="false"
    if test "$(find ${1} -maxdepth 1 -name *.c | wc -l)" -gt 3; then 
        echo "Files to be moved from ${1} to ${2}:"
        find $1 -maxdepth 1 -name *.c
        echo -n "Proceed? y/n: "
        read confirm
        if test $confirm != "y"; then skip="true"; fi
    fi
    for i in $1/*; do
        if test -d $i; then
            dirrec $i $2
        else 
            if test $skip == "false"; then 
                if echo $i | grep -Eq ^*.c$; then 
                    mkdir -p $2/$1; mv $i $2/$i
                fi
            fi
        fi
    done;
}

if test $# = 0; then echo $MISSING_ARGS_MSG; exit 1; fi
if test $# != 2; then echo $MORE_ARGS_MSG; exit 1; fi
if test -d $1; then
    rm -rf $2
    mkdir $2
    dirrec $1 $2
else echo $INVALID_SRC_MSG; fi
exit 0
