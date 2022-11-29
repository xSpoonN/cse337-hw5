#!/bin/bash

# Constants; add more if necessary

MISSING_ARGS_MSG="input file and  dictionary missing"
BAD_ARG_MSG_1="missing no. of characters"
BAD_ARG_MSG_2="Third argument must be an integer greater than 0"
FILE_NOT_FOUND_MSG="not a file"

index=0

if test $# -lt 2; then echo "${MISSING_ARGS_MSG}"; exit 0; fi
if test $# -lt 3; then echo "${BAD_ARG_MSG_1}"; exit 0; fi
case $3 in
[0-9]*) ;;
*) echo "${BAD_ARG_MSG_2}"; exit 0;; esac
if test $3 -le 0; then echo "${BAD_ARG_MSG_2}"; exit 0; fi
if ! test -f $1; then echo "${1} ${FILE_NOT_FOUND_MSG}"; exit 0; fi
if ! test -f $2; then echo "${2} ${FILE_NOT_FOUND_MSG}"; exit 0; fi
for i in $(sed -e 's/\(.*\)/\L\1/; s/[^a-z[:blank:]-]//g' ${1}); do
    length=$(($(echo ${i} | wc -c)-1))
    if test $length -gt 0; then index=$((${index}+1)); fi
    if test $length -eq $3; then
        d=$(egrep ${i} ${2} | wc -l)
        if test $d -eq 0; then
            echo "${i}; word position=${index}" 
        fi
    fi
done;