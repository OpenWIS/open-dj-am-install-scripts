#!/bin/bash
source ../deploy_config
  
  echo -e "\nretrieve identity card for user portal... "
  wget -O portal-meta.xml.user-portal "$USER_PORTAL_URL/saml2/jsp/exportmetadata.jsp"
  cp portal-meta.xml.user portal-meta.xml
   echo -e "\nregister user portal service provider..."
  ./service-prov.sh
  echo "done"

  echo -e "\nretrieve identity card for admin portal... "
  wget -O portal-meta.xml.admin-portal "$ADMIN_PORTAL_URL/saml2/jsp/exportmetadata.jsp"
  cp portal-meta.xml.admin portal-meta.xml
  echo -e "\nregister admin portal service provider..."
  ./service-prov.sh
  echo "done"

echo -e "\n*** Service providers registered ***"
