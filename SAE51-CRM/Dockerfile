FROM php:8.1-apache

#Mise a jour des paquets
RUN apt-get update \
    && apt-get install -y \
       libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libicu-dev \
        libxml2-dev \
        libssl-dev \
        libc-client-dev \
        libkrb5-dev \
        unzip \
        libzip-dev \
        pkg-config 
    

# Installer les extensions PHP nécessaires
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-install pdo pdo_mysql zip calendar mysqli


# Configuration de variables_order dans php.ini
RUN echo "variables_order = \"EGPCS\"" >> /usr/local/etc/php/php.ini


# Activer le module Apache mod_rewrite
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copier le fichier zip de Dolibarr dans le conteneur
COPY dolibarr-18.0.5.zip .

# Décompresser le fichier zip
RUN unzip dolibarr-18.0.5.zip \
    && rm dolibarr-18.0.5.zip

RUN mv dolibarr-18.0.5 dolibarr
# Donner les permissions nécessaires
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

#COPY Conf.php
COPY ./conf.php /var/www/html/dolibarr/htdocs/conf/conf.php

RUN rm /var/www/html/dolibarr/htdocs/conf/conf.php.example

# Redémarrer Apache pour appliquer les changements
RUN service apache2 restart


# Commande par défaut pour démarrer Apache lorsque le conteneur démarre
CMD ["apache2-foreground"]
