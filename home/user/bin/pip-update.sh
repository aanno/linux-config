#!/bin/bash -x
# http://stackoverflow.com/questions/2720014/upgrading-all-packages-with-pip

pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
pip2 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip2 install -U
