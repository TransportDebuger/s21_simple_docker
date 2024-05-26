#!/bin/bash

spawn-fcgi -p 8080 /etc/nginx/webserver
nginx -g "daemon off;"
tail -f /dev/null