#!/bin/bash -x

sudo systemctl daemon-reload
sudo systemctl restart local-fs.target
sudo systemctl restart remote-fs.target

