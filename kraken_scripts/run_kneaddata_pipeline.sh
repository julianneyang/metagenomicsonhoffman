#!/usr/bin/env bash
#$ -cwd
#$ -o joblog.$JOB_ID
#$ -j y
#$ -l h_rt=24:00:00,h_data=8G
#$ -pe shared 20

############################
# Configuration
############################

THREADS=20
RAW_DIR=data
OUT_DIR=kneaddata

REF_DB=/u/project/jpjacobs/jpjacobs/kneaddata_mouse_genome
TRIMMOMATIC=/u/home/j/jpjacobs/.conda/envs/kneaddata/share/trimmomatic-0.39-2

############################
# Job info
############################

echo "Job $JOB_ID started on: $(hostname -s)"
echo "Start time: $(date)"
echo

############################
# Environment
############################

. /u/local/Modules/default/init/modules.sh
module load anaconda3
conda activate kneaddata

############################
# Run KneadData
############################

mkdir -p "${OUT_DIR}"

for R1 in ${RAW_DIR}/*_R1_001.fastq.gz
do
    SAMPLE=$(basename "${R1}" _R1_001.fastq.gz)
    R2=${RAW_DIR}/${SAMPLE}_R2_001.fastq.gz

    SAMPLE_OUT=${OUT_DIR}/${SAMPLE}
    mkdir -p "${SAMPLE_OUT}"

    kneaddata \
        --input "${R1}" \
        --input "${R2}" \
        --reference-db "${REF_DB}" \
        --output "${SAMPLE_OUT}" \
        --trimmomatic "${TRIMMOMATIC}" \
        --threads "${THREADS}" \
        --bowtie2 /u/home/j/jpjacobs/.conda/envs/humannandmetaphlan/bin/
done

############################
# Gzip paired outputs
############################

for FQ in "${SAMPLE_OUT}"/*_paired_1.fastq "${SAMPLE_OUT}"/*_paired_2.fastq
do
    if [[ -f "${FQ}" && ! -f "${FQ}.gz" ]]; then
        gzip "${FQ}"
    fi
done

############################
# Job info
############################

echo
echo "Job $JOB_ID ended on: $(hostname -s)"
echo "End time: $(date)"

