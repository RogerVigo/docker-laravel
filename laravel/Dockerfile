FROM debian:buster
SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y php7.3 less git php7.3-zip php7.3-mbstring php7.3-xml

RUN mkdir -p /var/php-libraries/bin/

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/var/php-libraries/bin/ && \
    php -r "unlink('composer-setup.php');"

RUN mv /var/php-libraries/bin/composer.phar /var/php-libraries/bin/composer

RUN echo "export PATH=$PATH:/var/php-libraries/bin/:/root/.composer/vendor/bin/" >> /root/.bashrc

RUN source /root/.bashrc && \
    composer global require "laravel/installer=~1.1"

RUN mkdir -p /var/www/laravel/

WORKDIR /var/www/laravel/

RUN source /root/.bashrc && \
    composer create-project --prefer-dist laravel/laravel laravel-project