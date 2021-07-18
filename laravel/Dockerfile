FROM debian:buster
SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y php7.3 less git php7.3-zip php7.3-mbstring php7.3-xml

RUN mkdir -p /var/php-libraries/bin/

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
	php composer-setup.php --install-dir=/var/php-libraries/bin/ --filename=composer && \
	php -r "unlink('composer-setup.php');"

RUN echo "export PATH=$PATH:/var/php-libraries/bin/:/root/.composer/vendor/bin/" >> /root/.bashrc

RUN source /root/.bashrc && \
    composer global require "laravel/installer=~1.1"

RUN mkdir -p /var/www/laravel/

WORKDIR /var/www/laravel/

RUN source /root/.bashrc && \
    composer create-project --prefer-dist laravel/laravel laravel-project
