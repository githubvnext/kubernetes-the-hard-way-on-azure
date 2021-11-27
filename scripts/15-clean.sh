echo "Removing all the Azure Resources by removing the RG"
az group delete --name kubernetes --yes --no-wait

echo "removing the Certs and configs"
rm *.pem
rm *.csr
rm *.json
rm *config
