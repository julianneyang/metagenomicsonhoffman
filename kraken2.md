# Preprocessing metagenomics using Kraken2/Bracken pipeline

## Installation (just the first time) 

### Database source 
https://ftp.ebi.ac.uk/pub/databases/metagenomics/mgnify_genomes/mouse-gut/v1.0/kraken2_db_mouse-gut_v1.0/

### Kraken
Create a new conda env for kraken2 




Create a new conda env for bracken
```bash

```

### Bracken 
Install Bracken after cloning the Github Repo



Build a Bracken database 
```bash
Bracken/bracken-build -d ./ -t 8 -k 35 -l 67

``` 


