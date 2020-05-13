#!/bin/bash
#SBATCH -N 1
#SBATCH --gres=gpu:2
#SBATCH -p nlp
#SBATCH --cpus-per-task=1
#SBATCH --time=60:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=finetune

export CLASSPATH=/h/narora/PreSumm/src/stanford-corenlp-full-2018-10-05/stanford-corenlp-3.9.2.jar
. ../../pytorch123
module use /pkgs/environment-modules/
module load pytorch-36

python train.py  -task abs -mode train -bert_data_path /scratch/gobi2/narora/data/bert_data/ -dec_dropout 0.2  -model_path /scratch/gobi2/narora/models/bert_abs_new -sep_optim true -lr_bert 0.002 -lr_dec 0.2 -save_checkpoint_steps 2000 -batch_size 140 -train_steps 200000 -report_every 50 -accum_count 5 -use_bert_emb true -use_interval true -warmup_steps_bert 20000 -warmup_steps_dec 10000 -max_pos 512 -visible_gpus 1  -log_file /scratch/gobi2/narora/logs/bert_abs_new
#python train.py  -task abs -mode train -bert_data_path /scratch/gobi2/narora/data/bert_data/ -dec_dropout 0.2  -model_path /scratch/gobi2/narora/models/bert_ext_abs_medqa -sep_optim true -lr_bert 0.002 -lr_dec 0.2 -save_checkpoint_steps 2000 -batch_size 140 -train_steps 200000 -report_every 50 -accum_count 5 -use_bert_emb true -use_interval true -warmup_steps_bert 20000 -warmup_steps_dec 10000 -max_pos 512 -visible_gpus 1 -log_file /scratch/gobi2/narora/logs/bert_ext_abs  -load_from_extractive /scratch/gobi2/narora/models/bert_ext_medqa/model_step_50000.pt   