# Usar la imagen base de XAMPP
FROM tomsik68/xampp:8

# Metadatos y Variables de entorno
LABEL maintainer="dbanegasl@gmail.com"

# Crear directorios y Actualizar e Instalar Dependencias
RUN apt-get update -y && \
    apt-get install -y wget php-cli php-zip unzip php-mbstring libfreetype6-dev libjpeg62-turbo-dev libpng-dev libpq-dev && \
    # Instalar Composer
    wget -O composer-setup.php https://getcomposer.org/installer && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    rm composer-setup.php && \
    # Instalar Node.js
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs gcc g++ make && \
    # Instalar npm
    apt-get install -y npm || apt-get install -f -y && \
    # Limpiar
    apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configurar el entorno
EXPOSE 22 80 443 3306
VOLUME ["/www", "/opt/lampp/var/mysql"]