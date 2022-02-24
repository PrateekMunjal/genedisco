#!/bin/sh 

export PYTHONPATH=$PYTHONPATH:/raid/shadab/prateek/genedisco/genedisco

gd_cache=/raid/shadab/prateek/genedisco/gd_cache
gd_out=/raid/shadab/prateek/genedisco/gd_output

mkdir -p $gd_cache
mkdir -p $gd_out

app_dir=/raid/shadab/prateek/genedisco

cd $app_dir

echo "Working from dir: "`pwd` 

date

# to ensure bitwise deterministic operations, we set buffer via CUBLAS_WORKSPACE_CONFIG

CUBLAS_WORKSPACE_CONFIG=:16:8 python3 genedisco/apps/active_learning_loop.py \
    --cache_directory=$gd_cache \
    --output_directory=$gd_out \
    --model_name="bayesian_mlp" \
    --acquisition_function_name="topuncertain" \
    --acquisition_batch_size=64 \
    --num_active_learning_cycles=8 \
    --feature_set_name="achilles" \
    --dataset_name="schmidt_2021_ifng" 

date