# php7-fpm/Dockerfile
FROM php:7.2-fpm-buster

MAINTAINER Bang DAI <bdai@nrj.fr>

RUN apt-get update && apt-get install -y \
    gnupg2 \
    apt-transport-https \
    wget \
    git \
    curl \
    unzip \
    zip \
    locales \
    openssl \
    libssl-dev \
    libgmp-dev \
    libxml2-dev \
    libzip-dev zlib1g-dev chromium libicu-dev g++ \
    default-mysql-client \
    iptables

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install --no-install-recommends yarn

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV PANTHER_NO_SANDBOX 1
ENV LANG en_US.UTF-8

RUN echo "date.timezone = \"Europe/Paris\"" >> /usr/local/etc/php/conf.d/php.ini \
    && echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/php.ini \
    && rm /etc/localtime \
    && ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Remove to use custom unix socket
RUN rm /usr/local/etc/php-fpm.d/www.conf \
    && rm /usr/local/etc/php-fpm.d/zz-docker.conf

ENV NVM_DIR /usr/local/nvm
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && mkdir $NVM_DIR && curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
ENV NODE_VERSION 10.21.0
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV PHP_IDE_CONFIG="serverName=dev"
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# php extensions
RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && docker-php-ext-configure intl \
    && docker-php-ext-install gmp intl zip soap pcntl sysvsem pdo pdo_mysql \
    && pecl install mongodb-1.5.3 \
    && pecl install -o -f redis \
    && pecl install xdebug-2.6.0 \
    && docker-php-ext-enable mongodb xdebug  redis \
    && rm -rf /tmp/pear

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --version=1.6.5

RUN curl -O https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip \
    &&  unzip BrowserStackLocal-linux-x64.zip \
    &&  mv BrowserStackLocal /usr/bin/ \
    &&  chmod 777 /usr/bin/BrowserStackLocal \
    &&  rm BrowserStackLocal*

RUN adduser --system --uid 1000 --no-create-home dev --group && ln -s /var/www /home/dev && chown dev:dev /home/dev

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT	["/entrypoint.sh"]