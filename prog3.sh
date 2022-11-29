#!/bin/bash

#Constants; add more if necessary
MISSING_ARGS_MSG="Missing data file"

if test $# == 0; then echo $MISSING_ARGS_MSG; exit 0; fi
if test -f $1; then
    weigh="${@}"
    tail --lines=+2 $1 | awk -v w="${weigh[*]}" '{ 
            split(w,weights," "); 
            for (i=2;i<=NF;i++) {
                if (weights[i] == "") { sum+=$i; wsum+=1; 
                } else { sum+=$i*weights[i]; wsum+=weights[i]; }
            }
            print sum/wsum; sum=0; wsum=0
        }' | awk '{ sum+=$1; count+=1; } END{ print int(sum/count); }'
else 
    echo $MISSING_ARGS_MSG; 
fi
exit 0