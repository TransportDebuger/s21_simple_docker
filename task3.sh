#!/bin/bash
docker pull nginx
docker run -d -p 81:81 --name task3 nginx
docker cp ./fcgi-app.c task3:/etc/nginx/
docker cp ./nginx-1.conf task3:/etc/nginx/
docker exec task3 apt-get update
docker exec task3 apt-get install -y gcc spawn-fcgi libfcgi-dev
docker exec task3 gcc /etc/nginx/fcgi-app.c -o /etc/nginx/webserver -l fcgi
docker exec task3 spawn-fcgi -p 8080 /etc/nginx/webserver
docker exec task3 nginx -s reload
curl http://localhost:81/