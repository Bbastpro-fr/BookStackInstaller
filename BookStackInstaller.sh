#!/bin/bash


install_php(){
  echo "Install php and modules on your system ..."
  apt install -y -qq php php-common php-curl php-intl php-mbstring php-xml php-mysql php-gd php-cli php-zip php-fpm openssl git
}

install_bookstack(){
  git -C /var/www/ clone https://github.com/BookStackApp/BookStack.git --branch release --single-branch
  composer install --no-dev --working-dir=/var/www/BookStack
  mv .env /var/www/BookStack/
  php /var/www/BookStack/artisan key:generate
  php /var/www/BookStack/artisan migrate
  chown -R www-data:www-data /var/www/BookStack
  chmod -R 755 /var/www/BookStack
  mv bookstack /etc/nginx/sites-available/
  ln -s /etc/nginx/sites-available/bookstack /etc/nginx/sites-enabled/
  systemctl restart nginx.service
  rm -f /etc/nginx/sites-enabled/default
  rm -f /etc/nginx/sites-available/default
}

install_mariadb(){
  echo "Install mariadb on your system ..."
  apt install -y -qq mariadb-server
  mariadb -u root --execute="CREATE DATABASE bookstack"
  mariadb -u root --execute="CREATE USER 'bookstack_bot' IDENTIFIED BY 'RANDOMPASSWORDHEREPLEASE'"
  mariadb -u root --execute="GRANT ALL PRIVILEGES ON bookstack.* TO 'bookstack_bot'"
  mariadb -u root --execute="FLUSH PRIVILEGES"
  mysql_secure_installation
}

install_nginx(){
  echo "Install nginx on your system ..."
  apt install -y -qq nginx-full
  /etc/init.d/apache2 stop
  /etc/init.d/nginx start
}

uninstall_nginx(){
  echo "Uninstall nginx on your system ..."
  apt remove -y -qq nginx-full
  apt autoclean -y
}

uninstall_mariadb(){
  echo "Uninstall mariadb on your system ..."
  apt remove -y -qq mariadb-server
  apt autoclean -y
}

uninstall_bookstack(){
  echo "Uninstall bookstack on your system ..."
  rm -rf /var/www/BookStack
}

uninstall_php(){
  echo "Uninstall php and modules from your system ..."
  apt remove -y -qq php php-common php-curl php-intl php-mbstring php-xml php-mysql php-gd php-cli php-zip php-fpm
  apt autoclean -y
}

install(){
  install_php
  install_mariadb
  install_nginx
  install_bookstack
}

uninstall(){
  uninstall_php
  uninstall_mariadb
  uninstall_nginx
  uninstall_bookstack
}

if [ "$EUID" -ne 0 ] #Check if root
  then echo "Please run as root"
  else
    if declare -f "$1" > /dev/null
    then
      # call arguments verbatim
      "$@"
    else
      # Show a helpful error
      echo "'$1' is not a known function name" >&2
      echo "use BookStackInstaller.sh <install> or <uninstall>"
    exit 1
  fi
fi
