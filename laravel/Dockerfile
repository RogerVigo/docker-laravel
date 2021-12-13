FROM php:fpm-buster

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y less git zip default-mysql-client libmariadb-dev-compat libmariadb-dev gnupg2

#Install extension to use mysql
RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN rm -rf /var/lib/apt/lists/ && curl -sL https://deb.nodesource.com/setup_16.x | bash -

RUN apt-get install nodejs -y

RUN mkdir -p /var/php-libraries/bin/

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/var/php-libraries/bin/ && \
    php -r "unlink('composer-setup.php');"

RUN mv /var/php-libraries/bin/composer.phar /var/php-libraries/bin/composer

ARG USER_ID
ARG GROUP_ID

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    userdel -f www-data &&\
    if getent group www-data ; then groupdel www-data; fi &&\
    groupadd -g ${GROUP_ID} www-data &&\
    useradd -l -u ${USER_ID} -g www-data www-data &&\
    install -d -m 0755 -o www-data -g www-data /home/www-data &&\
    ls /var/lib &&\
    chown --changes --silent --no-dereference --recursive \
          --from=33:33 ${USER_ID}:${GROUP_ID} \
        /home/www-data \
        /root/.composer \
        #/var/run/php-fpm \
        #/var/lib/php/sessions \
;fi

RUN mkdir -p /var/www/laravel/
RUN chown www-data:www-data /var/www/laravel/ -R

USER www-data

RUN echo "export PATH=$PATH:/var/php-libraries/bin/:/home/www-data/.composer/vendor/bin/" >> /home/www-data/.bashrc

RUN source /home/www-data/.bashrc && \
    composer global require "laravel/installer=~1.1"

WORKDIR /var/www/laravel/

RUN source /home/www-data/.bashrc && \
    if [ -z "$(ls -A .)" ]; then composer create-project --prefer-dist laravel/laravel laravel-project; fi;


#RUN set -e

#RUN chown www-data:www-data ./laravel-project -R

RUN chmod 775 ./laravel-project -R

CMD php-fpm -F

EXPOSE 80
