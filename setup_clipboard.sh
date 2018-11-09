#!/bin/bash -eux



# Multiclipboard



if [ -z `which diodon` ]

then

    echo "Setup multiclipboard"

    sudo add-apt-repository -y ppa:diodon-team/stable

    sudo apt-get update -y

    sudo apt-get install -y diodon



    diodon &>/dev/null &disown;

else

    echo "Diodon already installed"

fi
