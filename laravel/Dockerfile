FROM php:fpm-buster

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y less git zip default-mysql-client libmariadb-dev-compat libmariadb-dev

RUN mkdir -p /var/php-libraries/bin/

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/var/php-libraries/bin/ && \
    php -r "unlink('composer-setup.php');"

RUN mv /var/php-libraries/bin/composer.phar /var/php-libraries/bin/composer

RUN echo "export PATH=$PATH:/var/php-libraries/bin/:/root/.composer/vendor/bin/" >> /root/.bashrc

RUN source /root/.bashrc && \
    composer global require "laravel/installer=~1.1"

RUN mkdir -p /var/www/laravel/

WORKDIR /var/www/laravel/

RUN source /root/.bashrc && \
    if [ -z "$(ls -A .)" ]; then composer create-project --prefer-dist laravel/laravel laravel-project; fi;


RUN set -e

RUN chgrp www-data ./laravel-project -R

RUN chmod +775 ./laravel-project -R

#COPY docker-php-entrypoint /docker-php-entrypoint.sh

#RUN chmod +764 /docker-php-entrypoint.sh

#ENTRYPOINT ["/docker-php-entrypoint.sh"]

CMD php-fpm -F

EXPOSE 80
