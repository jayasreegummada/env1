#!/bin/bash -eux



( (



if ! hash ansible 2>/dev/null

then

  # Add repos

  sudo apt-add-repository -y ppa:ansible/ansible

  sudo apt-get update

  sudo apt-get install -y ansible python-apt

fi



pushd ansible

ansible-playbook --inventory inventory.yaml playbooks/install_all.yml --ask-sudo-pass -v

popd





pushd ~/Development/repositories/packaging/bootstrap-third-party

#ansible-playbook -i inventories/devenv install.yml # Most playbooks are not prepared for dev env yet

ansible-playbook -i inventories/devenv install-logs.yml

popd



) 2>&1) | tee -a install_with_ansible.log
