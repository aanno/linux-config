#!/bin/bash -x

# source ~/.bashrc
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
conda activate automl38
python

