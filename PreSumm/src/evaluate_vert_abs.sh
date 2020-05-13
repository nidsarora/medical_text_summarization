#!/bin/bash
#SBATCH -N 1
#SBATCH --gres=gpu:2
#SBATCH -p nlp
#SBATCH --cpus-per-task=1
#SBATCH --time=60:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=evaluate_abs

export CLASSPATH=/h/narora/PreSumm/src/stanford-corenlp-full-2018-10-05/stanford-corenlp-3.9.2.jar
. ../../pytorch123
module use /pkgs/environment-modules/
module load pytorch-36
pyrouge_set_rouge_path /h/narora/PreSumm/pyrouge/tools/ROUGE-1.5.5

python train.py -task abs -mode validate -batch_size 3000 -test_batch_size 500 -bert_data_path /scratch/gobi2/narora/data/bert_data/ -log_file /scratch/gobi2/narora/logs/val_abs_bert_medqa -model_path /scratch/gobi2/narora/models/bert_abs_medqa -sep_optim true -use_interval true -visible_gpus 1 -max_pos 512 -max_length 200 -alpha 0.95 -min_length 50 -result_path  /scratch/gobi2/narora/logs/val_abs_bert_medqa_results
#python train.py -task abs -mode validate -batch_size 3000 -test_batch_size 500 -bert_data_path /scratch/gobi2/narora/data/bert_data/ -log_file ../logs/bert_abs_medqa_val -model_path /scratch/gobi2/narora/models/bert_abs_medqa -sep_optim true -use_interval true -visible_gpus 1 -max_pos 512 -max_length 200 -alpha 0.95 -min_length 50 -result_path ../logs/bert_abs_medqa_val 
#python train.py -task abs -mode validate -batch_size 3000 -test_batch_size 500 -bert_data_path /scratch/gobi2/narora/data/bert_data/ -log_file /scratch/gobi2/narora/logs/bert_ext_abs_medqa -model_path /scratch/gobi2/narora/models/bert_ext_abs_medqa -sep_optim true -use_interval true -visible_gpus 1 -max_pos 512 -max_length 200 -alpha 0.95 -min_length 50 -result_path /scratch/gobi2/narora/logs/bert_ext_abs_medqa