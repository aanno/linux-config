#!/bin/bash -x

# https://github.com/compose-x/ecs_composex/
conda deactivate
source /home/tpasch/dev/venv/composex/bin/activate
which ecs-compose-x
ecs-compose-x -h
