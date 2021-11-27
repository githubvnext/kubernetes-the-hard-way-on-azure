az --version
az account list -o table

echo "Create Resource Group"

az group create -n kubernetes -l eastus2
