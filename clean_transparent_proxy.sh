#!/usr/bin/env bash



# Info about installing EMC certificates:

# https://gso.corp.emc.com/installupdatedcerts.aspx



echo "Setup certs"



CENTOS_DIR="/etc/pki/ca-trust/"

DEBIAN_DIR="/usr/local/share/ca-certificates/"



#List of certificates to copy

LIST_OF_CERTIFICATES="certs/emc-ca-bundle.crt certs/emc_ssl_decryption.crt"



copy_certificates () {

  for cert in ${LIST_OF_CERTIFICATES}

  do

    echo "Copying certificate " ${cert} " to " $1

    sudo cp ${cert} $1

  done

}



echo "Running clean transparent proxy ..."

if [ -d "${CENTOS_DIR}" ]

then

  echo "centos operating system"

  copy_certificates "${CENTOS_DIR}"



  sudo /bin/update-ca-trust

elif [ -d "${DEBIAN_DIR}" ]

then

  echo "Debian operating system"

  copy_certificates "${DEBIAN_DIR}"



  sudo update-ca-certificates

fi
