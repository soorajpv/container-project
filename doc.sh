#!/bin/bash
#sudo docker run -t -d ubuntu
sudo docker build -t dockerfile .
image_id=$(sudo docker images | grep dockerfile | awk -F" " '{print $3}')
sudo docker run -d -p 80:80 -it $image_id
#docker_id=$(sudo docker ps -l | sed 's/\|/ /'|awk '{print $1}' | sed '1d')
#sudo docker start $docker_id
#sudo docker exec $docker_id test
#-p 8080:80
