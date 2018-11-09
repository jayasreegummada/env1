SYSTEM_USER_NAME=ngci

if [ 'root' != ${USER} ]; then

    SYSTEM_USER_NAME=${USER}

else

    SYSTEM_USER_NAME=$(bash -c 'echo $SUDO_USER')

fi

echo "System user name: $SYSTEM_USER_NAME"

GIT_USER_NAME=ngci

GIT_USER_EMAIL=ngci@dell.com

GIT_SSL_CA_PATH=/home/${SYSTEM_USER_NAME}/.ssh/EMC_CA_GIT_HUB_Combo.pem

WORKDIR=/home/${SYSTEM_USER_NAME}/Development

REPOS_DIR=${WORKDIR}/repositories



# The following will provide distribution details variables eg. :

#DISTRIB_ID=Ubuntu

#DISTRIB_RELEASE=16.04

. /etc/lsb-release



source ${BASH_SOURCE%/*}/functions.sh
