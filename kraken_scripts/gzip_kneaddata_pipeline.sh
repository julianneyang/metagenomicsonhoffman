#!/usr/bin/env bash
#$ -cwd
#$ -o joblog_gzip_kneaddata.$JOB_ID
#$ -j y
#$ -l h_rt=24:00:00,h_data=8G
#$ -pe shared 10

############################
# Configuration
############################

RAW_DIR=data
OUT_DIR=kneaddata

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

############################
# Run KneadData
############################


for R1 in ${RAW_DIR}/*_R1_001.fastq.gz
do
    SAMPLE=$(basename "${R1}" _R1_001.fastq.gz)

    SAMPLE_OUT=${OUT_DIR}/${SAMPLE}

	for FQ in "${SAMPLE_OUT}"/*_paired_1.fastq "${SAMPLE_OUT}"/*_paired_2.fastq
		do
    		if [[ -f "${FQ}" && ! -f "${FQ}.gz" ]]; then
        		pigz "${FQ}"
    		fi
	done
done

############################
# Job info
############################

echo
echo "Job $JOB_ID ended on: $(hostname -s)"
echo "End time: $(date)"

