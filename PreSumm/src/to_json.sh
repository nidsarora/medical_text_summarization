#!/bin/bash
#SBATCH -N 1
#SBATCH --gres=gpu:1
#SBATCH -p nlp
#SBATCH --cpus-per-task=1
#SBATCH --time=60:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=json_data_prep

export CLASSPATH=/h/narora/PreSumm/src/stanford-corenlp-full-2018-10-05/stanford-corenlp-3.9.2.jar
. ../../pytorch123
module use /pkgs/environment-modules/
module load pytorch-36

python preprocess.py -mode format_to_lines -raw_path /scratch/gobi2/narora/data/merged_stories_tokenized1 -save_path /scratch/gobi2/narora/data/json_data -n_cpus 1 -use_bert_basic_tokenizer false -train_path /scratch/gobi2/narora/data/merged_stories_tokenized1/train_data -valid_path /scratch/gobi2/narora/data/merged_stories_tokenized1/valid_data -test_path /scratch/gobi2/narora/data/merged_stories_tokenized1/test_data   