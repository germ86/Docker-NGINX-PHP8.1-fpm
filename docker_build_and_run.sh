#!/bin/env bash

docker build -t nginx-php8.2-fpm-testing-$(date +%Y%m%d) . 
docker image save nginx-php8.2-fpm-testing-$(date +%Y%m%d) -o nginx-php8.2-fpm-testing-$(date +%Y%m%d).tar
docker image load -i nginx-php8.2-fpm-testing-$(date +%Y%m%d).tar 
docker run -it nginx-php8.2-fpm-testing-$(date +%Y%m%d)

