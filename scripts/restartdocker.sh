#!/bin/bash -x
sudo docker stop localDb
sudo docker rm localDb
# sudo docker pull build.flixbus.com:5003/planr/mysql-staging
sudo docker run -d -p 1234:3306 --name localDb build.flixbus.com:5003/planr/mysql-staging:latest
