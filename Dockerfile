# Usar la imagen base de XAMPP
FROM tomsik68/xampp:8

# Metadatos y Variables de entorno
LABEL maintainer="dbanegasl@gmail.com"

# Crear directorios y Actualizar e Instalar Dependencias
RUN apt-get update -y && \
    apt-get install -y wget php-cli php-zip unzip php-mbstring libfreetype6-dev libjpeg62-turbo-dev libpng-dev libpq-dev php-gd php-pear php-dev autoconf build-essential && \
    # Instalar Composer
    wget -O composer-setup.php https://getcomposer.org/installer && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    rm composer-setup.php && \
    # Instalar xDebug usando pecl
    pecl install xdebug && \
    # Limpiar
    apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Establecer la variable de entorno PHP_INI_SCAN_DIR para que PHP escanee el directorio adicional
ENV PHP_INI_SCAN_DIR=/opt/lampp/etc/php.d