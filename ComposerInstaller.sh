#!/bin/bash

#Script de getcomposer.org
#Récupère le fichier et l'exécute, puis place le nouveau fichier à l'emplacement /etc/bin


install(){
  echo "Install composer on your system ..."
  $(check_if_php)
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  php -r "unlink('composer-setup.php');"
  echo "Composer installed. use composer"
}

uninstall(){
  echo "Uninstall composer from your system ..."
  rm -rf /usr/bin/composer
  echo "Composer removed."
}

check_if_php(){
  REQUIRED_PKG="php"
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
  if [ "" = "$PKG_OK" ]; then
    echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
    sudo apt-get --yes install $REQUIRED_PKG
  fi
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
      echo "use ComposerInstaller.sh <install> or <uninstall>"
    exit 1
  fi
fi
