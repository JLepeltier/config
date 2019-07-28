#!/bin/bash

cd /home/$USER/config/
docker-compose stop
docker-compose up -d

ln -sf  /home/$USER/config/config/.bashrc /home/$USER/.bashrc
ln -sf  /home/$USER/config/config/.bash_aliases /home/$USER/.bash_aliases
ln -sf  /home/$USER/config/config/.vimrc /home/$USER/.vimrc
ln -sf  /home/$USER/config/config/.gitconfig /home/$USER/.gitconfig
ln -sf  /home/$USER/config/config/.gitconfig.user /home/$USER/.gitconfig.user

sudo ln -sf /home/$USER/config/usr/bin/php /usr/bin/php



