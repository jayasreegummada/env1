#!/bin/bash -eux



( (



chmod +x *.sh



source ./configuration.sh



# Remove libreoffice etc.

source  ./remove_useless_packages.sh



# Setup network

source  ./setup_network.sh



# Git

source  ./setup_git.sh



# Install prerequisites

source  ./setup_prereqs.sh



# Certs

source  ./clean_transparent_proxy.sh



# Small utils

source  ./setup_utils.sh



# Multiclipboard

source  ./setup_clipboard.sh



# Postman

source  ./setup_postman.sh



# Go

source  ./setup_golang.sh



# Python

source  ./setup_python.sh



# Text editors, gui tools

source  ./setup_dev_env.sh



# Midnight Commander

source  ./setup_mc.sh



# Pycharm

source  ./setup_pycharm.sh



# Ubuntu desktop tweaks

source  ./setup_desktop.sh



# Browser certs

source  ./setup_browser.sh



# Docker

INSTALL_ALL=1

source  ./setup_docker.sh



# Kubernetes

sg docker -c ./setup_k8s_single_node_cluster.sh



# Kubernetes Logging

pushd logs

sg docker -c ./setup_elk.sh

popd



# Istio service mesh

sg docker -c ./setup_istio.sh

# Something here was causing K8S to stop communicating with Docker

#sg docker -c ./configure_ngci_with_istio.sh

#source  ./configure_istio_certificates.sh



# Development repositories

# This need to be called outside of corp firewall

sg docker -c ./setup_dev_repos.sh



# Tests repo

sg docker -c  ./setup_test_repos.sh



# Ansible

source  ./setup_ansible_awx.sh



# Tools scripted, but not needed now

#source  ./setup_java.sh

#source  ./setup_vagrant.sh

#source  ./setup_virtualbox.sh



# Cleanup part



sudo apt-get autoremove -y

sudo apt-get clean -y

sudo apt-get autoclean -y



echo "Free space left:"

df -h



echo "Development environment setup finished"



# Cleanup history from setup commands

history -c

cat resources/common_commands.txt > /home/${SYSTEM_USER_NAME}/.bash_history



) 2>&1) | tee -a install_all.log
