FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Install system dependencies + PostgreSQL + Node.js
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    zip \
    nodejs \
    npm \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

# Copy project files
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Install frontend dependencies and build assets
RUN npm install
RUN npm run build

# Expose Railway port
EXPOSE 8000

# Start Laravel
CMD php artisan storage:link || true && \
    php artisan migrate --force && \
    php artisan serve --host=0.0.0.0 --port=${PORT:-8000}