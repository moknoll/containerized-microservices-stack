#!/bin/sh
set -e

mkdir -p /etc/nginx/certs

if [ ! -f "/etc/nginx/certs/server.crt" ]; then
    echo "Generating SSL certificate..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/certs/server.key \
        -out /etc/nginx/certs/server.crt \
        -subj "/C=FR/ST=Île-de-France/L=Paris/O=42/CN=mknoll.42.fr" \
        -addext "subjectAltName=DNS:mknoll.42.fr,DNS:localhost"
    echo "Certificate generated successfully"
fi

echo "Starting nginx..."
exec nginx -g 'daemon off;'