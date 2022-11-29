#!/bin/bash

# Constants; add more if necessary

MISSING_ARGS_MSG="Score directory missing"
ERR_MSG="not a directory"

if test $# != 1; then echo $MISSING_ARGS_MSG; exit 0; fi
if test -d $1; then
    for j in $1/*prob4-score*.txt; do
        tail --lines=+2 $j | awk -F ',' '{ 
                for (i=2;i<=NF;i++) {
                    sum+=$i*2;
                }
                if (sum >= 93) print $1 " : A";
                else if (sum >= 80) print $1 " : B";
                else if (sum >= 65) print $1 " : C";
                else print $1 " : D";
            }'
    done;

else 
    echo $1 $ERR_MSG; 
fi
exit 0
