#!/usr/bin/env bash

DB=/u/home/j/jpjacobs/project-jpjacobs/Julianne_Mouse_Gut_MGnify
READ_LEN=150
LEVEL=S   # S=species, G=genus, F=family

mkdir -p bracken

for REPORT in kraken/*.report
do
    SAMPLE=$(basename ${REPORT} .report)

    /u/home/j/jpjacobs/project-jpjacobs/Julianne_Mouse_Gut_MGnify/Bracken/bracken \
        -d ${DB} \
        -i ${REPORT} \
        -o bracken/${SAMPLE}.bracken \
        -r ${READ_LEN} \
        -l ${LEVEL}
done

