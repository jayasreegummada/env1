#!/usr/bin/env bash



echo "Setup Istio certs"



CERT_DIR="certs/"



#List of certificates to copy

LIST_OF_SECRETS="tls.crt tls.key"



if [ -z "$1" ]

then

  echo "Missing istio secret path."

  exit -1

fi



ISTIO_SECRETS_PATH="$1"



copy_secrets () {

  for secret in ${LIST_OF_SECRETS}

  do

    echo "Copying secret " ${CERT_DIR}${secret} " to " ${ISTIO_SECRETS_PATH}

    cp ${CERT_DIR}${secret} ${ISTIO_SECRETS_PATH}

  done

}



chmod_secrets () {

  for secret in ${LIST_OF_SECRETS}

  do

    echo "Changing permission on " ${ISTIO_SECRETS_PATH}${secret}

    chmod 700 ${ISTIO_SECRETS_PATH}${secret}

  done

}



openssl genrsa -out ${CERT_DIR}tls.key 2048 -days 365



openssl req -new -sha256 -key ${CERT_DIR}tls.key -out ${CERT_DIR}tls.csr



openssl x509 -req -days 365 -in ${CERT_DIR}tls.csr -signkey ${CERT_DIR}tls.key -sha256 -out ${CERT_DIR}tls.crt



copy_secrets



chmod_secrets



#Create a secret on K8S

kubectl create -n istio-system secret tls istio-ingressgateway-certs --key "${ISTIO_SECRETS_PATH}"tls.key --cert "${ISTIO_SECRETS_PATH}"tls.crt



EXTERNAL_IP=`kubectl get svc -n istio-system | grep istio-ingressgateway | tr -s " " | cut -d' ' -f4`

if [ "${EXTERNAL_IP}" != "<pending>" ]

then

  INGRESS_GATEWAY_IP=${EXTERNAL_IP}

else

  INGRESS_GATEWAY_IP=`kubectl get svc -n istio-system | grep istio-ingressgateway | tr -s " " | cut -d' ' -f3`

fi



echo "${INGRESS_GATEWAY_IP}    ngci.localdomain" >> /etc/hosts
