#!/bin/bash

docker run -d -p 3306:3306 \
    --name mysql \
    -e MYSQL_DATABASE=nodejs \
    -e MYSQL_USER=nodejs \
    -e MYSQL_PASSWORD=nodejs \
    -e MYSQL_ROOT_PASSWORD=root \
    mysql:5.7