#!/bin/bash

# Wait until WordPress is accessible
echo "Waiting for WordPress to be available..."
until curl -s http://localhost:8080/wp-admin/install.php &> /dev/null
do
  sleep 5
  echo "..."
done

echo "WordPress is accessible, proceeding with setup..."

# Run WordPress CLI commands inside the container

docker exec wordpress curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&
docker exec wordpress chmod +x wp-cli.phar &&
docker exec wordpress mv wp-cli.phar /usr/local/bin/wp

docker exec wordpress wp core install \
  --url="http://localhost:8080" \
  --title="My WordPress Site" \
  --admin_user="test" \
  --admin_password="test" \
  --admin_email="test@test.com" \
  --skip-email \
  --allow-root

# Append custom code into functions.php
docker exec wordpress /custom-functions/install.sh

# Create post category
docker exec wordpress wp term create category piulada --allow-root
 
# Create some posts
docker exec wordpress wp post create --allow-root --post_type=post --post_status=publish --post_title='Balandrau' --post_content="Balandrau" --post_category="piulada" --meta_input='{"lat":"42.369949953134366","lng":"2.2196442967547165"}'
docker exec wordpress wp post create --allow-root --post_type=post --post_status=publish --post_title='Aneto' --post_content="Aneto" --post_category="piulada" --meta_input='{"lat":"42.63089966977185","lng":"0.656174006128023"}'
docker exec wordpress wp post create --allow-root --post_type=post --post_status=publish --post_title="Pica d'Estats" --post_content="Pica d'Estats" --post_category="piulada" --meta_input='{"lat":"42.66689037852365","lng":"1.3979348714672448"}'

# Create the page that displays the piulades
docker exec wordpress wp post create --allow-root --post_type=page --post_status=publish --post_title="Totes les piulades" --post_content="[map_with_markers]"

# Install the advanced custom fields, so the editor can show lat,lng fields
docker exec wordpress wp plugin install /plugins/advanced-custom-fields.zip --activate --allow-root

echo "WordPress setup completed successfully! You can find the page here: http://localhost:8080/?page_id=7"