#!/bin/sh

echo '>>> start container and get id'
CID=$(docker run -d -p 2222:22 -p 8080:80 -p 3306:3306 -v $2:/$1.sql wnameless/mysql-phpmyadmin)
echo $CID
sleep 5

echo '>>>Create Database'
docker exec -t -i $CID mysql -uroot -e "create database $1"

echo '>>>import Data'
docker exec -t -i $CID mysql -uroot -e "use $1;source /$1.sql;"