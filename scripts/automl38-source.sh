#!/bin/bash -x

# set -e

unset AUTOML
unset LD_LIBRARY_PATH

if [ -z "$AUTOML" ]; then
  # source ~/.bashrc
  export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
  # export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64:$LD_LIBRARY_PATH
  export AUTOML=1
fi

echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

conda activate automl38
python $HOME/bin/automl-test.py

