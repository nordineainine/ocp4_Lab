#!/bin/sh

while :
do
  for csr in $(oc get csr -ojson | jq -r '.items[] | select(.status == {} ) | .metadata.name'); do
    oc adm certificate approve ${csr}
  done
  if [ $(oc get csr | grep -i "system:node:" | grep -vi "system:node:master" | grep Approved | grep Issued | wc -l) -eq $1 ]; then
    break
  fi
done
