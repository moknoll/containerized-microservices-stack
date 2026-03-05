#!/bin/bash

# Create secrets directory in main project folder
mkdir -p ./secrets

# Generate secure random passwords (OpenSSL)
openssl rand -base64 18 > ./secrets/mysql_root_password.txt
openssl rand -base64 18 > ./secrets/mysql_password.txt
cp ./secrets/mysql_password.txt ./secrets/wp_db_password.txt
openssl rand -base64 18 > ./secrets/wp_admin_password.txt

# Restrict access to secrets (owner only)
chmod 600 ./secrets/*.txt

# Create .env file in srcs directory
cat > ./srcs/.env <<'EOF'
WORDPRESS_DB_HOST=mariadb
WORDPRESS_DB_USER=wp_user
WORDPRESS_DB_NAME=wordpress
MYSQL_DATABASE=wordpress
MYSQL_USER=wp_user
WP_ADMIN_USER=moritz
WP_ADMIN_EMAIL=moritz@inception.local
EOF

# Add secrets and .env to .gitignore (in main project folder)
cat > ../.gitignore <<'EOF'
/secrets/
/srcs/.env
.DS_Store
*/.DS_Store
/srcs/web/
EOF