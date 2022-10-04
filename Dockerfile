# syntax=docker/dockerfile:developement
# escape=\
FROM debian:bullseye-slim

# Fixing Non interactive 
ENV TERM=xterm 
ENV DEBIAN_FRONTEND=noninteractive
ENV PHP_VERSION=8.2.0RC3
ENV PHP_MEMORY_LIMIT=256M

#Install Basics
RUN adduser --system --no-create-home --shell /bin/false --group --disabled-login www \
    && apt update \
    && apt dist-upgrade -y \
    && apt install apt-utils curl gnupg2 ca-certificates lsb-release debian-archive-keyring software-properties-common gnupg apt-transport-https curl -y \
    && curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null \
    && curl curl -sSL -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
    && curl -sSL https://packages.sury.org/php/README.txt | bash -x \
    && echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian `lsb_release -cs` nginx" | tee /etc/apt/sources.list.d/nginx.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $key \
    && apt update \
    && apt dist-upgrade -y\
    && apt install nginx php8.2 php8.2-fpm  php8.2-cli php8.2-common vim-common vim-scripts dh-php pkg-php-tools -y 
#    && pecl install xdebug

# Security and Configuration
#RUN mkdir /root/certs/fabioschmeil.de/ \
#    && chmod 400 /root/certs/fabioschmeil.de/fabioschmeil.de.key


ENTRYPOINT [ "/etc/init.d/nginx start", "/etc/init.d/php8.2-fpm start"]
EXPOSE 9000
EXPOSE 80:8080
#EXPOSE 442
#EXPOSE 22