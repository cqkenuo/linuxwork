#!/bin/bash
if [ $# -lt 1 ]; then
    echo $0 need a parameter
    exit 0
fi

ADDR=$1
TMPSTR=`ping ${ADDR}  -c1 | grep ${ADDR} | head -n 1`
echo ${TMPSTR} | cut -d'(' -f 2 | cut -d')' -f1 

