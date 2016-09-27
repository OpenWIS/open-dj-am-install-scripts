#!/bin/bash

function process_identity()
{
  item=$1
  echo -e "retrieve identity card for ${item}... "
  wget -O portal-meta.xml.${item} "http://wisp-asso.meteo.fr/openwis-${item}-portal/saml2/jsp/exportmetadata.jsp"
  cp portal-meta.xml.${item} portal-meta.xml
  echo -e "done"
  echo -e "\nregister ${item} service provider..."
  ./service-prov.sh
}

process_identity admin
process_identity user
