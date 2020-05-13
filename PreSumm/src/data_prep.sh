#!/bin/bash
#SBATCH -N 1
#SBATCH --gres=gpu:1
#SBATCH -p nlp
#SBATCH --cpus-per-task=1
#SBATCH --time=60:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=data_prep1

export CLASSPATH=/h/narora/PreSumm/src/stanford-corenlp-full-2018-10-05/stanford-corenlp-3.9.2.jar
. ../../pytorch123
module use /pkgs/environment-modules/
module load pytorch-36

#python preprocess.py -mode tokenize -raw_path ../data/raw_stories1 -save_path /scratch/gobi2/narora/data/merged_stories_tokenized1
python preprocess.py -mode format_to_bert -raw_path /scratch/gobi2/narora/data/json_data/ -save_path /scratch/gobi2/narora/data/bert_data  -lower -n_cpus 1 -log_file ../logs/preprocess.log