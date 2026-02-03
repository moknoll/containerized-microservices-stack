#!/bin/sh
set -e

# 1. Verzeichnisse vorbereiten
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# 2. Initialisierung (nur wenn DB noch leer ist)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    
    # DB-Dateien anlegen
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm > /dev/null

    # Temp-Datei für SQL erstellen
    tfile=`mktemp`
    if [ ! -f "$tfile" ]; then
        return 1
    fi

    # Passwörter sicher aus den Secrets lesen
    DB_ROOT_PASS=$(cat $MYSQL_ROOT_PASSWORD_FILE)
    DB_USER_PASS=$(cat $MYSQL_PASSWORD_FILE)

    # Hier wird dein SQL dynamisch generiert (mit den richtigen Variablen!)
    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$DB_USER_PASS';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF
    
    /usr/sbin/mysqld --user=mysql --bootstrap < $tfile
    rm -f $tfile
fi

exec /usr/sbin/mysqld --user=mysql --console