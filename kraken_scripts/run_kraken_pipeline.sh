#!/usr/bin/env bash

############################
# Configuration
############################

KRAKEN_DB=/u/home/j/jpjacobs/project-jpjacobs/Julianne_Mouse_Gut_MGnify
THREADS=20

CLEAN_DIR=kneaddata
OUT_DIR=kraken

############################
# Run Kraken2
############################

mkdir -p "${OUT_DIR}"

for SAMPLE_DIR in ${CLEAN_DIR}/*
do
    SAMPLE=$(basename "${SAMPLE_DIR}")

    R1=$(ls ${SAMPLE_DIR}/*_paired_1.fastq.gz)
    R2=$(ls ${SAMPLE_DIR}/*_paired_2.fastq.gz)

    kraken2 \
        --db "${KRAKEN_DB}" \
        --threads "${THREADS}" \
        --paired \
	--gzip-compressed \
        --report "${OUT_DIR}/${SAMPLE}.report" \
        --output "${OUT_DIR}/${SAMPLE}.kraken" \
        "${R1}" "${R2}"
done

