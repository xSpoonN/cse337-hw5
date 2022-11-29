#!/bin/bash

# Constants; add more if necessary
WRONG_ARGS_MSG="data file or output file missing"
FILE_NOT_FOUND_MSG="file not found"

if test $# != 2; then echo $WRONG_ARGS_MSG; exit 0; fi
if test -f $1; then
    rm -f $2
    touch $2
    max="0"
    for i in $(awk -F ':|;|,' '{print NF}' $1); do
        if test $i -gt $max; then max=$i; fi
    done;
    for (( i = 1; i <= $max; i++ )); do
        awk -F ':|;|,' -v col=$i '{if ($col != "") sum+=$col; else sum+=0;} END{printf "Col " col " : " sum "\n"; }' $1 >> $2
    done;
else 
    name="$(basename -- $1)"
    echo "${name} ${FILE_NOT_FOUND_MSG}"; 
fi
exit 0