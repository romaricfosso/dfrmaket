#!/bin/bash
set -e

echo "Démarrage du déploiement WordPress..."

# Configuration de la région AWS
export AWS_DEFAULT_REGION="eu-west-1"

# Installation de jq pour parser le JSON
yum install -y jq

# Mise à jour et installation des paquets nécessaires
echo "Installation des packages nécessaires..."
yum update -y
amazon-linux-extras enable php8.0
yum install -y php php-mysqlnd httpd wget unzip mariadb jq

# Démarrage des services
echo "Démarrage du service Apache..."
systemctl enable httpd
systemctl start httpd

# Récupération des secrets
echo "Récupération des credentials depuis AWS Secrets Manager..."
SECRET_ID="${DB_NAME}-credentials-1"
SECRET_VALUE=$(aws secretsmanager get-secret-value --secret-id "$SECRET_ID" --query SecretString --output text)

# Extraction des variables du JSON
DB_NAME=$(echo "$SECRET_VALUE" | jq -r '.dbname')
DB_USER=$(echo "$SECRET_VALUE" | jq -r '.username')
DB_PASSWORD=$(echo "$SECRET_VALUE" | jq -r '.password')
DB_HOST=$(echo "$SECRET_VALUE" | jq -r '.host')

# Debug
echo "✅ DB_NAME=$DB_NAME"
echo "✅ DB_USER=$DB_USER"
echo "✅ DB_HOST=$DB_HOST"

# Vérification
if [[ -z "$DB_NAME" || -z "$DB_USER" || -z "$DB_PASSWORD" || -z "$DB_HOST" ]]; then
  echo "❌ Erreur : variables de base de données manquantes"
  exit 1
fi

echo "Informations de base de données récupérées avec succès."

# Téléchargement de WordPress
echo "Téléchargement et installation de WordPress..."
wget https://wordpress.org/latest.zip -P /tmp
unzip /tmp/latest.zip -d /tmp
cp -r /tmp/wordpress/* /var/www/html/

# Attribution des permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Configuration de WordPress
echo "Configuration de WordPress..."
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/wp-config.php
sed -i "s/localhost/$DB_HOST/" /var/www/html/wp-config.php

# Configuration des clés de sécurité WordPress
echo "Configuration des clés de sécurité..."
SALT=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
sed -i "/AUTH_KEY/d" /var/www/html/wp-config.php
sed -i "/SECURE_AUTH_KEY/d" /var/www/html/wp-config.php
sed -i "/LOGGED_IN_KEY/d" /var/www/html/wp-config.php
sed -i "/NONCE_KEY/d" /var/www/html/wp-config.php
sed -i "/AUTH_SALT/d" /var/www/html/wp-config.php
sed -i "/SECURE_AUTH_SALT/d" /var/www/html/wp-config.php
sed -i "/LOGGED_IN_SALT/d" /var/www/html/wp-config.php
sed -i "/NONCE_SALT/d" /var/www/html/wp-config.php

echo "$SALT" >> /var/www/html/wp-config.php
echo "OK" > /var/www/html/healthcheck.html

# Nettoyage
echo "Nettoyage des fichiers temporaires..."
rm -rf /tmp/wordpress /tmp/latest.zip

# Redémarrage du serveur web
echo "Redémarrage du serveur web..."
systemctl restart httpd

echo "Déploiement WordPress terminé avec succès!"