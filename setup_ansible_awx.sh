#!/bin/bash -eux



echo "Setup Ansible AWX"



# Install prerequisites

source ./configuration.sh

source ./setup_prereqs.sh



if ! hash ansible 2>/dev/null

then

  # Add repos

  sudo apt-add-repository -y ppa:ansible/ansible

  sudo apt-get update

  sudo apt-get install -y ansible



  # Install nvm to manage nodejs

  # See: https://github.com/creationix/nvm

  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

  . ~/.nvm/nvm.sh

  nvm install --lts node

  npm install --global npm@latest



  python -m pip install docker-py --user

fi





if ! [ -d "awx" ]

then

  # Install AWX

  git clone https://github.com/ansible/awx.git

  # To continue the AWX installation do the following:

  # 1. cd awx/installer

  # 2. Edit the config in the inventory file, change the docker port from 80 to 8080

  # 3. ansible-playbook -i inventory install.yml

fi



# Bash completion for Ansible

if ! [ -e /etc/bash_completion.d/ansible-completion.bash ]

then

  curl -L -O  https://raw.githubusercontent.com/dysosmus/ansible-completion/master/ansible-completion.bash

  sudo mv ansible-completion.bash /etc/bash_completion.d/ansible-completion.bash

  export ANSIBLE_COMPLETION_CACHE_TIMEOUT=120

  echo "export ANSIBLE_COMPLETION_CACHE_TIMEOUT=120" >> /home/${SYSTEM_USER_NAME}/.profile

  source /etc/bash_completion.d/ansible-completion.bash

fi
