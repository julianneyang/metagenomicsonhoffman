# Preprocessing metagenomics using Kraken2/Bracken pipeline


## Quickstart - Follow these instructions once installations are complete.
The following shell scripts are located in the `kraken_scripts` folder bundled with this repo.

Set up project directory like so:
```bash
project/
├── data/
│   ├── sample1_R1_001.fastq.gz
│   ├── sample1_R2_001.fastq.gz
└── run_kneaddata_pipeline.sh
└── run_kraken_pipeline.sh
└── run_bracken_pipeline.sh

```
The following works for many paired-end files in the `data` directory, as the scripts contain for loops.

Then, all you need to do is:

```bash
qsub run_kneaddata_pipeline.sh
```
```bash
qsub gzip_kneaddata_pipeline.sh
```

Run these interactively (very fast)
```bash
bash run_kraken_pipeline.sh
```

After that job is complete, do: 
```bash
bash run_bracken_pipeline.sh
```

## Installation (One time only, written mainly for myself to look back on) 

### Software versions 
- Bracken 2.9
- Kracken 2.1.6 
- Kneaddata v.10.0

### Working Directory 
```bash
/u/home/j/jpjacobs/project-jpjacobs/Julianne_Mouse_Gut_MGnify
```

### Database source 
https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/

### Decontamination of Host Sequences 
We use Biobakery kneaddata for this purpose.

```bash
qsub ../humann_scripts/run_kneaddata_mouse.sh 33_SLC_SMT_NEG_16J_S129_L005_R1_001.fastq 33_SLC_SMT_NEG_16J_S129_L005_R2_001.fastq.gz
```


### Kraken

Install Kraken database files into working directory. Download database.kraken, hash.k2d, opts.k2d, and taxo.k2d.  

```bash
wget https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/database.kraken
wget https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/hash.k2d
wget https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/opts.k2d
wget https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/taxo.k2d
```

Create a new conda env for kraken2 

```bash
conda create --name kraken2
conda activate kraken2
conda install -c bioconda kraken2=2.1.3

```

### Bracken 
Bracken is used to correct abundance estimates, because Kraken2 is biased by genome length, i.e. organisms with larger genomes will get more reads assigned to them.

Create a new conda env for bracken
```bash
conda create --name bracken
conda activate kraken2
```
Install Bracken after cloning the Github Repo
```bash
git clone https://github.com/jenniferlu717/Bracken/
bash Bracken/install_bracken.sh
export PATH="$PATH:/u/home/j/jpjacobs/project-jpjacobs/Julianne_Mouse_Gut_MGnify/Bracken/bracken"
```

Download input files required for Bracken
```bash
wget https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/seqid2taxid.map
wget https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/taxonomy/prelim_map.txt
wget https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/library/library.fna

```

Create taxonomy and library directories and move the relevant files into those directories 

Build a Bracken database 
```bash
Bracken/bracken-build -d ./ -t 8 -k 35 -l 67

``` 
Run Bracken abundance esimation
```bash
Bracken/bracken -d ./ -i kraken_report -o 33_SMT_Neg_16J.bracken -r 150
```

### Kraken Tools 
```bash
git clone https://github.com/jenniferlu717/KrakenTools
```


## Building a Nextflow pipeline - TBD

Install Nextflow into a new conda env
```bash
conda create --name nextflow_kraken_mouse
conda activate nextflow_kraken_mouse
```
```bash
conda install bioconda::nextflow
```
Grabbed the nexflow pipeline from Oxford Nanopore tech
```bash
nextflow pull epi2me-labs/wf-metagenomics
```
TBD 


## After Installation
``` 
