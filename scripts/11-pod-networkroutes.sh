echo "Print the internal IP address and Pod CIDR range for each worker instance:"

for instance in worker-0 worker-1; do
  PRIVATE_IP_ADDRESS=$(az vm show -d -g kubernetes -n ${instance} --query "privateIps" -otsv)
  POD_CIDR=$(az vm show -g kubernetes --name ${instance} --query "tags" -o tsv)
  echo $PRIVATE_IP_ADDRESS $POD_CIDR
done

## Routes

echo "Create network routes for each worker instance:"
az network route-table create -g kubernetes -n kubernetes-routes

az network vnet subnet update -g kubernetes \
  -n kubernetes-subnet \
  --vnet-name kubernetes-vnet \
  --route-table kubernetes-routes

for i in 0 1; do
az network route-table route create -g kubernetes \
  -n kubernetes-route-10-200-${i}-0-24 \
  --route-table-name kubernetes-routes \
  --address-prefix 10.200.${i}.0/24 \
  --next-hop-ip-address 10.240.0.2${i} \
  --next-hop-type VirtualAppliance
done



echo "List the routes in the `kubernetes-the-hard-way` VPC network:"

az network route-table route list -g kubernetes --route-table-name kubernetes-routes -o table

