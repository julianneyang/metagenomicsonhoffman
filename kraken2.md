# Preprocessing metagenomics using Kraken2/Bracken pipeline

## Installation (just the first time) 

### Database source 
https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/

### Kraken
Create a new conda env for kraken2 




Create a new conda env for bracken
```bash

```

```bash

```

### Bracken 
Bracken is used to correct abundance estimates, because Kraken2 is biased by genome length, i.e. organisms with larger genomes will get more reads assigned to them.

Install Bracken after cloning the Github Repo


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



## After Installation
``` 
